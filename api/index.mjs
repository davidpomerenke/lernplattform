import express from 'express'
import cors from 'cors'
import pg from 'pg'
const app = express()

app.use(cors({ credentials: true, origin: true }))
app.options('*', cors())

app.get('/', (request, result) => {
  let query = ''
  if ('bundesland' in request.query) {
    query = `SELECT Schulart FROM Lehrplan where Bundesland = '${request.query.bundesland}';`
  }
  if (query) {
    const client = new pg.Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
    client.connect()
    client.query(query, (pgError, pgResult) => {
      client.end()
      if (pgError) throw pgError
      result
        .json([request, pgResult.rows])
        .cookie('passwort', 'baum', { expires: new Date(Date.now() + 31 * 24 * 60 * 60 * 1000), secure: true })
    })
  } else {
    result.json(request)
  }
})

const port = process.env.PORT || 3000
app.listen(port, (error) => { if (error) { throw error } else { console.log(`Server running on port ${port}.`) } })
