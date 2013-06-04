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
      $scope.conditionIcon = (function (icon) {
        switch (icon) {
          case 'clear':
          case 'sunny':
          case 'mostlysunny':
            return 'CLEAR_DAY';
          case 'partlysunny':
          case 'partlycloudy':
            return 'PARTLY_CLOUDY_DAY';
          case 'mostlycloudy':
          case 'cloudy':
            return 'CLOUDY';
          case 'chancerain':
          case 'chancetstorms':
          case 'rain':
          case 'tstorms':
          case 'unknown':
            return 'RAIN';
          case 'chancesleet':
          case 'sleet':
            return 'SLEET';
          case 'chanceflurries':
          case 'chancesnow':
          case 'flurries':
          case 'snow':
            return 'SNOW';
          case 'fog':
          case 'hazy':
            return 'FOG';
        }
      })(data.current_observation.icon);
    };
  });
