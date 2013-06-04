'use strict';

/*
 * type must be one of the following:
 *   CLEAR_DAY, CLEAR_NIGHT,
 *   PARTLY_CLOUDY_DAY, PARTLY_CLOUDY_NIGHT,
 *   CLOUDY, RAIN, SLEET, SNOW, WIND, FOG
 */
angular.module('daysOfSun').directive('skycon', function () {
  var skycons = new Skycons();
  skycons.play();

  return {
    restrict: 'E',
    template: '<canvas width={{width}} height={{height}}></canvas>',
    scope: { width: '@', height: '@', type: '=' },
    link: function (scope, element, attrs) {
      var active = false
        , canvas = element.find('canvas')[0];

      scope.$watch('type', function (type) {
        if (!!type) {
          skycons[active?'set':'add'](canvas, Skycons[type]);
          active = true;
        } else {
          skycons.remove(canvas);
          active = false;
        }
      });
    }
  };
});

