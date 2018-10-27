// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap_sb_admin_base_v2
//= require bootstrap-modal
//= require bootstrap-modalmanager
//= require moment
//= require bootstrap-datetimepicker
//= require fullcalendar
//= require fullcalendar/locale-all
//= require bootstrap-colorselector


//= require common


//= require_tree .


$(document).on("turbolinks:load", function() {});

$('#input_index_autocomplete').on('keyup', function() {
    var input = $(this);
    if(input.val().length === 0) {
        input.addClass('input-text-search-empty');
    } else {
        input.removeClass('input-text-search-empty');
    }
});

$(document).on("turbolinks:load", function() {
    $("#input_index_autocomplete").autocomplete({
        source: "/students/search_auto_complete"
    }).keypress(function(e) {

        code = (e.keyCode ? e.keyCode : e.which);

        if (code == 13)
            index_to_search()

    });


    $("#button_search_index").click(index_to_search);

    function index_to_search() {
        var url = "/students/search.json?name=" + $("#input_index_autocomplete").val();

        $.ajax(url)
            .done(function(json) {
                debugger 

                window.location.href = window.location.origin + "/students/" + json[0].id + "/edit";

            })
            .fail(function(jqxhr, textStatus, error) {
                var err = textStatus + ", " + error;
                console.log("Request Failed: " + err);
            });
    }

});