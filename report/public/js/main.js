dhtmlxEvent(window, "load", function () {

    new dhtmlXLayoutObject({
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

    $.ajax({
        url: 'http://localhost:9002/teste',
        type: 'GET',
        dataType: 'json',
        success: function (response) {
            console.debug(response);
        },
        error: function (request, status, error) {
            console.error(request, status, error)
        }
    });
});