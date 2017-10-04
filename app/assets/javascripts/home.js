// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var removeParent = function(e){
  $("#mensaje-"+$(e).data('mensaje')+" .reply-form > .row").remove();
};

$(document).ready(function(){
  $("#mensaje_texto").autosize();
});

