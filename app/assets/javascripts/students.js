// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function addStudent() {
    $('form').submit();
    addStudent_to_zkteco();
}

function addStudent_to_zkteco() {
  var student_id_val = $("form").find("#student_afts_id").val();
  var student_name_val = $("form").find("#student_name").val();
  var jdata = {userid:student_id_val,name:student_name_val};
  $.ajax({
    method: "POST",
    url: "http://localhost:7574/User",
    data: jdata,
    dataType: 'json',
    accept: {
        json: 'application/json'
    },
    async: true,

  });

  return false;
}

function objectifyForm(formArray) {//serialize data function

    var returnArray = {};
    for (var i = 0; i < formArray.length; i++){
      returnArray[formArray[i]['name']] = formArray[i]['value'];
    }
    return returnArray;
}