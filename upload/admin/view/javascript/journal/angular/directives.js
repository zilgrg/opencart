angular.module('ck', []).directive('ckEditor', function() {
	return {
		require: '?ngModel',
		link: function(scope, elm, attr, ngModel) {
			var ck = CKEDITOR.replace(elm[0]);

			if (!ngModel) return;

			ck.on('pasteState', function() {
				scope.$apply(function() {
					ngModel.$setViewValue(ck.getData());
				});
			});

			ngModel.$render = function(value) {
				ck.setData(ngModel.$viewValue);
			};
		}
	};
});

angular.module('switchify', []).directive('switchify', function() {
    return {
        require: '?ngModel',
        restrict: 'A',
        link: function(scope, element, attrs, ngModel) {
            var $sw = $(element).switchify().data('switch');

            if (!ngModel) return;

            $sw.on('switch:slideon', function(e, data){
                if (!data) {
                    scope.$apply(function() {
                        ngModel.$setViewValue("1");
                    });
                }
            });

            $sw.on('switch:slideoff', function(e, data){
                if (!data) {
                    scope.$apply(function() {
                        ngModel.$setViewValue("0");
                    });
                }
            });

            ngModel.$render = function() {
                var val = parseInt(ngModel.$viewValue);
                if (val) {
                    $sw.trigger('switch:slideon', [true]);
                } else {
                    $sw.trigger('switch:slideoff', [true]);
                }
            }
        }
    };
});

angular.module('custom-select', []).directive('customSelect', function() {
    return {
        require: '?ngModel',
        restrict: 'A',
        link: function(scope, element, attrs, ngModel) {
        	var $element = $(element);
        	$element.css('opacity', 0);
        	var $wrapper = $('<div class="select-wrap" />');
        	$element.wrap($wrapper);
        	$('<span class="val"></span>').prependTo($(element).parent());
        	scope.$watch('tab.itemType', function(val){
        		var text = $element.find('option:selected').text();
        		$element.parent().find('.val').text(text);
        	});
        }
    };
});