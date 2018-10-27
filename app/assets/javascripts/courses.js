// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var calendarOptions = {
    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: {
        url: window.location.href + '/events',
        type: 'GET',
        error: function() {
          alert('there was an error while fetching events!');
        },
      },
      //events: '/courses/show_events.json',
      locale: 'zh-tw',
      views: {
        month: { // name of view
          titleFormat: 'YYYY-MM'
          // other view-specific options here
        }
      },
      displayEventEnd:true,
      themeSystem: 'bootstrap3',
      select: function(start, end) {
        //$.getScript('/events/new', function() {
        //    $('.start_date').val(moment(start).format('YYYY-MM-DD'));
        //});
        
        $('#addEventModal').find("#buttonAdd").bind("click")
        $('#addEventModal').find('.start_date').val(moment(start).format('YYYY-MM-DD'));
        $('#addEventModal').modal('show');
        setSelectColor(1,'#FF0000','red');
        calendar.fullCalendar('unselect');
      },

      eventDrop: function(event, delta, revertFunc) {
        event_data = { 
          event: {
            id: event.id,
            start_time: event.start.format(),
            end_time: event.end.format(),
            color: event.color,
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },
      eventClick: function(event, jsEvent, view) {
        debugger
        var data = event;
        //先以第一次載入資料作修改,getJSON可取得最新資料
        //$.getJSON(event.edit_url, function( data ) {
          //var form_action = $('#updateEventModal').find("#new_event").attr("action") + "/" + event.id;
          //$('#updateEventModal').find("#new_event").attr("action", form_action);
          $('#updateEventModal').find("#buttonAdd").bind("click")
          $('#updateEventModal').find('.start_date').val(moment(data.start).format("YYYY-MM-DD"))
          $('#updateEventModal').find("#datetimepicker").datetimepicker('date', data.start);
          $('#updateEventModal').find("#datetimepicker2").datetimepicker('date', data.end);
          $('#updateEventModal').find("#colorselector").colorselector("setColor", data.color);
          $('#updateEventModal').find("#event_id").val(data.id);
          $('#updateEventModal').find("form")[0].action = event.update_url
          $('#updateEventModal').modal('show');
        //});
      }
  };
var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    debugger
    var calendar = $(this);
    calendar.empty();
    calendar.fullCalendar(calendarOptions);
    var $addEventModal = $("#addEventModal");
    var $updateEventModal = $("#updateEventModal");
    setEventModal($addEventModal);
    setEventModal($updateEventModal);
  })
};
function setSelectColor(value, color, title) {
    $("#colorValue").val(value);
    $("#colorColor").val(color);
    $("#colorTitle").val(title);
}


$(document).on("turbolinks:load", function() {
    initialize_calendar();
});
function resetEventModal(modal) {

}
function setEventModal(modal) {
    var $modal = modal
    $modal.find(".dropdown-colorselector").remove();
    $modal.find("#colorselector").colorselector({
        callback: function (value, color, title) {
          setSelectColor(value, color, title)
      }
    });
    $modal.find("#datetimepicker, #datetimepicker2").datetimepicker({
        format: 'HH:mm',
    });
    $modal.find("#buttonAdd").click(function(e) {
        debugger
        var start = $modal.find("#datetimepicker").data('date') != undefined ? $modal.find("#datetimepicker").data('date') : "";
        var end = $modal.find("#datetimepicker2").data('date') != undefined ? $modal.find("#datetimepicker2").data('date') : "";
        if(start.trim() == "" || end.trim() == ""){
            alert("時間不得為空");
            return false;
        }
    
        var selectedDate = moment($modal.find(".start_date")[0].value);
        var start_time = (function() {
            var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($modal.find("#datetimepicker").data('date'), "HH:mm").format("HH:mm");
    
            return moment(dt_string).format("YYYY/MM/DD HH:mm")
        })();
        var end_time = (function() {
            var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($modal.find("#datetimepicker2").data('date'), "HH:mm").format("HH:mm");
    
            return moment(dt_string).format("YYYY/MM/DD HH:mm")
        })();
        var color = $("#colorColor").val()
        $modal.find("#event_start_time").val(start_time);
        $modal.find("#event_end_time").val(end_time);
        $modal.find("#event_color").val(color);
    
        $modal.find("[name='event[name]']").val($("#course_name").val());
        $(this).closest("form").submit();
        $modal.modal("hide");
    
    });
    
    $modal.find("#buttonCancel").click(function() {
        $modal.modal("hide");
        clear();
    });

    $modal.find("#buttonDestory").click(function() {
        debugger
        $modal.find("form")[0].action += "/destroy"
        $(this).closest("form").submit();
        $modal.modal("hide");
    });
    
    
    function clear() {
        $modal.find("#datetimepicker").data('DateTimePicker').clear();
        $modal.find("#datetimepicker2").data('DateTimePicker').clear();
    }
}


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