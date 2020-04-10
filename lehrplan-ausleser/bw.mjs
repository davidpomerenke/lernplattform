#!/usr/bin/env node
import request from 'sync-request'
import cheerio from 'cheerio'
import fs from 'fs'

const load = url =>
  cheerio.load(
    request('GET', url)
      .getBody()
      .toString())

String.prototype.format = function () { return this.replace(/(\n|\s|\t)+/g, ' ').trim() }

const baseUrl = 'http://www.bildungsplaene-bw.de'

const parsePage = (url) => {
  const $ = load(url)
  if ($('h1.basecontent-pbsbw---headline-h1').text().match(/Fachpläne/)) return parsePage(baseUrl + $('.slot-content a').eq(1).attr('href'))
  else return $('.tableGrid.hide-grid')
    .filter(function () { return $(this).children('thead').text().match(/Klasse/) })
    .map(function () {
      const klassenstufe = $(this).children('thead').text()
        .replace(/.*Klassen?\s*/, '')
        .replace(/[^\d\/]+/g, '')
      return $(this).find('tbody tr td a')
        .map(function () {
          const [_, nr, titel] = $(this).text().format()
            .match(/3\.(\d[\.\d]*)\s*(\S.*)/) || []
          const hatUntermodule = $(this).css('font-weight') !== 'bold' ||
            $(this).parent().parent().children()
              .filter(function () { return $(this).text().trim().length > 0 })
              .length === 1
          return {
            klassenstufe: klassenstufe,
            nr: nr,
            titel: titel,
            hatUntermodule: hatUntermodule,
            link: hatUntermodule
              ? baseUrl + $(this).attr('href')
              : url
          }
        }).get()
        .filter(a => a.nr && a.titel)
    }).get()
    .flatMap(a => {
      if (a.link) {
        const { beschreibung, untermodule } = parseDetail(a.link)
        return [
          { ...a, beschreibung: beschreibung },
          ...untermodule.map(b => ({
            klassenstufe: a.klassenstufe,
            nr: a.nr + '.' + b.nr,
            beschreibung: 'Die Schüler*innen können ' + b.beschreibung,
            link: a.link,
            hatUntermodule: false
          }))
        ]
      } else {
        return [a]
      }
    })
    .flatMap(a =>
      a.klassenstufe.match(/\d+/g)
        .map(b => ({ ...a, klassenstufe: b })))
}

const parseDetail = url => {
  const $ = load(url)
  return {
    beschreibung: $('h2.basecontent-pbsbw---headline-h1').parent().parent()
      .find('.teilkompetenzText').first().text().format(),
    untermodule: $('.teilkompetenzNumber').parent()
      .map(function () {
        return {
          nr: $(this).find('.teilkompetenzNumber').text().match(/\d+/)[0],
          beschreibung: $(this).find('.teilkompetenzText').text().format()
        }
      }).get()
  }
}

const parsePages = () => {
  const $ = load('http://www.bildungsplaene-bw.de/,Lde/LS/BP2016BW/ALLG')
  return $('#content-main ul').eq(0).find('li a')
    .map(function () {
      return {
        fach: $(this).text(),
        link: baseUrl + $(this).attr('href')
      }
    }).get().slice(0, 1)
    .flatMap(a => {
      console.log('Lese Grundschule / ' + a.fach)
      return parsePage(a.link)
        .flatMap(b => ({
          ...b,
          fach: a.fach,
          schulart: 'Grundschule',
          bundesland: 'Baden-Württemberg'
        }))
    })
}

const sequelise = a => `
  insert into Lehrplan 
    ( 'bundesland'
    , 'schulart'
    , 'fach'
    , 'klassenstufe'
    , 'lehrplantitel'
    , 'lehrplanbeschreibung'
    , 'lehrplanquelle'
    )
  values` + '\n' +
  a.map(b =>
      '    (' + [
        b.bundesland,
        b.schulart,
        b.fach,
        b.klassenstufe,
        b.titel || '',
        b.beschreibung || '',
        b.link || ''
      ].map(c => `'${c}'`).join(', ') + ')')
    .join(',\n')

fs.writeFile(
  'bw.sql',
  sequelise(parsePages()),
  'utf8',
  err => { if (err) console.log(err) })
