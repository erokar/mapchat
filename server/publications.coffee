#Meteor.publish "messages", ->
#  @Messages.find()

# Position Position -> Number
# computes distance between to locations in meters
@distance = (startCoords, destCoords) ->
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

Meteor.publish "positions", (coords, radius) ->
  console.log("r: " + coords.latitude)
  self = this
  Positions.find().forEach (pos) ->
    if (@distance(coords, pos.coordinates) < radius) #and (not @distance(coords, pos.coordinates) < 0.5)
      console.log(pos._id)
      self.added("positions", pos._id, pos) # bruker denne for å returnere pos-objektene
  self.ready()
  return self

