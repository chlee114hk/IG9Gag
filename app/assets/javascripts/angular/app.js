ngIG9gag = angular.module("ngIG9gag", [
    'ngResource',
    'ngSanitize',
    'ui.router',
    'templates',
    'ngAnimate',
    'ngMessages',
    'ngAria',
    'infinite-scroll',
    'angularGrid',
    'ngMaterial',
    'com.2fdevs.videogular',
    'com.2fdevs.videogular.plugins.controls',
    'com.2fdevs.videogular.plugins.overlayplay',
    'com.2fdevs.videogular.plugins.poster'
]).constant('_', window._).run(
    [  '$rootScope',
        function($rootScope) {
            // use underscore.js with angularJS
            $rootScope._ = window._;
        }
    ]
).constant('linkify', window.linkify).run(
    [  '$rootScope',
        function($rootScope) {
            // use linkify with angularJS
            $rootScope.linkify = window.linkify;
        }
    ]
).run(
    [ '$rootScope', '$state', '$stateParams',
        function($rootScope, $state, $stateParams) {
            // a default IG id for demo only
            $rootScope.demoIGid = '579257861'

            $rootScope.$state = $state;
            $rootScope.$stateParams = $stateParams;

            $rootScope.$on('$stateChangeStart',function(){
                $rootScope.stateIsLoading = true;
            });

            $rootScope.$on('$stateChangeSuccess',function(){
                $rootScope.stateIsLoading = false;
            });
        }
    ]
);