import express from 'express'
import cors from 'cors'
import pg from 'pg'
const app = express()

app.use(cors({ credentials: true, origin: true }))
app.options('*', cors())

app.get('/', (request, result) => {
  const client = new pg.Client({ connectionString: process.env.DATABASE_URL, ssl: true })
  client.connect()
  client.query('SELECT * FROM Lehrplan', (error, result) => {
    if (error) throw error
    result.json(result)
    client.end()
  })
})

const port = process.env.PORT || 3000
app.listen(port, (error) => console.log(error || `Server running on port ${port}.`))
