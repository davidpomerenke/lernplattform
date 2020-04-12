pg = require('pg')

module.exports = (request, result) => {
  String.prototype.sqlList = function () { return '(' + this.split(';').map(a => `'${a}'`).join(', ') + ')' }
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
      query(
        'select distinct a.Bundesland, b.Schulname as Schulart, a.Klassenstufe ' +
        'from Lehrplan a join Schulartenbedeutung b on a.Schulart = b.Schulbedeutung;',
        a => result.json(a.rows))
      break
    case 'fächer':
      query(`select distinct Fach from Lehrplan where
        Bundesland   = '${request.query.bundesland}' and
        Schulart     = (select schulbedeutung from schulartenbedeutung where schulname = '${request.query.schulart}') and
        Klassenstufe in ${request.query.klassenstufen.sqlList()};`,
        a => result.json(a.rows))
      break
    case 'lehrplan':
      query(`select * from Lehrplan a join LehrplanDetails b on a.lehrplanid = b.id where
          Bundesland   = '${request.query.bundesland}' and
          Schulart     = (select schulbedeutung from schulartenbedeutung where schulname = '${request.query.schulart}') and
          Klassenstufe in ${request.query.klassenstufen.sqlList()} and
          Fach         in ${request.query.fächer.sqlList()};`,
        a => result.json(a.rows))
      break
    default:
      result.status(404).send()
  }
  //.cookie('passwort', 'baum', { expires: new Date(Date.now() + 31 * 24 * 60 * 60 * 1000), secure: true })
}
