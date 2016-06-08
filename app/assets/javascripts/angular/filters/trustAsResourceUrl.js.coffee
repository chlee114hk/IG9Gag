ngIG9gag.filter(
    'trustAsResourceUrl', 
    ["$sce", ($sce) ->
        $sce.trustAsResourceUrl
    ]
)