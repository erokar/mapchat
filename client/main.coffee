

class Map

  constructor: (coords, @mapDiv) ->
    @position = new google.maps.LatLng(coords.latitude, coords.longitude)
    mapOptions =
      zoom: 14
      center: @position
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map(@mapDiv, mapOptions)

  drawMarker: (coords, peers = false) ->
    pinImage = undefined
    pinShadow = undefined
    if peers
      pinColor = "fcf357"
      pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
        new google.maps.Size(21, 34),
        new google.maps.Point(0,0),
        new google.maps.Point(10, 34))
      pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(0, 0),
        new google.maps.Point(12, 35))
    latLong = new google.maps.LatLng(coords.latitude, coords.longitude)
    marker = new google.maps.Marker
      position: latLong
      map: @map
      title: "You"
      icon: pinImage
      shadow: pinShadow
    @marker = marker

  drawInfo: (content) ->
    infoWindowOptions =
      content: content
      position: @position
    infoWindow = new google.maps.InfoWindow(infoWindowOptions)
    google.maps.event.addListener(@marker, "click", -> infoWindow.open(@map))

    
  drawCircle: (radius) ->
    circle = new google.maps.Circle
      map: @map
      fillColor : '#BBD8E9'
      fillOpacity : 0.6
      radius : radius
      strokeColor : '#BBD8E9'
      strokeOpacity : 0.9
      strokeWeight : 2
    circle.bindTo('center', @marker, 'position')  


# *************

@radius = 500

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

displayLocation = (position) ->
  map = new Map(position.coords, document.getElementById("googleMap"))
  map.drawMarker(position.coords)
  map.drawCircle(@radius)
  map.drawInfo("FART") # TODO: User name
  
  Meteor.subscribe "positions", position.coords, @radius, ->
    Positions.find().forEach (pos) ->
      console.log("called")
      map.drawMarker(pos.coordinates, peers = true)
  
  Meteor.call( "addPosition", position.coords, (error, result) ->
    Session.set("positionId", result)
    console.log("ID: " + Session.get("positionId"))
  )

window.onload = ->
  if navigator.geolocation
    options =
      enableHighAccuracy: true
      maximumAge: 60000
    navigator.geolocation.getCurrentPosition(displayLocation, locationError, options)
  else
    throwError("You need geolocation enabled to use this app.")
  Meteor.call("clientConnect")

window.onbeforeunload = -> Meteor.call("clientDisconnect", Session.get("positionId"))





