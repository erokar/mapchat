

Meteor.methods
  
  "addPosition" : (coords) ->
    console.log("inserting position " + coords.latitude)
    id = Positions.insert( { "coordinates" : coords} )
    console.log id
    return id

  "clientConnect" : ->
    console.log("Connected")

  "clientDisconnect" : (id) ->
    Positions.remove( { _id: id } )
    console.log("Position removed " + id)





#console.log("Radius: " + @radius)

