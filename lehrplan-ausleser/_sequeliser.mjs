import fs from 'fs'

const data = code =>
  JSON.parse(fs.readFileSync(code + '.json', { encoding: 'utf8' }))

const format = a => a.replace(/'/g, "''")

// Ergebnis als SQL formatieren, um es in die Datenbank einzufügen
const sequelise = einträge =>
  einträge
    .map(
      eintrag =>
        (
          `
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
      returning lehrplanid
    )
  insert into lehrplan
    ( bundesland
    , schulart_intern
    , fach
    , klassenstufe
    , lehrplanid
    )
  values` +
          eintrag.klassenstufen
            .map(
              klassenstufe => `
    ( '${format(eintrag.bundesland)}'
    , '${format(eintrag.schulart)}'
    , '${format(eintrag.fach)}'
    , '${format(klassenstufe.toString())}'
    , (select lehrplanid from row)
    )`
            )
            .join(',')
        ).replace(/\n/g, '') + `;`
    )
    .join('\n')

const save = code =>
  fs.writeFile(code + '.sql', sequelise(data(code)), 'utf8', err => {
    if (err) console.log(err)
  })

for (const a of ['bw', 'by']) save(a)
