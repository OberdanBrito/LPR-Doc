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
    console.log(`Serviço de importação para arquivos slpr.db executando na porta ${port}.`)
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
});

app.post('/input', function(req, res) {
    console.log(req.files.foo); // the uploaded file object
});