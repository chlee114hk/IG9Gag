ngIG9gag.config(['$stateProvider', '$locationProvider', '$urlRouterProvider', '$urlMatcherFactoryProvider', 
    ($stateProvider, $locationProvider, $urlRouterProvider, $urlMatcherFactoryProvider) ->
        $urlMatcherFactoryProvider.caseInsensitive(true)
        $urlMatcherFactoryProvider.strictMode(false) 
        $locationProvider.html5Mode(true)
        $urlRouterProvider.otherwise('/')

        $stateProvider
            .state('ig9gag', {
                abstract: true,
                url: '/',
                params: {locale: { squash: true, value: null }},
                template: '<div ui-view autoscroll="true"></div>'
            })
            .state('home', {
                parent: 'ig9gag',
                url: '',
                templateUrl: 'user.html',
                resolve: {
                    user: ['UserService', '$stateParams', '$rootScope'
                        (UserService, $stateParams, $rootScope) ->
                            new UserService().getUser($rootScope.demoIGid).$promise
                    ],
                    medias: ['UserService', '$stateParams', '$rootScope'
                        (UserService, $stateParams, $rootScope) ->
                            new UserService().getMedias($rootScope.demoIGid, 1, "created_time", true).$promise
                    ]
                },
                controller: 'UserMediasCtrl'
            });

]);