import fs from 'fs'

const bw = JSON.parse(fs.readFileSync('bw.json', { encoding: 'utf8' }))

const format = a => a
  .replace(/'/g, "''")

// Ergebnis als SQL formatieren, um es in die Datenbank einzufügen
const sequelise = einträge => einträge.map(eintrag => (`
  with row as
    ( insert into lehrplandetails
        ( titel
        , beschreibung
        , hierarchie
        , quelle
        )
      values
        ( '${format(eintrag.titel || '')}'
        , '${format(eintrag.beschreibung || '')}'
        , '${format(eintrag.nr || '')}'
        , '${format(eintrag.link || '')}'
        )
      returning id
    )
  insert into lehrplan
    ( bundesland
    , schulart
    , fach
    , klassenstufe
    , lehrplanid
    )
  values` + eintrag.klassenstufen.map(klassenstufe => `
    ( '${format(eintrag.bundesland)}'
    , '${format(eintrag.schulart)}'
    , '${format(eintrag.fach)}'
    , '${format(klassenstufe)}'
    , (select id from row)
    )`).join(',')).replace(/\n/g, '') + `;`).join('\n')

fs.writeFile('bw.sql', sequelise(bw),
  'utf8', err => { if (err) console.log(err) })