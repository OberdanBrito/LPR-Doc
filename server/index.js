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

    let verde = '\x1b[32m%s\x1b[0m';
    let amarelo = '\x1b[33m%s\x1b[0m';
    let vermelho = '\x1b[31m%s\x1b[0m';
    let cor = null;
    if (results.confidence > 88) {
        cor = verde
    } else if (results.confidence < 88) {
        cor = amarelo;
    } else if (results.confidence < 85) {
        cor = vermelho;
    }
    console.log(cor, 'camera_id:' + request.body.camera_id + ' ' + results.plate + ' ' + results.confidence);

    let trace = request.body;
    delete trace.results;

    trace.plate = results.plate;
    trace.confidence = results.confidence;

    db('trace')
        .insert(trace)
        .returning('id')
        .then((result) => {
            return result;
        })


});