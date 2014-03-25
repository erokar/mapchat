
addMarker = (map, latlong, title, content) ->
  markerOptions =
    position: latlong
    map: @map
    title: title
    clickable: true
  marker = new google.maps.Marker(markerOptions)
  infoWindowOptions =
    content: content
    position: latlong
  infoWindow = new google.maps.InfoWindow(infoWindowOptions)
  google.maps.event.addListener(marker, "click", -> infoWindow.open(@map))



# Position Position -> Number
# computes distance between to locations in kilometers
computeDistance = (startCoords, destCoords) ->
  
  degreesToRadians = (degrees) ->
    radians = (degrees * Math.PI) / 180 
    return radians
  
  startLatRads = degreesToRadians(startCoords.latitude)
  startLongRads = degreesToRadians(startCoords.longitude)
  destLatRads = degreesToRadians(destCoords.latitude)
  destLongRads = degreesToRadians(destCoords.longitude)
  Radius = 6371 # radius of the Earth in km
  distance = Math.acos(Math.sin(startLatRads) * Math.sin(destLatRads) + Math.cos(startLatRads) * Math.cos(destLatRads) * Math.cos(startLongRads - destLongRads)) * Radius
  return distance

locationError = (error) ->
  errorTypes =
    0: "Unknown error"
    1: "Permission denied by user"
    2: "Position is not available"
    3: "Request timed out"
  errorMessage = errorTypes[error.code]
  if error.code in [0,2]
    errorMessage += " " + error.message
  throwError(errorMessage)

@radiusVal = 500

showMap = (coords) ->
  googlePosition = new google.maps.LatLng(coords.latitude, coords.longitude)
  mapOptions =
    zoom: 14
    center: googlePosition
    mapTypeId: google.maps.MapTypeId.ROADMAP
  mapDiv = document.getElementById("googleMap")
  @map = new google.maps.Map(mapDiv, mapOptions)
  marker = new google.maps.Marker
    position: googlePosition
    map: @map
    title: "Center of Map"
  circle = new google.maps.Circle
    map: @map
    fillColor : '#BBD8E9'
    fillOpacity : 0.6
    radius : @radiusVal
    strokeColor : '#BBD8E9'
    strokeOpacity : 0.9
    strokeWeight : 2
  circle.bindTo('center', marker, 'position')

  #title = "Your location"
  #content = "You are here: " + coords.latitude + ", " + coords.longitude
  #addMarker(@map, googlePosition, title, content)
  #marker.setAllMap(null)



displayLocation = (position) ->
  latitude = position.coords.latitude
  longitude = position.coords.longitude
  div = document.getElementById("location")
  div.innerHTML = "You are at Latitude: " + latitude + ", Longitude: " + longitude
  # TODO: 
  # Få andre posisjoner i nærheten, send til showMap, dipslay dem på mappen
  Meteor.call("addPosition", position.coords)
  showMap(position.coords) #if not @map
  
Template.map.helpers
  location: ->
    if navigator.geolocation
      options =
        enableHighAccuracy: true
        maximumAge: 60000
      navigator.geolocation.getCurrentPosition(displayLocation, locationError, options)
    else
      throwError("You need geolocation enabled to use this app.")







