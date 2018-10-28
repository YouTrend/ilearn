// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var initialize_calendar_home;
initialize_calendar_home = function() {
  $('.calendar_home').each(function(){
    var calendar = $(this);
    calendar.empty();
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek'
      },
      selectable: true,
      selectHelper: true,
      eventLimit: true,
      events: {
        url: '/events',
        type: 'GET',
        error: function() {
          alert('there was an error while fetching events!');
        },
      },
      locale: 'zh-tw',
      views: {
        month: { // name of view
          titleFormat: 'YYYY-MM'
          // other view-specific options here
        }
      },
      displayEventEnd:true,
      themeSystem: 'bootstrap3',
      eventClick: function(event, jsEvent, view) {
        window.location.href = event.url;
      }
    });
  })
};

$(document).on("turbolinks:load", function() {
  initialize_calendar_home();
});
