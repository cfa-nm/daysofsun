'use strict'

angular.module('daysOfSun').controller 'MainCtrl',
  ($scope, $window, $routeParams, $http, WU_KEY) ->
    dataPromise = $http.get('/daysofsun.json')

    $scope.data = dataPromise.then (xhr) ->
      xhr.data[$routeParams.city][2012]

    $http.jsonp("http://api.wunderground.com/api/#{WU_KEY}/conditions/q/NM/Albuquerque.json?callback=loadWUData")
    $window.loadWUData = (data) ->
      $scope.currentConditions = data.current_observation.weather
      $scope.conditionIcon = switch data.current_observation.icon
        when 'clear', 'sunny', 'mostlysunny'                             then 'CLEAR_DAY'
        when 'partlysunny', 'partlycloudy'                               then 'PARTLY_CLOUDY_DAY'
        when 'mostlycloudy', 'cloudy'                                    then 'CLOUDY'
        when 'chancerain', 'chancetstorms', 'rain', 'tstorms', 'unknown' then 'RAIN'
        when 'chancesleet', 'sleet'                                      then 'SLEET'
        when 'chanceflurries', 'chancesnow', 'flurries', 'snow'          then 'SNOW'
        when 'fog', 'hazy'                                               then 'FOG'
