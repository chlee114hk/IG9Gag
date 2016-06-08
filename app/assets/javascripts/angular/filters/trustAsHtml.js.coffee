ngIG9gag.filter(
    'trustAsHtml', 
    ["$sce", ($sce) ->
        $sce.trustAsHtml
    ]
)