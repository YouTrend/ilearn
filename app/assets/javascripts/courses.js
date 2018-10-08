// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function() {

    var $addEventModal = $("#addEventModal");
    $addEventModal.find("#datetimepicker, #datetimepicker2").datetimepicker({
        format: 'HH:mm',
    });


    $(".ourses_new a, #courses_edit .day .panel-footer a").click(function() {

        debugger
        clear();

        var self = this;
        var selectedDate = moment($(this).parent().parent().find(".panel-heading").text().trim());

        $addEventModal.modal();

        $addEventModal.find("#buttonAdd").click(function() {

            var start_time = (function() {
                var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($addEventModal.find("#datetimepicker").data('date'), "HH:mm").format("HH:mm");

                return moment(dt_string).format("YYYY/MM/DD HH:mm")
            })();
            var end_time = (function() {
                var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($addEventModal.find("#datetimepicker2").data('date'), "HH:mm").format("HH:mm");

                return moment(dt_string).format("YYYY/MM/DD HH:mm")
            })();

            $addEventModal.find("#event_start_time").val(start_time);
            $addEventModal.find("#event_end_time").val(end_time);

        });


    });

    $("#new_event #buttonAdd").click(function() {

        if($addEventModal.find("#datetimepicker").data('date').trim() == ""){
            alert("時間不得為空");
            return false;
        }
        
        if($addEventModal.find("#datetimepicker2").data('date').trim() == ""){
            alert("時間不得為空");
            return false;
        }  

        debugger
        $addEventModal.find("[name='event[name]']").val($("#course_name").val());
        $(this).closest("form").submit();
    })



    $("#courses_new .day .start-end-time").click(function() {
        clear();

        $addEventModal.modal();
    });

    $addEventModal.find("#buttonCancel").click(function() {

        $addEventModal.modal("hide");
        $addEventModal.find("#buttonAdd").unbind("click")
    });

    function clear() {
        $addEventModal.find("#datetimepicker").data('DateTimePicker').clear();
        $addEventModal.find("#datetimepicker2").data('DateTimePicker').clear();
    }
});

$(document).on("turbolinks:load", function() {
    $("#input_students_autocomplete").autocomplete({
        source: "/students/search_auto_complete"
    }).keypress(function(e) {

        code = (e.keyCode ? e.keyCode : e.which);

        if (code == 13)
            search()

    });


    $("#button_search_student").click(search);

    function search() {
        var url = "/students/search.json?name=" + $("#input_students_autocomplete").val();

        $.ajax(url)
            .done(function(json) {
                $("#dataTables-students > tbody").empty();

                $(json).each(function(key, value) {
                    debugger
                    $("<tr/>").append($("<td><a href='/students/" + value.id + "/edit'>" + value.name + "<a></td>"))
                        .append($("<td>" + value.grade + "</td>"))
                        .append($('<td><a class="add_student" href="' + value.id + '"><button type="button" class="btn btn-primary btn-xs">加入</button></a></td>'))
                        .appendTo($("#dataTables-students > tbody"))

                });


                $("#dataTables-students > tbody .add_student").click(function() {
                    debugger
                    var $clone = $(this).parent().parent().clone();
                    var student_id = $(this).attr("href");
                    var $remove_td = $('<td><a class="remove_student" href="' + student_id + '"><button type="button" class="btn btn-primary btn-xs">移出</button></a></td>')


                    $('<input id="students__student_id" type="hidden" name="students[]student[id]"></input>').appendTo($remove_td).val(student_id)

                    $remove_td.find(".remove_student").click(function() {

                        debugger
                        $(this).parent().parent().remove()

                        return false;
                    });


                    $clone.children("td:eq(2)").replaceWith($remove_td)


                    $clone.appendTo($("#dataTables-students-added > tbody"))

                    return false;
                });

            })
            .fail(function(jqxhr, textStatus, error) {
                var err = textStatus + ", " + error;
                console.log("Request Failed: " + err);
            });
    }

});