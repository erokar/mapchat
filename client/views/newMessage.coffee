
Template.newMessage.events
  "submit form" : (e) ->
    e.preventDefault()
    message = document.getElementById("inputMessage").value;
    name = document.getElementById("inputName").value;
    if message is ""
      throwError("Your message is empty.")
    console.log(name)