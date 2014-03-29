

Template.messages.messages = ->
  messages = []
  Messages.find().forEach (m) ->
  
    distance = (startCoords, destCoords) -> 
      degreesToRadians = (degrees) ->
        radians = (degrees * Math.PI) / 180 
        return radians
      startLatRads = degreesToRadians(startCoords.latitude)
      startLongRads = degreesToRadians(startCoords.longitude)
      destLatRads = degreesToRadians(destCoords.latitude)
      destLongRads = degreesToRadians(destCoords.longitude)
      Radius = 6371 # radius of the Earth in km
      distance = Math.acos(Math.sin(startLatRads) * Math.sin(destLatRads) + Math.cos(startLatRads) * Math.cos(destLatRads) * Math.cos(startLongRads - destLongRads)) * Radius
      return distance * 1000
  
    if distance(Session.get("coords"), m.position) < Session.get("radius")
      messages.push m
  
  return messages