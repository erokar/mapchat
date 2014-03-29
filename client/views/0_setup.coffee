


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

@displayLocation = (position) ->
  Session.set("coords", position.coords)
  @map = new Map(position.coords, document.getElementById("googleMap"))
  @map.drawMarker(position.coords)
  @map.drawCircle(Session.get("radius"))

  #Users.find().forEach (user) ->                             ## DENNE MÅ VÆRE REAKTIV. Kjøre hver gang db oppdateres.
    #if not @map.samePosition(position.coords) 
    #@map.drawPeerMarker(position.coords)
    #console.log user.name
  # map.darwInfo("userName") TODO: User name
  ###Deps.autorun ->
  Users.find().forEach (user) -> 
    console.log user.name
    @map.drawPeerMarker(position.coords)###





#Deps.autorun ->
#Meteor.subscribe("messages")
#Meteor.subscribe("users")



Meteor.startup ->

  Session.set("radius", 100)

  Meteor.subscribe("messages")
  Meteor.subscribe("users")

  window.onload = ->
  if navigator.geolocation
    options =
      enableHighAccuracy: true
      maximumAge: 60000
    navigator.geolocation.getCurrentPosition(displayLocation, locationError, options)
  else
    throwError("You need geolocation enabled to use this app.")
  #Meteor.call("clientConnect")


window.onbeforeunload = ->
  Meteor.call("removeUser", Session.get("name"))

######

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

