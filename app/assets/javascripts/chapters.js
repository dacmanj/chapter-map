
$().ready(function() {
	$("#geocode").change(function() {if ($("#geocode").prop("checked")) { $("#chapter_latitude").val("").attr("readonly","true"); $("#chapter_longitude").val("").attr("readonly","true"); } else { $("#chapter_latitude").removeAttr("readonly"); $("#chapter_longitude").removeAttr("readonly");}})
	$("body.home #state").change(submitChapterSearch);
	$("body.home #distance").change(submitChapterSearch);
	$("a.btn.reset-search").click(clearSearch);
	$('body.chapters.edit form').submit(function() {  
	    var valuesToSubmit = $(this).serialize();
	    $.ajax({
	        url: $(this).attr('action'), //sumbits it to the given url of the form
	        data: valuesToSubmit,
	        dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
	        type: 'POST'
	    });
	    return false; // prevents normal behaviour
	});



});

function clearSearch(e) {
	var form = $(this).closest("form")[0];
	console.log(form);
	form.reset();
	$("select",form).val("")
	form.submit();
	return false;
}

function submitChapterSearch() {
	(($("#state option:selected").val() != "") || ($("#zip").val() != "")) && $("form.chapter-search").submit();
}

