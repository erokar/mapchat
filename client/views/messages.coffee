Template.messages.messages = ->
  messages = []
  Messages.find().forEach (m) ->
    if Map.distance(@coords, m.position) < @radius
      messages.push m
  return messages