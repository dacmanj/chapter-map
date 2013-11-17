# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#geocode").change -> 
    if $("#geocode").prop("checked")
      $("#chapter_latitude").val("").attr("readonly","true")
      $("#chapter_longitude").val("").attr("readonly","true")
    else
      $("#chapter_latitude").removeAttr("readonly")
      $("#chapter_longitude").removeAttr("readonly")

  $("body.chapters.edit form").submit submitAjax

submitAjax = (e) -> 
  valuesToSubmit = $(this).serialize
  $.ajax { url: $(this).attr('action'), data: valuesToSubmit, dataType: "JSON", type: 'PUT' }
  e.preventDefault()
  $(window).scrollTop(0)
  false