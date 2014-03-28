

Meteor.methods
  
  "addPosition" : (coords) ->
    console.log("inserting position " + coords.latitude)
    id = Positions.insert( { "coordinates" : coords} )
    console.log id
    return id

  "addMessage" : (name, message, coords) ->
    Messages.insert( { sender: name, message: message, position: coords })

  "clientConnect" : ->
    console.log("Connected")

  "clientDisconnect" : (id) ->
    Positions.remove( { _id: id } )
    console.log("Position removed " + id)





#console.log("Radius: " + @radius)

