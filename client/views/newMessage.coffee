

addMessage = (message, name) ->
  registerMessage = (position) ->
    if message isnt "" and name isnt ""
      Meteor.call("addMessage", name, message, position.coords)
  navigator.geolocation.getCurrentPosition(registerMessage)
  document.getElementById("inputMessage").value = ""
  document.getElementById("inputMessage").focus()  


nameTaken = (name) ->
  Users.find( { name: name } ).count() > 0 and name isnt Session.get("name") 

addUser = (name) ->
  if name isnt ""
    if Session.get("name") is undefined
      Session.set("name", name)
      registerUser = (position) ->
        Meteor.call("addUser", name, position.coords)
      navigator.geolocation.getCurrentPosition(registerUser)
    else if Session.get("name") isnt name
      changeUser = (position) ->
        Meteor.call("changeUser", Session.get("name"), name, position.coords)
        Session.set("name", name)
      navigator.geolocation.getCurrentPosition(changeUser)

      




Template.newMessage.events
  
  "submit form" : (e) ->
    e.preventDefault()
    message = document.getElementById("inputMessage").value
    name = document.getElementById("inputName").value
    if not nameTaken(name)
      addUser(name)
      addMessage(message, name)
      console.log message
    else
      throwError("Nickname is taken. Pick a new one.")

  "keydown #inputMessage" : (e) ->
    if e.which is 13
      e.preventDefault()
      message = document.getElementById("inputMessage").value
      name = document.getElementById("inputName").value
      if not nameTaken(name)
        addUser(name)
        addMessage(message, name)
        console.log message
      else
        throwError("Nickname is taken. Pick a new one.")
          