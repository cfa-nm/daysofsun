'use strict';

angular.module('daysOfSun')
  .controller('MainCtrl', function ($scope, $http) {
    var dataPromise = $http.get('/daysofsun.json');

    $scope.data = dataPromise.then(function (xhr) {
      return xhr.data.ABQ[2012];
    });
  });
