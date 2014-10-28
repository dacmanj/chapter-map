# Note: This example requires that you consent to location sharing when
# prompted by your browser. If you see a blank space instead of the map, this
# is probably because you have denied permission for location sharing.

$ ->
   $("#search-near-me-button").click searchNearMe
   searchNearMe = ->
     navigator.geolocation.getCurrentPosition (position) ->
        pos = new google.maps.LatLng position.coords.latitude, position.coords.longitude
        console.log pos.toString()
        infowindow = new google.maps.InfoWindow { map: Gmaps.store.map, position: pos, content: 'Location found using HTML5.' }
        $("#zip").val pos.toString()
        $("form.chapter-search").submit()

   searchNearMe() if SEARCH_NEAR_ME?
