# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if markers_json?
    handler = Gmaps.build('Google')
    handler.buildMap { provider: {auto_adjust: "true", auto_zoom: "true"}, internal: {id: 'map'}}, -> 
      markers = handler.addMarkers markers_json
      handler.bounds.extendWith markers
      handler.fitMapToBounds()
