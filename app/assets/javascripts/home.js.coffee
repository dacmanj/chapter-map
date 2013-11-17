# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Gmaps.store = {}
Gmaps.store.markers = {}
Gmaps.store.HandleDragend = (pos) ->
  geocoder = new google.maps.Geocoder();
  geocoder.geocode { latLng: pos }, (responses) ->
    if responses?
      #alert "Updated Display Location to #{responses[0].formatted_address}\n(#{responses[0].geometry.location.lat()},#{responses[0].geometry.location.lng()}"
      $("#chapter_latitude").val(responses[0].geometry.location.lat());
      $("#chapter_longitude").val(responses[0].geometry.location.lng());
    else
      alert 'Cannot determine address at this location.'
    $("body.chapters.edit form").submit()

$ ->
  $("div.rainbowNavigationTop").click ->
    window.location.href = $("a",$(this)).attr("href")
  $("div.rainbowNavigationTop").width($("td.rainbowNavigationTop").siblings().width()/4-12)
  
$ ->


  buildMap = (markers_json) ->
    if markers_json?
      draggable_markers = ($("body.chapters.edit").length > 0)
      Gmaps.store.handler = Gmaps.build('Google')
      handler = Gmaps.store.handler;
      handler.buildMap { provider: {}, internal: {id: 'map'}}, -> 
        markers = handler.addMarkers markers_json, {draggable: draggable_markers}
        handler.bounds.extendWith markers
        handler.fitMapToBounds()
        zoom = handler.getMap().getZoom()
        handler.getMap().setZoom 1
        zoom = Math.max(3,Math.min(zoom,8))
        handler.getMap().setZoom zoom
        if (draggable_markers)
          for marker in markers
            google.maps.event.addListener marker.serviceObject, 'dragend', ->
              Gmaps.store.HandleDragend this.getPosition()
      true

  chapterSearch = -> 
    form = $("body.home form.chapter-search")
    searchParams = form.serialize()
    $.ajax({ url: "/pflag.json", data: searchParams }).done (data) ->
      Gmaps.store.markers = data
      buildMap data
    $.ajax {url: "/show_chapters.js", data: searchParams }, (data) ->
      $("#chapter-listings").html data

  zipChange = (e) ->
    form = $("body.home form.chapter-search")
    zip = $("#zip",form)
    state = $("#state",form)
    distance = $("#distance",form)
    state.val("")

  stateSelectChange = (e) ->
    form = $("body.home form.chapter-search")
    zip = $("#zip",form)
    state = $("#state",form)
    distance = $("#distance",form)
    zip.val("")
    distance.val("")
    submitChapterSearch(e)

  clearChapterSearch = ->
    $("input#zip,select",".chapter-search").val("").closest("form")
    chapterSearch()
    $("#chapter-listings").html("")

  clearSearch = (e) ->
    clearChapterSearch()
    e.preventDefault()
    false

  showAllChapters = ->
    clearChapterSearch()
    $("body.home form.chapter-search").submit()

  submitChapterSearch = (event) ->
    chapterSearch()
    $(window).scrollTop($("#map").position().top)
    event.preventDefault()
    false

  buildMap markers_json if markers_json?
  $("body.home #state").change stateSelectChange
  $("body.home #zip").change zipChange
  $("body.home #distance").change submitChapterSearch
  $("body.home form.chapter-search").submit submitChapterSearch
  $("body.home #show-all-button").click showAllChapters
  $("form.chapter-search button.reset-search").click clearSearch
