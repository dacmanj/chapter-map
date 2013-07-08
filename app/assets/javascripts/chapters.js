
$().ready(function() {
	$("#geocode").change(function() {if ($("#geocode").prop("checked")) { $("#chapter_latitude").val("").attr("readonly","true"); $("#chapter_longitude").val("").attr("readonly","true"); } else { $("#chapter_latitude").removeAttr("readonly"); $("#chapter_longitude").removeAttr("readonly");}})
	$("body.home #state").change(submitChapterSearch);
	$("body.home #distance").change(submitChapterSearch);
	$("a.btn.reset-search").click(clearSearch);
});

function clearSearch(e) {
	var form = $(this).parent()[0]
	form.reset();
	$("select",form).val("")
	form.submit();
	return false;
}

function submitChapterSearch() {
	(($("#state option:selected").val() != "") || ($("#zip").val() != "")) && $("form.chapter-search").submit();
}

