"use strict";

const WebSocket = require('ws').Server;
const wss = new WebSocket({
    port: 2000
});


function noop() {
}

function heartbeat() {
    this.isAlive = true;
}

console.debug(new Date(), 'Iniciando o serviço websockect');

const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'smt',
    password: 'yu45thn@',
    port: 5432,
});

let placas = [];

pool.query('BEGIN; CREATE TEMPORARY TABLE lpr AS SELECT * FROM public.lprlist; COMMIT;', (errorquery) => {

    if (errorquery) {
        throw errorquery
    }

    pool.query('SELECT * FROM lpr', (error, results) => {

        if (error) {
            throw error
        }

        placas = results.rows;
        console.debug(new Date(), 'Placas cadastradas: ', results.rowCount);
    });

});

wss.on('connection', function connection(ws) {

    ws.isAlive = true;
    ws.on('pong', heartbeat);

    ws.onmessage = function (messagem) {

        wss.clients.forEach(function each(client) {
            if (client !== ws && client.readyState === WebSocket.OPEN) {
                let data = JSON.parse(messagem);
                client.send(JSON.stringify(data));
            }
        });

    };

});

const interval = setInterval(function ping() {

    wss.clients.forEach(function each(ws) {

        if (ws.isAlive === false) return ws.terminate();
        ws.isAlive = false;
        ws.ping(noop);
    });
}, 30000);

const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 8080;

app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);

app.post('/lpr', function (request, response) {

    let {
        version,
        data_type,
        epoch_time,
        img_width,
        img_height,
        processing_time_ms,
        regions_of_interest,
        results,
        uuid,
        camera_id,
        site_id,
        company_id
    } = request.body;

    response.status(200).send();

    let placa = results[0].plate;

    if (placa.length !== 7)
        return;

    let info = placas.find(x => x.placa === placa);

    if (info !== undefined) {

        console.debug(new Date(), info, JSON.stringify(request.body));

        /*pool.query("INSERT INTO lpr.log(placa, nivel, uuid) VALUES ('$1', '$2', '$3')", [info.placa, info.nivel], (error, results) => {

            if (error) {
                throw error
            }

        });*/

    } else {
        console.debug(new Date(), request.body);
    }

    console.debug();


});

app.listen(port, () => {
    console.log(`App running on port ${port}.`)
});
