'use strict'

angular.module('daysOfSun').factory 'WeatherUnderground',
  ($window, $http, $q, WU_KEY) ->
    # Generates an rfc4122 version 4 compliant UUID
    uuid = -> 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = Math.random()*16|0; (if c == 'x' then r else (r&0x3|0x8)).toString(16)

    get: (city) ->
      deferred = $q.defer()

      callback = "loadWUData_#{uuid().replace(/-/g, '_')}"
      $http.jsonp("http://api.wunderground.com/api/#{WU_KEY}/conditions/q/#{city}.json?callback=#{callback}")
      $window[callback] = (data) ->
        deferred.resolve(data)
        delete $window[callback]

      deferred.promise

