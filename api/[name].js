pg = require('pg')

module.exports = (anfrage, antwort) => {
  const abfragen = (_query, callback) => {
    const client = new pg.Client({ ssl: { rejectUnauthorized: false } })
    client.connect()
    client.query(_query, (postgresFehler, postgresAntwort) => {
      client.end()
      if (postgresFehler) antwort.send(postgresFehler)
      else callback(postgresAntwort)
    })
  }
  switch (anfrage.query.name) {
    case 'start':
      {
        const abfrage = `
        select distinct
          Bundesland, Schulart, Klassenstufe 
        from 
          Lehrplan natural join Schulartenbedeutung;`
        abfragen(abfrage, a => antwort.json(a.rows))
      }
      break
    case 'fächer':
      {
        const klassenstufen = JSON.parse(anfrage.query.klassenstufen).map(a => `'${a}'`).join(', ')
        const abfrage = `
        select distinct 
          Fach, Klassenstufe 
        from 
          Schulartenbedeutung natural join Lehrplan
        where
          Bundesland = '${anfrage.query.bundesland}' and
          Schulart = '${anfrage.query.schulart}' and
          Klassenstufe in (${klassenstufen});`
        abfragen(abfrage, a => antwort.json(a.rows))
      }
      break
    case 'lehrplan':
      {
        const bedingungen = JSON.parse(anfrage.query.fächer)
          .map(
            a => `(Klassenstufe = '${a.klassenstufe}' and Fach = '${a.fach}')`
          )
          .join(' or ')
        const abfrage = `
        select * from 
          (
            Schulartenbedeutung
            natural join Lehrplan 
            natural join Lehrplandetails
          )
          natural left join 
          (
            Lehrplanzuordnung
            natural join Materialzuordnung
            natural join Material
          )
        where
          Bundesland = '${anfrage.query.bundesland}' and
          Schulart = '${anfrage.query.schulart}' and 
          (${bedingungen});`
        abfragen(abfrage, a => antwort.json(a.rows))
      }
      break
    default: {
      antwort.status(404).send()
    }
  }
}
