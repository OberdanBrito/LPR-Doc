dhtmlxEvent(window, "load", function () {

    let hist = [];

    let layout = new dhtmlXLayoutObject({
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
    });

    let list = layout.cells('a').attachList({
        container: "data_container",
        type: {
            template: "<b>Placa:</b> #placa#<br/><b>Nível de confiança:</b> #nivel_confianca#",
            height: 'auto'
        }
    });

    let wss = new WebSocket('ws://localhost:3000/');

    wss.onopen = function (event) {
        console.info('Websocket aberto com sucesso!', event);
    };

    wss.onclose = function(event) {
        console.warn('Atenção o websocket está fechado', event);
    };

    wss.onerror = function(event) {
        console.error('Erro websocket:', event);
    };

    wss.onmessage = function (event) {

        if (event.type !== 'message')
            return;

        let novaplaca = JSON.parse(JSON.parse(event.data).data.text.replace(/&quot;/g, '"'));

        hist.push(novaplaca);
        list.add(novaplaca, 0);

        layout.cells('b').attachURL(novaplaca.uuid);

        list.attachEvent("onItemClick", function (id){
            let item = hist.filter(function (item) {
                if (item.id === id)
                    return item;
            });
            layout.cells('b').attachURL(item[0].uuid);
            return true;
        });

        console.debug(novaplaca);

    };

});