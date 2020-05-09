import request from 'sync-request'
import cheerio from 'cheerio'
import fs from 'fs'

// Hilfsfunktionen zum Scrapen

// Seite laden und mit Cheerio parsen, kann dann wie mit jQuery ausgelesen werden
export const load = url =>
  cheerio.load(
    request('GET', url, {
      // Gegen Scraping-Schutz des Servers
      headers: {
        'user-agent':
          'Mozilla/5.0 (X11; Ubuntu; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 RuxitSynthetic/1.0 v4977106381 t55095'
      }
    })
      .getBody()
      .toString()
  )

// String von Zeilenumbrüchen, mehrfachen Leerzeichen, etc. bereinigen
String.prototype.format = function () {
  return this.replace(/(\n|\s|\t)+/g, ' ').trim()
}

const baseUrl = 'https://www.lehrplanplus.bayern.de'

const parseSchularten = () => {
  const $ = load(
    // Bei Schulart Förderschule sind alle Schularten sichtbar, daher diese URL
    'https://www.lehrplanplus.bayern.de/schulart/grundschule/inhalt/fachlehrplaene?w_schulart=foerderschule&wt_1=schulart'
  )
  return [
    // Nicht-Förderschulen
    ...$('#step-1 > ul > li > a')
      .map(function () {
        const schulartfeld = $(this).text().format()
        // Mittelschule = Hauptschule, daher intern diesen
        // unnötigen zusätzlichen Begriff weglassen
        const schulart =
          schulartfeld === 'Mittelschule' ? 'Hauptschule' : schulartfeld
        return parseFächer(baseUrl + $(this).attr('href'), schulart, 2).map(
          a => ({
            ...a,
            schulart: schulart
          })
        )
      })
      .get(),
    // Förderschulen (sind eine Unterliste)
    ...$('#step-1 > ul > li > ul > li > a')
      .map(function () {
        const schulart = 'Förderschule ' + $(this).text().format()
        return parseFächer(baseUrl + $(this).attr('href'), schulart, 3).map(
          a => ({
            ...a,
            schulart: schulart
          })
        )
      })
      .get()
  ].flatMap(a => ({ ...a, bundesland: 'Bayern' }))
}

const parseFächer = (url, schulart, i) => {
  const $ = load(url)
  return $(`#step-${i} ul li a`)
    .map(function () {
      const fach = $(this).text().format()
      return parseKlassenstufen(
        baseUrl + $(this).attr('href'),
        schulart,
        fach,
        i + 1
      ).map(a => ({
        ...a,
        fach:
          a.ausprägung.length === 0
            ? fach
            : a.ausprägung.match(fach)
            ? a.ausprägung
            : fach + ' : ' + a.ausprägung
      }))
    })
    .get()
    .flat(1)
}

const parseKlassenstufen = (url, schulart, fach, i) => {
  const $ = load(url)
  return $(`#step-${i} ul li a`)
    .map(function () {
      const klassenstufe = parseInt($(this).text().format())
      console.log('Bayern', schulart, fach, klassenstufe)
      const pageUrl = $(this).attr('href')
      let page = parseInhalte(baseUrl + pageUrl, i + 1)
      return page.map(a => ({
        ...a,
        klassenstufen: [klassenstufe]
      }))
    })
    .get()
    .flat(1)
}

const parseAusprägungen = (url, i) => {
  const $ = load(url)
  return $(`#step-${i} ul li a`)
    .map(function () {
      return parseInhalte(baseUrl + $(this).attr('href')).map(a => ({
        ...a,
        ausprägung: $(this).text().format()
      }))
    })
    .get()
    .flat(1)
}

const parseInhalte = (url, i) => {
  const $ = load(url)
  if ($(`#step-${i}`).length) {
    return parseAusprägungen(url, i)
  } else {
    return $('.headline_lvl1, .headline_lvl2')
      .map(function () {
        const überschrift = $(this)
          .children('h3, h4')
          .children('a')
          .children('span')
        const hierarchie = überschrift
          .eq(0)
          .text()
          .match(/\d+(\.\d+)*/g)
        if (!hierarchie) return []
        return [
          {
            titel: überschrift
              .eq(1)
              .text()
              .replace(/\(ca. \d+ Std.\)/, '')
              .format(),
            beschreibung: '',
            nr: hierarchie[1]
          },
          ...$(this)
            .find('.thema_absch')
            .eq(1)
            .children('ul')
            .children('li')
            .map(function (j) {
              return {
                titel: '',
                beschreibung: $(this).text().format(),
                nr: hierarchie + '.' + (j + 1).toString()
              }
            })
            .get()
        ].map(a => ({ ...a, link: url, ausprägung: '' }))
      })
      .get()
      .flat(1)
  }
}

// Speichern
const ergebnis = parseSchularten()

/* 
// Zum Nachjustieren, ohne neu scrapen zu müssen:
// Dateinamen entsprechend anpassen und nachher manuell umbenennen.
const ergebnis = JSON.parse(
  fs.readFileSync('by2.json', { encoding: 'utf8' })
).map(a => ({ ...a, fach: a.fach.replace(/xxx/, '') }))
*/

fs.writeFile('by1.json', JSON.stringify(ergebnis, null, 2), 'utf8', err => {
  if (err) console.log(err)
})
