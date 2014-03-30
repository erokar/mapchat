

Meteor.methods

  "addUser" : (name, coords, radius) ->
    Users.insert( { name: name, position: coords, radius: radius, timestamp: Math.round(new Date().getTime() / 1000) })

  "changeUser" : (oldName, name, coords, radius) ->
    Users.remove( { name: oldName })
    console.log "removed: " + oldName
    Users.insert( { name: name, position: coords, radius: radius, timestamp: Math.round(new Date().getTime() / 1000) } )

  "removeUser" : (name) ->
    Users.remove( { name: name} ) 
  
  "addMessage" : (name, message, coords, radius) ->
    Messages.insert( { sender: name, message: message, position: coords, radius: radius, timestamp: Math.round(new Date().getTime() / 1000) })


# Kjører en gang i timen. Fjerner alle documenter i Users og Messages
# som er over 24 timer gamle.
CronJob = new Cron(60000 * 60) # en time
CronJob.addJob(1, ->

  old = (ts) ->
    now = Math.round(new Date().getTime() / 1000)
    return now - ts > (24 * 3600) # ett døgn
      
  Messages.find().forEach( (doc) ->
    if old(doc.timestamp)
      Messages.remove(doc)
  )

  Users.find().forEach( (doc) ->
    if old(doc.timestamp)
      Users.remove(doc)
  )
)
