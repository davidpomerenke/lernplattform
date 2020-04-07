pg = require('pg')

module.exports = (request, result) => {
  switch (request.query.name) {
    case 'kursermittlung':
      const client = new pg.Client({ ssl: { rejectUnauthorized: false } })
      client.connect()
      if ('bundesland' in request.query) {
        client.query(`SELECT DISTINCT Schulart FROM Lehrplan where Bundesland = '${request.query.bundesland}';`, (pgError, pgResult) => {
          client.end()
          if (pgError) result.status(500).send(pgError)
          else result.json(pgResult.rows.map(a => a.schulart))
        })
      } else if ('schulart' in request.query) {
        client.query(`SELECT DISTINCT Klassenstufe FROM Lehrplan where Schulart = '${request.query.schulart}';`, (pgError, pgResult) => {
          client.end()
          if (pgError) result.status(500).send(pgError)
          else result.json(pgResult.rows.map(a => a.klassenstufe))
        })
      }
      break;
    default:
      result.status(404)
  }
  //.cookie('passwort', 'baum', { expires: new Date(Date.now() + 31 * 24 * 60 * 60 * 1000), secure: true })
}
