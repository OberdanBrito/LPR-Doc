require('custom-env').env('staging');

const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = process.env.HTTP_PORT;

app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);

const db = require('knex')({
    client: 'pg',
    connection: {
        host: process.env.PG_HOST,
        user: process.env.PG_USER,
        password: process.env.PG_PASSWORD,
        database: process.env.PG_DATABASE
    }
});

app.listen(port, () => {
    console.log(`Serviço de identificação LPR executando na porta ${port}.`)
});

app.post('/', (request, response) => {

    response.status(200).send();

    let results = request.body.results[0];
    console.debug(request.body);

    let trace = request.body;
    delete trace.results;

    trace.plate = results.plate;
    trace.confidence = results.confidence;

    db('trace')
        .insert(trace)
        .returning('id')
        .then((result) => {
            console.debug('trace id:', result[0]);
            return result;
        })


});