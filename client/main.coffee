
window.onload = -> Meteor.call("clientConnect")

window.onbeforeunload = -> Meteor.call("clientDisconnect")


Meteor.subscribe("positions")