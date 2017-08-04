$(function () {
    $("#btn-buscar").click(function () {
        $.ajax({
            url: "/Usuario/ListaUsuarios",
            type: "POST",
            data: { Nombre: $("#txt_Nombre").val() },
            success: function (data) {

                $("#IDGrid").html(data);
            }
        })

    })

    $("#btn-Nuevo").click(function () {
        window.location = "/Usuario/Registrar";
    })
    $("#btn-Nueva_cancha").click(function () {
        window.location = "/Usuario/RegistrarCancha";
    })
})

function funcDelete(ID) {
    alert(ID);
}