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

const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 3000 });

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
           filedate: new Date().toLocaleString("pt-BR", {timeZone: "America/Sao_Paulo"}),
           camera_id: request.body.camera_id,
           plate: results.plate,
           confidence:results.confidence
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

let t = {"version":2,"data_type":"alpr_results","epoch_time":1564684472088,"img_width":1280,"img_height":720,"processing_time_ms":316.861176,"regions_of_interest":[],"results":[{"plate":"G8U8266","confidence":88.541321,"matches_template":0,"plate_index":0,"region":"br","region_confidence":0,"processing_time_ms":24.387512,"requested_topn":1,"coordinates":[{"x":563,"y":78},{"x":717,"y":74},{"x":719,"y":121},{"x":566,"y":125}],"candidates":[{"plate":"G8U8266","confidence":88.541321,"matches_template":0}]}],"uuid":"p1-cam1-1564684472408","camera_id":1,"site_id":"p1","company_id":"craos"}
