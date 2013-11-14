# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if markers_json?
    handler = Gmaps.build('Google')
    handler.buildMap { provider: {}, internal: {id: 'map'}}, -> 
      markers = handler.addMarkers markers_json
      handler.bounds.extendWith markers
      handler.fitMapToBounds()
      zoom = handler.getMap().getZoom()
      handler.getMap().setZoom 8 unless (zoom < 8)


$ ->
  $("div.rainbowNavigationTop").click ->
	  window.location.href = $("a",$(this)).attr("href")
  $("div.rainbowNavigationTop").width($("td.rainbowNavigationTop").siblings().width()/4-12)

