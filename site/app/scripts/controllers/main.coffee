'use strict'

angular.module('site')
    .directive 'prettyPrint', () ->
        restrict: 'A',
        link: makePretty = ($scope, $element, attrs) ->
            $element.html(prettyPrintOne($element.html()))

    .controller 'MainCtrl', ($scope, $location) ->
        # should probably be a directive
        $scope.snapElement = (inview, part, el) ->
            body = angular.element(document).find('body')
            position = body.scrollTop()
            section = angular.element(el)
            offset = section.offset().top
            if part is "top"
                body.animate({scrollTop: offset - 20}, 200)
                body.animate({scrollTop: offset - 70}, 500)
            # to do: scrolling if scrolling from bottom
            # if part is "bottom"
            #     position = body.scrollTop()
            #     sectionHeight = angular.element(el).height()
            #     section = angular.element(el)
            #     offset = section.offset().top
            #     console.log section
            #     console.log "part is bottom"
            #     console.log sectionHeight
            #     console.log position
            #     console.log offset


angular.module('navigation', ['ui.bootstrap'])
    .controller 'navCtrl', ($scope, $location, $route) ->

        $scope.$on '$routeChangeSuccess', ->
            if $location.path() is '/examples/FullApp'
                $scope.showNav = "hidden"
            else $scope.showNav = ""

        $scope.init = ->
            $scope.links =   
            [
                { name: 'Home', href: '/'},
                { name: 'Examples', href: '/examples'},
                { name: 'Tutorial', tooltip:"Coming Soon!"} 
            ] 
            $scope.active($location.path())
        $scope.active = (navTab) ->
            $location.hash("")
            for link in $scope.links
                if navTab is link.href
                    link.state= "active"
                    $location.path(link.href)
                else 
                    link.state= ""


angular.module('alchemyExamples', [])
    .controller 'examplesCtrl', ($scope, $location) ->
        $scope.init = ->
            $scope.examples =
             [
                {
                    name: 'Basic Graph',
                    src: 'views/examples/example1.html', 
                    id:"example1", 
                    desc: "A basic Alchemy.js graph, with only a custom dataSource defined." },
                {
                    name: 'Embedded Graph', 
                    src: "views/examples/example2.html", 
                    id: "example2",
                    desc: "An example with custom graphHeight, graphWidth, and linkDistance making it easy to include and embed within larger applications."},
                {
                    name: 'Custom Styling',
                    src: 'views/examples/example4.html',
                    id:"example4",
                    desc: "An example illustrating how to apply custom styles to the graph, overriding Alchemy.css by using nodeTypes and edgeTypes."},
                {
                    name: 'Full Application',
                    src: 'views/examples/example3.html',
                    id: "example3",
                    desc: "A full application using clustering, filters, node typing, and search."},
            ]
        # should probably be moved to a directive
        $scope.showExample = (e) ->
            $scope.current_example = e
            if angular.element("#removethis")?
                angular.element("#removethis").remove()
            for example in $scope.examples
                if $scope.current_example is example
                    example.state = "active"
                else
                    example.state= ""
            name = e.name.replace " ", "_"
            $location.hash(name)

        $scope.showViz = ->
            $location.path("examples/FullApp")

        $scope.hideViz = ->
            $location.hash("")
            $location.path("examples/")

angular.module('featCarousel', ['ui.bootstrap'])
    .controller 'carouselCtrl', ($scope) ->
        $scope.myInterval = 3000
        $scope.slides=[
            {image: "images/features/search_movies.png", text: "Search within the graph to quickly find insights"},
            {image: "images/features/cluster_team.png", text: "Cluster nodes for easy identification of patterns"},
            {image: "images/features/filters_movies.png", text: "Automatically generate filters based on the data"},
            {image: "images/features/clusterHighlight_team.png", text: "Cluster nodes for easy identification of patterns"},
            {image: "images/features/filters&Stats_movies.png", text: "Network statistic API endpoints to use in the rest of your app"}
        ]