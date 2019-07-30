const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 8000

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.listen(port, () => {
  console.log(`Servico de identifi ${port}.`)
})

app.post('/', (request, response) => {
  console.debug(request.body);
	response.status(200).send();
})
