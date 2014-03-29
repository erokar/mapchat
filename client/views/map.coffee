
  
Template.map.helpers
  userList: ->
    #count = Users.find().count()

    uList = [] 
    Users.find().forEach (u) ->
      if Map.distance(Session.get("coords"), u.position) < Session.get("radius") and u.name isnt Session.get("name")
        uList.push(u.name)
    if uList.length is 0 
      return "No others are online in your area."
    else
      return "Online users in your area: " + uList.join(", ")









