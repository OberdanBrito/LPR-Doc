dhtmlxEvent(window, "load", function () {

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
    })

});