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


  clearChapterSearch = ->
    $("input#zip,select",".chapter-search").val("").closest("form").submit()

  clearSearch = (e) ->
    window.location.href = window.location.href
    false

  submitChapterSearch = () ->
    (($("#state option:selected").val() != "") || ($("#zip").val() != "")) && $("form.chapter-search").submit();

  #$("body.chapters.edit form").submit => submitAjax

  submitAjax = (e) -> 
    valuesToSubmit = $(this).serialize
    $.ajax { url: $(this).attr('action'), data: valuesToSubmit, dataType: "JSON", type: 'POST' }
    false


  $("body.home #state").change submitChapterSearch
  $("body.home #distance").change submitChapterSearch
  $(".chapter-search button.reset-search").click clearSearch