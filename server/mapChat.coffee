Meteor.methods
  
  "addPosition" : (coords) ->
    console.log("inserting position " + coords.latitude)
    #this.session.socket.on "close", ->
    if Meteor.status().staus is "offline"
      user = Meteor.userId
      console.log("DISCONNET " + user)
    Positions.insert( { "coordinates" : coords} )

  "clientConnect" : ->
    console.log("Connected")

  "clientDisconnect" : ->
    console.log("Client disconnected")







