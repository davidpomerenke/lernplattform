pg = require('pg')

module.exports = (request, result) => {
  const query = (_query, callback) => {
    const client = new pg.Client({ ssl: { rejectUnauthorized: false } })
    client.connect()
    client.query(_query, (pgError, pgResult) => {
      client.end()
      if (pgError) result.send(pgError)
      else callback(pgResult)
    })
  }
  switch (request.query.name) {
    case 'start':
      query(
        'select distinct a.Bundesland, b.Schulname as Schulart, a.Klassenstufe ' +
          'from Lehrplan a join Schulartenbedeutung b on a.Schulart = b.Schulbedeutung;',
        a => result.json(a.rows)
      )
      break
    case 'fächer':
      query(
        `select distinct Fach, Klassenstufe from Lehrplan where
        Bundesland   = '${request.query.bundesland}' and
        Schulart     = (select schulbedeutung from schulartenbedeutung where schulname = '${request.query.schulart}') and
        Klassenstufe in (` +
          JSON.parse(request.query.klassenstufen)
            .map(a => `'${a}'`)
            .join(', ') +
          ');',
        a => result.json(a.rows)
      )
      break
    case 'lehrplan':
      query(
        `select * from Lehrplan a join LehrplanDetails b on a.lehrplanid = b.id where
        Bundesland   = '${request.query.bundesland}' and
        Schulart     = (select schulbedeutung from schulartenbedeutung where schulname = '${request.query.schulart}') and (` +
          JSON.parse(request.query.fächer)
            .map(
              a => `(Klassenstufe = '${a.klassenstufe}' and Fach = '${a.fach}')`
            )
            .join(' or ') +
          ');',
        a => result.json(a.rows)
      )
      break
    default:
      result.status(404).send()
  }
}
