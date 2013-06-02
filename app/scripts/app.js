'use strict';

angular.module('daysOfSun', [])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/:city', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/ABQ'
      });
  }).constant('WU_KEY', 'b57f2267e5844afe');
