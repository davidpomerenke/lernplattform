import express from 'express'
import cors from 'cors'
const app = express();

app.use(cors({ credentials: true, origin: true }))
app.options('*', cors())

app.get('/', (request, result) => {
    result.json({ a: "b" })
})

const port = process.env.PORT || 3000
app.listen(port, (err) => console.log(err || `Server running on port ${port}.`))
