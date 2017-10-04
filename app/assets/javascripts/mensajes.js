// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

	$('#mensaje_texto').keyup(function(){
    console.log('hello x world');
		var len = $(this).val().length;
    $('#mensaje-count').text(160 - len);
	});

	$('#directo_sms').keyup(function(){
    console.log('hello x world');
		var len = $(this).val().length;
    $('#sms-count').text(160 - len);
	});

});
