# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Gmaps.store = {}
Gmaps.store.map
Gmaps.store.vars = []
Gmaps.store.markers = {}
Gmaps.store.rebuildMap = false
Gmaps.store.HandleDragend = (pos) ->
  geocoder = new google.maps.Geocoder();
  geocoder.geocode { latLng: pos }, (responses) ->
    if responses?
      #alert "Updated Display Location to #{responses[0].formatted_address}\n(#{responses[0].geometry.location.lat()},#{responses[0].geometry.location.lng()}"
      $("#chapter_latitude").val(responses[0].geometry.location.lat());
      $("#chapter_longitude").val(responses[0].geometry.location.lng());
      $("#chapter_position_lock").prop("checked",true)
      $("body.chapters.edit form").submit()
    else
      alert 'Cannot determine address at this location.'

$ ->
  $("div.rainbowNavigationTop").click ->
    window.location.href = $("a",$(this)).attr("href")
  $("div.rainbowNavigationTop").width($("td.rainbowNavigationTop").siblings().width()/4-12)
  
$ ->

  q = document.URL.split('?')[1]
  if q?
    q = q.split('&')
    for i in q
      hash = i.split('=')
      Gmaps.store.vars.push(hash[1])
      Gmaps.store.vars[hash[0]] = hash[1]

  Gmaps.store.buildMap = (markers_json) ->
    if markers_json?
      draggable_markers = ($("body.chapters.edit").length > 0 || $("body.chapters.new").length > 0)
      handler_options = {markers: {clusterer: null} } unless cluster?
      Gmaps.store.handler = Gmaps.build('Google', options = handler_options)
      handler = Gmaps.store.handler
      handler.buildMap { provider: {}, internal: {id: 'map'}}, -> 
        Gmaps.store.markers = handler.addMarkers markers_json, {draggable: draggable_markers}
        handler.bounds.extendWith Gmaps.store.markers
        handler.fitMapToBounds()
        zoom = handler.getMap().getZoom()
        handler.getMap().setZoom 1
        zoom = Math.max(3,Math.min(zoom,8))
        handler.getMap().setZoom zoom
        if zoom == 3
          handler.getMap().setCenter(new google.maps.LatLng(38.2722002603348,-104.619597467049))
        if (draggable_markers)
          for marker in Gmaps.store.markers
            google.maps.event.addListener marker.serviceObject, 'dragend', ->
              Gmaps.store.HandleDragend this.getPosition()
      true
      Gmaps.store.map = handler.getMap()

  chapterSearch = -> 
    form = $("body.home form.chapter-search")
    zip = $("#zip").val()
    state = $("#state").val()
    latitude = $("#latitude")
    longitude = $("#longitude")
    if zip? and state == ""
      geocoder = new google.maps.Geocoder()
      geocoder.geocode { 'address': zip.toString() }, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          latitude.val results[0].geometry.location.lat()
          longitude.val results[0].geometry.location.lng()
        else
          alert("address not found!")
        if results.length > 1
          alert("Warning! Multiple results found by Google, you may want to try a more specific search.")
        ajaxSearch()
    else
      ajaxSearch()


  ajaxSearch = ->
    searchParams = $("body.home form.chapter-search").serialize()
    zipV = $("#zip").val()
    stateV = $("#state").val()
    latitude = $("#latitude")
    longitude = $("#longitude")
    latlng = latitude.val() + ", " + longitude.val()
    latlng = "" if latlng = ", "
    if zipV?
      ga 'send', 'event', 'zip search', "#{zipV}"
    else
      ga 'send', 'event', 'state search', "#{stateV}"
    $.ajax({ url: "/pflag.json", data: searchParams }).done (data) ->
      Gmaps.store.markers = data if data[0]?
      Gmaps.store.buildMap data if data[0]?
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
    $(window).scrollTop($("#chapter-listings").position().top)
    event.preventDefault()
    false

  Gmaps.store.buildMap markers_json if markers_json?
  $("body.home #state").change stateSelectChange
  $("body.home #zip").change zipChange
  $("body.home #distance").change submitChapterSearch
  $("body.home form.chapter-search").submit submitChapterSearch
  $("body.home #show-all-button").click showAllChapters
  $("button.reset-search").click clearSearch
  
  $("#delete_multiple_users").submit (e) ->
    marked = new Array()
    k = 0
    $("input:checked[name*=user_ids]").each (i,v) ->
      marked[k] = $(v).val()
      k++
    marked = marked.join(",")
    mf = $("<input/>",{type: "hidden", name: "user_ids[]", value: marked})
    $("#delete_multiple_users").append(mf)

  $("#chapter_position_lock").change -> 
    if $("#chapter_position_lock").prop("checked") 
      console.log "Position Locked" if console?
    else
      Gmaps.store.rebuildMap = true
      $("body.chapters.edit form").submit()

  updateAjax = (data) ->
    if console?
      console.log("Latitude #{data.latitude}")
      console.log("Longitude #{data.longitude}")
    $("#chapter_latitude").val(data.latitude)
    $("#chapter_longitude").val(data.longitude)
    markers_json[0].lat = data.latitude
    markers_json[0].lng = data.longitude
    markers_json[0].infowindow = data.infowindow
    Gmaps.store.buildMap markers_json if markers_json
    true

  submitAjax = (e) -> 
    e.preventDefault()
    valuesToSubmit = $(@).serialize()
    url = $(@).attr('action')
    $.ajax { url: url, data: valuesToSubmit, dataType: "JSON", type: 'PUT', success: updateAjax }
    $(window).scrollTop(0)
    true

  $("body.chapters.edit form").submit submitAjax

  if Gmaps.store.vars["zip"]?
    chapterSearch()

  true