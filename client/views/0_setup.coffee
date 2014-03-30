@locationError = (error) ->
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


@closingWindow = (message) ->
  alert(message)
  Meteor.call("removeUser", Session.get("name"))


Meteor.startup ->

  Session.set("radius", 100)
  Meteor.subscribe("messages")
  Meteor.subscribe("users")
  
  $(window).bind "unload", ->
    closingWindow("unload")
    return null

  $(window).bind "beforeunload", ->
    closingWindow("beforeunload")
    return null

  $(window).bind "onbeforeunload", ->
    closingWindow("beforeunload")
    return null

  $(window).bind "onunload", ->
    closingWindow("onunload")
    return null

  if navigator.geolocation
    options =
      enableHighAccuracy: true
      maximumAge: 60000
    navigator.geolocation.getCurrentPosition(displayLocation, locationError, options)
  else
    throwError("You need geolocation enabled to use this app.")






