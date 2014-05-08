define(['./module'], function (module) {

    module.directive('colorPicker', function () {
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function ($scope, $element, $attrs, $ngModel) {
                $($element).spectrum({
                    preferredFormat: "rgb",
                    allowEmpty: true,
                    showAlpha: true,
                    showInput: true,
                    showButtons: false,
                    showPalette: true,
                    palette: [
                        [
                            'black',
                            'white',
                            '#FAFAFA',
                            '#f4f4f4',
                            '#e4e4e4',
                            '#a9b8c0',
                            '#999999',
                            '#777777',
                            '#505050',
                            '#444349',
                            '#383838',
                            '#2A2B2E',
                            '#37291e',
                            '#ea2349',
                            '#dd0017',
                            '#eb5858',
                            '#f16272',
                            '#428bca',
                            '#69b9cf',
                            '#5F6874',
                            '#333745',
                            '#339965',
                            '#3F5765',
                            '#34495e',
                            '#45738f',
                            '#bdc3c7',
                            '#a8a8a8',
                            '#b09e66',
                            '#b79dba',
                            '#e9e8d3',
                            '#bfc3b6',
                            '#f6f1ec',
                            '#eef1ea',
                            '#9b59b6',
                            '#70bea4',
                            '#f1c40f',
                            '#2bb0e3',
                            '#588F27',
                            '#1fbba6',
                            '#5a6981',
                            '#a41733',
                            '#577640',
                            '#4cb356',
                            '#a6ddec',
                            '#369ca8'
                        ]
                    ]
                });
                $scope.$watch(function () {
                    return $ngModel.$modelValue;
                }, function (val) {
                    $($element).spectrum('set', val);
                });
            }
        };
    });

});
