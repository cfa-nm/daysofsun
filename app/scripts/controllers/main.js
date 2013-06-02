'use strict';

angular.module('daysOfSun')
  .controller('MainCtrl', function ($scope, $window, $routeParams, $http, WU_KEY) {
    var dataPromise = $http.get('/daysofsun.json');

    $scope.data = dataPromise.then(function (xhr) {
      return xhr.data[$routeParams.city][2012];
    });

    $http.jsonp("http://api.wunderground.com/api/" + WU_KEY + "/conditions/q/NM/Albuquerque.json?callback=loadWUData");
    $window.loadWUData = function (data) {
      $scope.currentConditions = data.current_observation.weather;
    };
  });
