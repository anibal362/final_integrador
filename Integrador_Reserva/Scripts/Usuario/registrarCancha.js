$(function () {
    $("#btn_RegistrarCancha").click(function () {
        var form = $("#frm-registroCancha");

        $.ajax({
            url: form.attr("action"),
            type: "POST",
            data: form.serialize(),
            success: function (data) {
                alert(data);
                window.location.href = "/Usuario/ListaUsuarios";
            }
        })

    })

})