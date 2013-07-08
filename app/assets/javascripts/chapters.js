
$().ready(function() {
	$("#geocode").change(function() {if ($("#geocode").prop("checked")) { $("#chapter_latitude").val("").attr("readonly","true"); $("#chapter_longitude").val("").attr("readonly","true"); } else { $("#chapter_latitude").removeAttr("readonly"); $("#chapter_longitude").removeAttr("readonly");}})
	$("body.home.index #state").change(submitChapterSearch);
	$("body.home.index #distance").change(submitChapterSearch);

});

function submitChapterSearch() {
	(($("#state option:selected").val() != "") || ($("#zip").val() != "")) && $("form.chapter-search").submit();
}

