require('custom-env').env();

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
        port: process.env.PG_PORT,
        user: process.env.PG_USER,
        password: process.env.PG_PASSWORD,
        database: process.env.PG_DATABASE
    }
});

app.listen(port, () => {
    console.log(`Serviço de identificação LPR executando na porta ${port}.`)
});

const WebSocket = require('ws');

const wss = new WebSocket.Server({port: process.env.WS_PORT});

wss.on('connection', function connection(ws) {
    ws.on('message', function incoming(data) {
        wss.clients.forEach(function each(client) {
            if (client !== ws && client.readyState === WebSocket.OPEN) {
                client.send(data);
            }
        });
    });
});

app.post('/', (request, response) => {

    console.debug(request.body);
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
    wss.clients.forEach(function (client) {
        client.send(JSON.stringify({
            id: request.body.epoch_time,
            filedate: new Date().toLocaleString("pt-BR", {timeZone: "America/Sao_Paulo"}),
            camera_id: request.body.camera_id,
            plate: results.plate,
            confidence: results.confidence,
            uuid:request.body.uuid
        }));
    });

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