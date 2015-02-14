$(function(){
    // hide it first
    $("#spinner").hide();

    // when an ajax request starts, show spinner
    $(document).ajaxStart(function(){
        $("#spinner").show();
    });

    // when an ajax request complets, hide spinner
    $(document).ajaxStop(function(){
        $("#spinner").hide();
    });
});
