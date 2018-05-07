// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on("turbolinks:load", function(){

	var $addEventModal = $("#addEventModal");
	$addEventModal.find("#datetimepicker, #datetimepicker2").datetimepicker({
	        format: 'HH:mm',
	});		

	$("#courses_new .day .panel-footer a").click(function(){

		debugger
		clear();

		var self = this;
		var selectedDate = moment($(this).parent().parent().find(".panel-heading").text().trim());

		$addEventModal.modal();

	    $addEventModal.find("#buttonAdd").click(function(){

	    	var start_time = (function(){
	    		var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($addEventModal.find("#datetimepicker").data('date'), "HH:mm").format("HH:mm");

				return moment(dt_string).format("YYYY/MM/DD HH:mm")
	    	})();
	    	var end_time = (function(){
	    		var dt_string = selectedDate.format("YYYY/MM/DD") + " " + moment($addEventModal.find("#datetimepicker2").data('date'), "HH:mm").format("HH:mm");

				return moment(dt_string).format("YYYY/MM/DD HH:mm")
	    	})();

	    	$addEventModal.find("#event_start_time").val(start_time);
	    	$addEventModal.find("#event_end_time").val(end_time);
	    	debugger

    	});   


	});

	$("#courses_new .day .start-end-time").click(function(){
		clear();

		$addEventModal.modal();
	});

    $addEventModal.find("#buttonCancel").click(function(){

    	$addEventModal.modal("hide");
    });

	function clear(){
		$addEventModal.find("#datetimepicker").data('DateTimePicker').clear();
		$addEventModal.find("#datetimepicker2").data('DateTimePicker').clear();		
	}
});