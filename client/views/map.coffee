
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



showMap = (coords) ->
  googlePosition = new google.maps.LatLng(coords.latitude, coords.longitude)
  mapOptions =
    zoom: 10
    center: googlePosition
    mapTypeId: google.maps.MapTypeId.ROADMAP
  mapDiv = document.getElementById("googleMap")
  @map = new google.maps.Map(mapDiv, mapOptions)



displayLocation = (position) ->
  latitude = position.coords.latitude
  longitude = position.coords.longitude
  div = document.getElementById("location")
  div.innerHTML = "You are at Latitude: " + latitude + ", Longitude: " + longitude
  #return "You are at Latitude: " + latitude + ", Longitude: " + longitude
  showMap(position.coords)
  
Template.map.helpers
  location: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(displayLocation, locationError);
    else
      throwError("You need geolocation enabled to use this app.")

#window.onload = getMyLocation






