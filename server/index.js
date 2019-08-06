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
    client: 'sqlite3',
    connection: {
        filename: process.env.SQ_FILENAME
    },
    useNullAsDefault: true,
    log: {
        warn:()=>{}
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

    response.status(200).send();
    send_ws_clients(request);
    insert_job(request);
    
});

function insert_job(request) {

    let
        job = request.body,
        regions_of_interest = request.body.regions_of_interest,
        results = request.body.results;

    show_plate(results);

    delete job.regions_of_interest;
    delete job.results;

    db('job')
        .insert(job, 'id')
        .then((result_job) => {

            let job_id = result_job[0];

            results.filter(function (item) {
                item.job = job_id;
                insert_results(item);
            });

            regions_of_interest.filter(function (item) {
               item.job = job_id;
                insert_regions(item);
            });

        });


}

function insert_results(request) {

    let {
        coordinates,
        candidates
    } = request;

    delete request.coordinates;
    delete request.candidates;

    db('results')
            .insert(request, 'id')
            .then((result) => {

                let results_id = result[0];

                coordinates.filter(function (item) {
                    item.results = results_id;
                    insert_coordinates(item);
                });

                candidates.filter(function (item) {
                    item.results = results_id;
                    insert_candidates(item);
                });

            });

}

function insert_coordinates(coordinate) {

    db('coordinates')
        .insert(coordinate, 'id')
        .then((result) => {
            return result[0];
        });

}

function insert_candidates(candidate) {

    db('candidates')
        .insert(candidate, 'id')
        .then((result) => {
            return result[0];
        });

}


function insert_regions(regions) {

    if (!regions)
        return;

    regions.filter(function (item) {
        db('results')
            .insert(item, 'id')
            .then((result) => {
                return result[0];
            });
    });

}

function send_ws_clients(request) {

    wss.clients.forEach(function (client) {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
                id: request.body.epoch_time,
                filedate: new Date().toLocaleString("pt-BR", {timeZone: "America/Sao_Paulo"}),
                camera_id: request.body.camera_id,
                plate: request.body.results[0].plate,
                confidence: request.body.results[0].confidence,
                uuid: request.body.uuid
            }));
        }
    });
    
}

function show_plate(result) {

    let {
        confidence,
        plate
    } = result[0];

    let
        cor = '\x1b[32m%s\x1b[0m',
        amarelo = '\x1b[33m%s\x1b[0m',
        vermelho = '\x1b[31m%s\x1b[0m';
    
    if (confidence < 88) {
        cor = amarelo;
    } else if (confidence < 85) {
        cor = vermelho;
    }
    
    console.log(cor, plate + ' ' + confidence);

}