
Meteor.publish "messages", ->
  return Messages.find()

Meteor.publish "users", ->
  return Users.find()

