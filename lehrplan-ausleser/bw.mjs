#!/usr/bin/env node
import request from 'sync-request'
import cheerio from 'cheerio'
import fs from 'fs'

// Seite laden und mit Cheerio parsen, kann dann wie mit jQuery ausgelesen werden
const load = url =>
  cheerio.load(
    request('GET', url)
      .getBody()
      .toString())

// String von Zeilenumbrüchen, mehrfachen Leerzeichen, etc. bereinigen
String.prototype.format = function () { return this.replace(/(\n|\s|\t)+/g, ' ').trim() }

const baseUrl = 'http://www.bildungsplaene-bw.de'

// Von der Liste aller Fächer starten und alle Module auslesen
const parsePages = () => {
  const $ = load('http://www.bildungsplaene-bw.de/,Lde/LS/BP2016BW/ALLG')
  // Liste der Fächer auslesen
  // nr: Stelle der Tabelle auf Website
  const listeAuslesen = (nr, schulart, spalte, einspaltig) =>
    $('#content-main ul').eq(nr).find('li a')
      .map(function () {
        return {
          fach: $(this).text(),
          link: baseUrl + $(this).attr('href')
        }
      }).get()//.slice(0, 1)
      // Module aller Fächer auslesen und zusammenfügen
      .flatMap(a => {
        console.log(`Lese ${schulart} / ${a.fach}`)
        return parsePage(a.link, schulart, spalte, einspaltig)
          .flatMap(b => ({
            ...b,
            schulart: schulart,
            fach: a.fach,
            bundesland: 'Baden-Württemberg'
          }))
      })
  return [
    // Die Schularten in BaWü sind kompliziert,
    // und die Aufteilung der Lehrpläne ist auch kompliziert.
    // vgl. den Aufbau der Listen auf der Website
    // vgl. https://www.service-bw.de/lebenslage/-/lebenslage/Niveaustufen+und+Ebenen-5001562-lebenslage-0 zu den Niveaus
    // vgl. SQL-Tabelle 'Schulartenbedeutung', die das einzufangen versucht
    // vgl. parseDetail()
    // Grundschule, eazy
    { nr: 0, schulart: 'Grundschule', spalte: 0, einspaltig: false },
    // Haupt-/Werkrealschule, Grundl. Niveau (Gemeinschafts- + Realschule)
    { nr: 1, schulart: 'Hauptschule', spalte: 0, einspaltig: false }, 
    // Mittleres Niveau (Gemeinschafts- + Realschule)
    { nr: 1, schulart: 'Realschule', spalte: 1, einspaltig: false }, 
    // Erweitertes Niveau (Gemeinschaftsschule): Unter- und Mittelstufe
    { nr: 1, schulart: 'Gemeinschaftsschule', spalte: 2, einspaltig: false }, 
    // Erweitertes Niveau (Gymnasium)
    { nr: 2, schulart: 'Gymnasium', spalte: 0, einspaltig: true },
    // Erweitertes Niveau (Gemeinschaftsschule): Oberstufe
    { nr: 3, schulart: 'Gemeinschaftsschule', spalte: 0, einspaltig: true }
  ].flatMap(a => listeAuslesen(a.nr, a.schulart, a.spalte, a.einspaltig))
}

// Liste der Module eines Fachs auslesen
const parsePage = (url, schulart, spalte, einspaltig) => {
  const $ = load(url)
  // Falls es mehrere Versionen gibt, die zweite auswählen
  // (die erste ist normalerweise für das kommende Schuljahr)
  if ($('h1.basecontent-pbsbw---headline-h1').text().match(/Fachpläne/)) return parsePage(baseUrl + $('.slot-content a[href]').eq(1).attr('href'))
  else return $('.tableGrid.hide-grid')
    // Tabellen mit Klassenstufen-Angaben auswählen
    .filter(function () { return $(this).children('thead').text().match(/Klasse/) })
    .map(function () {
      const klassenstufen = $(this).children('thead').text()
        .replace(/.*Klassen?\s*/, '')
        .replace(/[^\d\/]+/g, '')
        .match(/\d+/g)
      // Module auslesen
      return $(this).find('tbody tr td a')
        .map(function () {
          // Modulnummer und Titel auslesen
          const [_, nr, titel] = $(this).text().format()
            .match(/3\.(\d[\.\d]*)\s*(\S.*)/) || []
          // Fettgeschriebene Module, die mit anderen Modulen in einer Zeile stehen,
          // haben keine eigenen Teilkompetenzen, sondern verlinken (verwirrenderweise)
          // die Teilkompetenzen des ersten Untermoduls in der selben Zeile;
          // Fettgeschriebene Module, die alleine in einer Zeile stehen,
          // haben dagegen eigene Teilkompetenze
          const hatTeilkompetenzen = $(this).css('font-weight') !== 'bold' ||
            $(this).parent().parent().children()
              .filter(function () { return $(this).text().trim().length > 0 })
              .length === 1
          return {
            klassenstufen: klassenstufen,
            nr: nr,
            titel: titel,
            hatTeilkompetenzen: hatTeilkompetenzen,
            // Link nur speichern, wenn das Modul auch eigene Teilkompetenzen hat
            link: hatTeilkompetenzen
              ? baseUrl + $(this).attr('href')
              : url
          }
        }).get()
        .filter(a => a.nr && a.titel)
    }).get()
    // Teilkompetenzen für jedes Modul auslesen
    .flatMap(a => {
      if (a.link) {
        const { beschreibung, teilkompetenzen } = parseDetail(a.link, schulart, spalte, einspaltig)
        return [
          // Beschreibung zum Modul hinzufügen
          { ...a, beschreibung: beschreibung },
          // Teilkompetenzen als weitere Module hinzufügen
          ...teilkompetenzen.map(b => ({
            klassenstufen: a.klassenstufen,
            nr: a.nr + '.' + b.nr,
            titel: '',
            beschreibung: 'Die Schülerinnen und Schüler können ' + b.beschreibung,
            link: a.link,
            hatTeilkompetenzen: false
          }))
        ]
      } else {
        return [a]
      }
    })
    // Wenn Module für mehrere Klassenstufen angegeben sind,
    // dann für jede Klassenstufe eigenen Eintrag erstellen
    // .flatMap(a => a.klassenstufe.map(b => ({ ...a, klassenstufe: b })))
}

// Teilkompetenzen eines Moduls auslesen
const parseDetail = (url, schulart, spalte, einspaltig) => {
  const $ = load(url)
  return {
    beschreibung: $('h2.basecontent-pbsbw---headline-h1').parent().parent()
      .find('.teilkompetenzText').first().text().format(),
    teilkompetenzen: $('table.tkfull.tktable tbody')
      // Beim Gymnasium ist die relevante Klasse im td, nicht im tr ...
      .find(einspaltig ? 'tr' : 'tr.ITK_GS_ZEILE, tr.ITK_GS_ZEILE_SPAN, tr.ITK_S1_ZEILE_TK_SINGLE, tr.ITK_G8_TK')
      .map(function () {
        return $(this).find(einspaltig ? 'td.ITK_G8_TK' : 'td')
          .filter(function () { return $(this).find('.teilkompetenzNumber').length })
          .eq(spalte)
          .map(function () {
            return {
              nr: $(this).find('.teilkompetenzNumber').text().match(/\d+/)[0],
              beschreibung: $(this).find('.teilkompetenzText').text().format()
            }
          }).get()
      }).get()
  }
}

// Speichern
const ergebnis = parsePages()
fs.writeFile('bw.json', JSON.stringify(ergebnis, null, 2),
  'utf8', err => { if (err) console.log(err) })
