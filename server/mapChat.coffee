

Meteor.methods

  "addUser" : (name, coords) ->
    Users.insert( { name: name, position: coords })

  "changeUser" : (oldName, name, coords) ->
    Users.remove( { name: oldName })
    console.log "removed: " + oldName
    Users.insert( { name: name, position: coords } )

  "removeUser" : (name) ->
    Users.remove( { name: name} ) 
  
  "addMessage" : (name, message, coords) ->
    Messages.insert( { sender: name, message: message, position: coords })


