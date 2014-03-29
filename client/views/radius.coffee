Template.radius.events
  "change select" : (event) ->
    e = document.getElementById("select")
    radius = e.options[e.selectedIndex].value
    Session.set("radius", parseInt(radius))
    navigator.geolocation.getCurrentPosition(displayLocation)


