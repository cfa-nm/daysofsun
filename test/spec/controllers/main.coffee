'use strict'

describe 'Controller: MainCtrl', () ->
  MainCtrl = null; scope = null

  # load the controller's module
  beforeEach(module('daysOfSun'))

  beforeEach inject ($httpBackend) ->
    $httpBackend.when('GET', '/daysofsun.json').respond({
      ABQ: { 2012: {
        year: { clear: 167, partlyCloudy: 111, cloudy: 87 }
        jan:  { clear: 13,  partlyCloudy: 8,   cloudy: 10 }
      } }
    })

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, $http) ->
    scope = $rootScope.$new()
    MainCtrl = $controller('MainCtrl', {
      $scope: scope
      $routeParams: { city: 'ABQ' }
      WeatherUnderground: { get: -> { then: angular.noop } }
    })

  afterEach inject ($httpBackend) -> $httpBackend.flush()

  it "should attach the relevant city's JSON data to the scope", ->
    scope.data.then (data) -> expect(data.year.clear).toBe(167)
