ngIG9gag.factory 'MediaService', [ '$resource', '$stateParams', ($resource, $stateParams) ->
    class MediaService
        constructor: () ->
            @service = $resource(
                "/medias/:id/:action.json",
                {
                    id: "@id"
                },
                {
                    'pin': { 
                        method: 'GET',
                        params: {
                            id: "@id",
                            action: "pin"
                        }
                    }
                }
            )

        pinMedia: (id, successHandler, errorHandler) ->
            new @service.pin(
                {id: id},
                (user, response) -> successHandler?(user, response),
                (response) -> errorHandler?(response)
            )
]