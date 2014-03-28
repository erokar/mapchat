
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
  @coords = position.coords
  map = new Map(position.coords, document.getElementById("googleMap"))
  map.drawMarker(position.coords)
  map.drawCircle(@radius)
  map.drawInfo("FART") # TODO: User name
  Meteor.subscribe "messages"
  

Meteor.startup ->

#window.onload = ->
  if navigator.geolocation
    options =
      enableHighAccuracy: true
      maximumAge: 60000
    navigator.geolocation.getCurrentPosition(displayLocation, locationError, options)
  else
    throwError("You need geolocation enabled to use this app.")
  #Meteor.call("clientConnect")


window.onbeforeunload = -> 
  #Meteor.call("clientDisconnect", Session.get("positionId"))




###  Meteor.subscribe "positions", position.coords, @radius, ->
    Positions.find().forEach (pos) ->
      console.log("called")
      map.drawMarker(pos.coordinates, peers = true)
###  
###  Meteor.call( "addPosition", position.coords, (error, result) ->
    Session.set("positionId", result)
    console.log("ID: " + Session.get("positionId"))
  )###

