$(document).ready(function (e) {
    $('.search-panel .dropdown-menu').find('a').click(function (e) {
        e.preventDefault();
        var param = $(this).attr("href").replace("#", "");
        var concept = $(this).text();
        $('.search-panel span#search_concept').text(concept);
        $('.input-group #search_param').val(param);
    });
});

$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
});

$(function () {
    $("#btn_SearchCancha").click(function () {
        var form = $("#frm-searchCancha");

        $.ajax({
            url: form.attr("action"),
            type: "post",
            data: form.serialize(),
            success: function () {
            window.location.href = "/publico/busqueda";
        }
        })

    })

})