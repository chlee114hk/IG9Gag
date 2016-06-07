ngIG9gag.controller("UserMediasCtrl", 
["$scope", "$sce", "UserService", "medias", "user"
($scope, $sce, UserService, medias, user) ->
    vm = this;
    $scope.medias = medias.medias
    $scope.user = user
    $scope.sort_by = "created_time"
    $scope.videoSource = {}
    vm.total_count = medias.total_count
    vm.total_page = Math.ceil(vm.total_count / 10)
    vm.page = 1
    vm.loadingMore = false
    vm.userService = new UserService

    $scope.loadMoreMedias = (reload=false) ->
        return if (vm.loadingMore || vm.page >= vm.total_page) 
        vm.page++
        vm.loadingMore = true
        vm.userService.getMedias(
            $scope.user.id, vm.page, $scope.sort_by, false,
            (data) -> 
                if !reload
                    mediasTmp = angular.copy($scope.medias)
                    mediasTmp = mediasTmp.concat(data.medias)
                    $scope.medias = mediasTmp
                else
                    length = $scope.medias.length
                    $scope.medias = $scope.medias.concat(data.medias)
                    $scope.medias.splice(0, length)

                vm.loadingMore = false
            () ->
                vm.loadingMore = false
        ).$promise

    $scope.sortMediasBy = (sortAttr) ->
        return if $scope.sort_by == sortAttr
        $scope.sort_by = sortAttr
        vm.page = 0
        $scope.loadMoreMedias(true)

    $scope.setVideoSrc = ($index, videoUrl) ->
        $scope.videoSource[$index] = []
        $scope.videoSource[$index][0] = {}
        $scope.videoSource[$index][0].src = $sce.trustAsResourceUrl(videoUrl)
        $scope.videoSource[$index][0].type = "video/mp4"

])