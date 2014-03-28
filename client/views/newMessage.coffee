

addMessage = (message, name) ->
  registerMessage = (position) ->
    Meteor.call("addMessage", name, message, position.coords)
  navigator.geolocation.getCurrentPosition(registerMessage)
  document.getElementById("inputMessage").value = ""
  document.getElementById("inputMessage").focus()  


Template.newMessage.events
  
  "submit form" : (e) ->
    e.preventDefault()
    message = document.getElementById("inputMessage").value
    name = document.getElementById("inputName").value
    if message is ""
      throwError("Your message is empty.")
    else
      addMessage(message, name)
    
  "keydown #inputMessage" : (e) ->
    if e.which is 13
      e.preventDefault()
      message = document.getElementById("inputMessage").value
      name = document.getElementById("inputName").value
      if message isnt "" and name isnt ""
        addMessage(message, name)
        