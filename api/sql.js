pg = require('pg')

module.exports = (anfrage, antwort) => {
    const client = new pg.Client({
      user: 'anonymous',
      host: 'lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com',
      database: 'lernplattform',
      password: 'notreallyapassword',
      ssl: { rejectUnauthorized: false }
    })
    client.connect()
    client.query(anfrage.body, (postgresFehler, postgresAntwort) => {
      client.end()
      if (postgresFehler) antwort.send(postgresFehler)
      else antwort.json(postgresAntwort.rows)
    })
}
