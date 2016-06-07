ngIG9gag.factory 'UserService', [ '$resource', '$stateParams', ($resource, $stateParams) ->
    class UserService
        constructor: () ->
            @service = $resource(
                "/users/:id/:action.json",
                {
                    id: "@id"
                },
                {
                    'medias': { 
                        method: 'GET',
                        params: {
                            id: "@id",
                            action: "medias"
                        }
                    }
                }
            )

        getUser: (id, successHandler, errorHandler) ->
            new @service.get(
                {id: id},
                (user, response) -> successHandler?(user, response),
                (response) -> errorHandler?(response)
            )

        getMedias: (id, page=1, sort_by="created_time", successHandler, errorHandler) ->
            new @service.medias(
                {id: id, page: page, sort_by: sort_by},
                (media, response) -> successHandler?(media, response),
                (response) -> errorHandler?(response)
            )
]