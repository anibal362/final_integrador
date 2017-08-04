$(function () {
    $("#btn_Registrar").click(function () {
        var form = $("#frm-registroUsuario");

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