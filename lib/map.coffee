

class @Map

  constructor: (coords, @mapDiv) ->
    @position = new google.maps.LatLng(coords.latitude, coords.longitude)
    mapOptions =
      zoom: 14
      center: @position
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map(@mapDiv, mapOptions)

  @distance = (startCoords, destCoords) -> # klasse-metode
    degreesToRadians = (degrees) ->
      radians = (degrees * Math.PI) / 180 
      return radians
    startLatRads = degreesToRadians(startCoords.latitude)
    startLongRads = degreesToRadians(startCoords.longitude)
    destLatRads = degreesToRadians(destCoords.latitude)
    destLongRads = degreesToRadians(destCoords.longitude)
    Radius = 6371 # radius of the Earth in km
    distance = Math.acos(Math.sin(startLatRads) * Math.sin(destLatRads) + Math.cos(startLatRads) * Math.cos(destLatRads) * Math.cos(startLongRads - destLongRads)) * Radius
    return distance * 1000    

  drawMarker: (coords, peers = false) ->
    pinImage = undefined
    pinShadow = undefined
    if peers
      pinColor = "fcf357"
      pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
        new google.maps.Size(21, 34),
        new google.maps.Point(0,0),
        new google.maps.Point(10, 34))
      pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(0, 0),
        new google.maps.Point(12, 35))
    latLong = new google.maps.LatLng(coords.latitude, coords.longitude)
    marker = new google.maps.Marker
      position: latLong
      map: @map
      title: "You"
      icon: pinImage
      shadow: pinShadow
    @marker = marker

  drawInfo: (content) ->
    infoWindowOptions =
      content: content
      position: @position
    infoWindow = new google.maps.InfoWindow(infoWindowOptions)
    google.maps.event.addListener(@marker, "click", -> infoWindow.open(@map))

    
  drawCircle: (radius) ->
    circle = new google.maps.Circle
      map: @map
      fillColor : '#BBD8E9'
      fillOpacity : 0.6
      radius : radius
      strokeColor : '#BBD8E9'
      strokeOpacity : 0.9
      strokeWeight : 2
    circle.bindTo('center', @marker, 'position')  
