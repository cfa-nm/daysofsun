'use strict'

# type must be one of the following:
#   CLEAR_DAY, CLEAR_NIGHT,
#   PARTLY_CLOUDY_DAY, PARTLY_CLOUDY_NIGHT,
#   CLOUDY, RAIN, SLEET, SNOW, WIND, FOG
angular.module('daysOfSun').directive 'skycon', ->
  skycons = new Skycons()
  skycons.play()

  restrict: 'E'
  template: '<canvas width={{width}} height={{height}}></canvas>'
  scope: { width: '@', height: '@', type: '=' }
  link: (scope, element, attrs) ->
    active = false
    canvas = element.find('canvas')[0]

    scope.$watch 'type', (type) ->
      if !!type
        action = if active then 'set' else 'add'
        skycons[action](canvas, Skycons[type])
        active = true
      else
        skycons.remove(canvas)
        active = false

