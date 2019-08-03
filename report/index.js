require('custom-env').env();

const express = require('express');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');

const app = express();
const port = process.env.HTTP_PORT;

app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);

app.use(favicon(__dirname + '/favicon.ico'));

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
    console.log(`Relatorios LPR ${port}.`)
});

app.get('/', (request, response) => {
    response.status(200).send('ok');
});