myCar = null
myOrder = null
navInterval = null
socket = io.connect('http://localhost:3000')

class Order extends Backbone.Model
  idAttribute: '_id'
  url: ->
    if @isNew()
      '/api/orders'
    else
      '/api/orders/' + @id

class Car extends Backbone.Model
  idAttribute: '_id'
  url: ->
    if @isNew()
      '/api/cars/auth'
    else
      '/api/cars/' + @id

  parse: (data) ->
    data.result

auth = $('#auth')
work = $('#work')

window.location.href = '#'

updateLocation = ->
  navigator.geolocation.getCurrentPosition (position) ->
    latitude = position.coords.latitude
    longitude = position.coords.longitude
    myCar.set 'point', [latitude, longitude]
    myCar.save()

auth.on 'click', 'form a', ->
  car = new Car
    driverName: auth.find('#login').val()
    password: auth.find('#passwd').val()

  car.save {}, success: (car) ->
    myCar = car
    window.location.href = '#work'

work.on 'click', '.online', ->
  if window.navigator.geolocation?
    myCar.set 'status', 'ready'
    myCar.save

    updateLocation()
    navInterval = setInterval updateLocation, 30000

    socket.on 'order-update', (data) =>
      order = new Order(data)

      if order.get('carId') == myCar.id && order.get('status') == 'assigned'
        myOrder = order
        sound = $('<audio src="i/s.mp3" autoplay></audio>')
        work.append sound
        _.delay ->
          sound.remove()
        , 1000

        info = "#{order.get('startPointTitle')} - #{order.get('endPointTitle')}, #{order.get('phone')}"
        work.find('.order-info').text(info).show()
        work.find('.accept').show()
        work.find('.decline').show()

    work.find('.offline').show()
    $(@).hide()
  else
    $('#no-geoapi').popup('open')

  false

work.on 'click', '.offline', ->
  $(@).hide()
  if navInterval?
    clearInterval(navInterval)

  socket.removeAllListeners 'order-update'

  work.find('.online').show()
  work.find('.order-info').hide()
  work.find('.accept').hide()
  work.find('.decline').hide()
  work.find('.finish').hide()

  myCar.set 'status', 'off'
  myCar.set 'point', []
  myCar.save()

work.on 'click', '.accept', ->
  $(@).hide()
  work.find('.decline').hide()
  work.find('.finish').show()
  myCar.set 'status', 'busy'
  myCar.save()

  myOrder.set 'status', 'processing'
  myOrder.save()

work.on 'click', '.decline', ->
  $(@).hide()
  work.find('.accept').hide()
  work.find('.finish').hide()
  work.find('.order-info').hide()

  myCar.set 'status', 'ready'
  myCar.save()

  myOrder.set 'status', 'ready'
  myOrder.save()

work.on 'click', '.finish', ->
  $(@).hide()
  work.find('.order-info').hide()
  myCar.set 'status', 'ready'
  myCar.save()

  myOrder.set 'status', 'completed'
  myOrder.save()



