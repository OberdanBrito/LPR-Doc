dhtmlxEvent(window, "load", function () {

    // noinspection JSMismatchedCollectionQueryUpdate
    let hist = [], layout = new dhtmlXLayoutObject({
        parent: document.body,
        pattern: '2U',
        offsets: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0
        },
        cells: [
            {
                id: 'a',
                text: 'Placas',
                header: true,
                width: 280,
            },
            {
                id: 'b',
                text: 'Imagem',
                header: true
            }
        ]
    }), list = layout.cells('a').attachList({
        container: "data_container",
        type: {
            template: "<b>Data:</b>#filedate# <br/><b>Câmera:</b>#camera_id# <br/><b>Placa:</b> #plate#<br/><b>Nível de confiança:</b> #confidence#",
            height: 'auto'
        }
    }), wss = new WebSocket('ws://localhost:3000/');

    wss.onopen = function (event) {
        console.info('Websocket aberto com sucesso!', event);
    };

    wss.onclose = function (event) {
        console.warn('Atenção o websocket está fechado', event);
    };

    wss.onerror = function (event) {
        console.error('Erro websocket:', event);
    };

    wss.onmessage = function (event) {

        if (event.type !== 'message')
            return;

        let data = JSON.parse(event.data);

        hist.push(data);
        list.add(data, 0);

        layout.cells('b').attachURL('../../storage/' + data.uuid + '.jpg', false, false);

        list.attachEvent("onItemClick", function (id) {
            hist.filter(function (item) {
                if (item.id === id)
                    layout.cells('b').attachURL(item.uuid, false, false);
            });
            return true;
        });

    };

});