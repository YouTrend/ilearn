// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function addStudent() {
    $('form').submit();
    jdats = $("form").serializeArray();
    $.ajax({
    type: "POST",
    //async為false -> 同步 
    //async為true  -> 非同步
    async: false,   
    dataType: "json",
    url: "http://localhost:7574/User",
    contentType: 'application/json; charset=UTF-8',
    data: objectifyForm(jdats) 
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