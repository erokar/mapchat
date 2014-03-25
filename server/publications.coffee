#Meteor.publish "messages", ->
#  @Messages.find()

Meteor.publish "positions", ->
  Positions.find()

# TODO: publiser positions hvor bruker id = Meteor.user og andre posisjoner er innafor brukers radius