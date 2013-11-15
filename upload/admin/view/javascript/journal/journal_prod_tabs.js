angular.module('ck', []).directive('ckEditor', function() {
	return {
		require: '?ngModel',
		link: function(scope, elm, attr, ngModel) {
			var ck = CKEDITOR.replace(elm[0]);

			if (!ngModel) return;

			ck.on('pasteState', function(e) {
				scope.$apply(function() {
					ngModel.$setViewValue(ck.getData());
				});
			});

			ck.on('save-click', function(e){
				ngModel.$setViewValue(ck.getData());
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
                        ngModel.$setViewValue(1);
                    });
                }
            });

            $sw.on('switch:slideoff', function(e, data){
                if (!data) {
                    scope.$apply(function() {
                        ngModel.$setViewValue(0);
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

var JProdTabs = {};

JProdTabs.CONSTS = {
	languages: [],
	lang_id: null,
	token: null,
	product_id: null
}

JProdTabs.Tab = function() {
	var self = this;

	this.name = {};
	this.status = 1;
	this.sort_order = '';
	this.position = 4;
	this.text = {};
}

JProdTabs.AngularModule = angular.module('JProdTabs', ['ck', 'ui.bootstrap', 'switchify']);

JProdTabs.AngularModule.config(function($httpProvider) {
	$httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
	$httpProvider.defaults.transformRequest = [function(data) {
		return angular.isObject(data) && String(data) !== '[object File]' ? jQuery.param(data) : data;
	}];
});

JProdTabs.AngularModule.controller('JProdTabsCtrl', function($scope, $http, $element){
	$scope.global_tab = 0;

	$scope.product = {};

	/* consts */
	$scope.CONSTS = JProdTabs.CONSTS;

	/* tabs functionality */
	$scope.tabs = [];

	$scope.addTab = function() {
		$scope.tabs.push(new JProdTabs.Tab());
		setTimeout(function(){
			$('#tabs a').tabs();
			$('#tabs a').last().click();
			$('.language-tabs a').tabs();
			$('.vtabs-content').each(function(){
				$(this).find('.language-tabs a').first().click();
			});
			//$('.yes_no').switchify();
			$('.ui-switch-labels').live('click', function(e){
				e.preventDefault();
				return false;
			});
		}, 1);
	}

	$scope.removeTab = function($index) {
		$scope.tabs.splice($index, 1);
		setTimeout(function(){
			$('#tabs a').first().click();
		}, 1);
	}

	/* autocomplete */
	$scope.getProducts = function(filter) {
		var url = 'index.php?route=module/journal_product_tabs/products&token=' + JProdTabs.CONSTS.token + '&filter_name=' + filter;
		return $http.get(url, {filter: filter}).then(function(response){
			if ($.isArray(response.data)) {
				return response.data;
			}
			alert('Error occured! Check admin permissions.');
			return [];
		});
	}

	/* tab title */
	$scope.getTabTitle = function(tab) {
		if (!tab.name) return 'New item';
		return tab.name[JProdTabs.CONSTS.lang_id] ? tab.name[JProdTabs.CONSTS.lang_id] : 'New item';
	}

	/* save */
	$scope.save = function() {
		if(!$scope.global_tab && !$scope.product.data) {
			alert('choose a product');
			return;
		}

		// ckeditor save bug
		for (var i in CKEDITOR.instances) {
			CKEDITOR.instances[i].fire('save-click', 'save-click');
		}

		var data = {
			tabs: $.parseJSON(JSON.stringify($scope.tabs)),
			product_id: $scope.product.data && !$scope.global_tab? $scope.product.data.product_id : 0,
			global_tab: $scope.global_tab
		};

		$http.post('index.php?route=module/journal_product_tabs/save&token=' + JProdTabs.CONSTS.token, {data: data}).then(function(response){
			if(response.data.status === 'error') {
				alert(response.data.message);
			} else {
				location = 'index.php?route=module/journal_product_tabs&token=' + JProdTabs.CONSTS.token;
			}
		});
	}

	/* load */
	if (JProdTabs.CONSTS.product_id){
		$http.get('index.php?route=module/journal_product_tabs/load&token=' + JProdTabs.CONSTS.token + '&product_id=' + JProdTabs.CONSTS.product_id).then(function(response){
			console.log(response.data.result);
			var tabs = response.data.result.data || [];
			_.each(tabs, function(element, index){
				var tab = _.extend(new JProdTabs.Tab(), element);
				var text = {};
				for(var i in tab.text) {
					text[i] = _.string.unescapeHTML(tab.text[i]);
				}
				tab.text = text;
				var name = {};
				for(var i in tab.name) {
					name[i] = _.string.unescapeHTML(tab.name[i]);
				}
				tab.name = name;
				$scope.tabs.push(tab);
			});
			// $scope.status = response.data.result.status;
			$scope.global_tab = response.data.result.global_tab;
			$scope.product.data = $scope.global_tab ? {name: ' ', product_id: 0} : {
				name: _.string.unescapeHTML(response.data.result.name),
				product_id: response.data.result.product_id
			}
			/* shit fix */
			setTimeout(function(){
				$('#tabs a').tabs();
				$('#tabs a').last().click();
				$('.language-tabs a').tabs();
				$('.vtabs-content').each(function(){
					$(this).find('.language-tabs a').first().click();
				});
				//$('.yes_no').switchify();
				$('.ui-switch-labels').live('click', function(e){
					e.preventDefault();
					return false;
				});
			}, 1);
			$(function(){
				$('#content').show();
			});
		});
	}

	$(function(){
		$('#content').show();
	});

	$scope.tabChange = function(e, source){
		var elem = angular.element(e.srcElement);
		if (elem.length) {
			$(elem.attr('href')).find('.language-tabs a').first().click();
		}

	}
});
