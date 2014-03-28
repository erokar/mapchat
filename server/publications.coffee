
Meteor.publish "messages", ->
  return Messages.find()

###Meteor.publish "positions", (coords, radius) ->
  console.log("r: " + coords.latitude)
  self = this
  Positions.find().forEach (pos) ->
    if (@distance(coords, pos.coordinates) < radius) #and (not @distance(coords, pos.coordinates) < 0.5)
      console.log(pos._id)
      self.added("positions", pos._id, pos) # bruker denne for å returnere pos-objektene
  self.ready()
  return self
###
