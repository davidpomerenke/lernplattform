pg = require('pg')

module.exports = (request, result) => {
  const query = (_query, callback) => {
    const client = new pg.Client({ ssl: { rejectUnauthorized: false } })
    client.connect()
    client.query(_query, (pgError, pgResult) => {
      client.end()
      if (pgError) result.status(500).send(pgError)
      else callback(pgResult)
    })
  }
  switch (request.query.name) {
    case 'start':
      query(`select distinct Bundesland, Schulart, Klassenstufe from Lehrplan;`, a => result.json(a.rows))
      break
    case 'links':
      query(`select * from
        SelbstlernRessource natural join Zuordnung join Lehrplan on (Zuordnung.Modul = Lehrplan.Modul) where
        Bundesland   = '${request.query.bundesland}' and
        Schulart     = '${request.query.schulart}'   and
        Klassenstufe = '${request.query.klassenstufe}';`,
        a => result.json(a.rows))
      break
    default:
      result.status(404).send()
  }
  //.cookie('passwort', 'baum', { expires: new Date(Date.now() + 31 * 24 * 60 * 60 * 1000), secure: true })
}
