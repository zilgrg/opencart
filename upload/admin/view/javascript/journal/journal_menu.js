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

angular.module('htmlfilter', []).filter('htmlfilter', function() {
	return function (text) {
		return _.string.unescapeHTML(text);
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
        	scope.$watch('store_id', function(val){
        		var text = $element.find('option:selected').text();
        		$element.parent().find('.val').text(text);
        	});
        }
    };
});

var JMenu = {};

JMenu.CONSTS = {
	languages: [],
	lang_id: null,
	token: null,
}

JMenu.Tab = function() {
	var self = this;

	this.name = {};
	this.status = 1;
	this.sort_order = '';

	this.itemType = 'megamenu';

	this.megamenu = {
		maxSubItems: '',
		top_link: '',
		showImages: 1,
		categories: [],
		moreText: {}
	};

	this.brands = {
		showImages: 1,
		brands: []
	};

	this.customblock = {};

	this.simplemenu = {
		link: '',
		newWindow: 0,
		items: [],
	};

	this.products = {
		showImages: 1,
		products: []
	};

	this.save = function() {
		return _.values(self);
	};

	this.load = function(data) {
		_.extend(self, data);
	}
}

JMenu.AngularModule = angular.module('JMenu', ['ck', 'ui.bootstrap', 'switchify', 'custom-select', 'htmlfilter']);

JMenu.AngularModule.config(function($httpProvider) {
	$httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
	$httpProvider.defaults.transformRequest = [function(data) {
		return angular.isObject(data) && String(data) !== '[object File]' ? jQuery.param(data) : data;
	}];
});

JMenu.AngularModule.controller('JMenuCtrl', function($scope, $http){
	/* store id */
	$scope.store_id = 0;

	/* animation */
	$scope.animation = 1;

	/* global status */
	$scope.status = 1;

	/* consts */
	$scope.CONSTS = JMenu.CONSTS;

	/* tabs functionality */
	$scope.tabs = [];

	$scope.addTab = function() {
		$scope.tabs.push(new JMenu.Tab());
		setTimeout(function(){
			$('#tabs a').tabs();
			$('#tabs a').last().click();
			$('.language-tabs a').tabs();
			$('.vtabs-content').each(function(){
				$(this).find('.language-tabs a').first().click();
			});
		}, 1);
	}

	$scope.removeTab = function($index) {
		$scope.tabs.splice($index, 1);
		setTimeout(function(){
			$('#tabs a').first().click();
		}, 1);
	}

	/* tab title */
	$scope.getTabTitle = function(tab) {
		return tab.name && tab.name[JMenu.CONSTS.lang_id] ? tab.name[JMenu.CONSTS.lang_id] : 'New item';
	}

	$scope.getCategoryMoreText = function(tab) {
		return tab.name && tab.name[JMenu.CONSTS.lang_id] ? tab.name[JMenu.CONSTS.lang_id] : 'New item';
	}

	/* megamenu */
	$scope.isMegaMenu = function(tab) { return tab.itemType === 'megamenu'; }

	$scope.hasLimit = function(tab) {
		return tab.megamenu.maxSubItems > 0;
	}

	$scope.addMegaMenuCategory = function(tab) {
		tab.megamenu.categories.push({

		});
	}

	$scope.removeMegaMenuCategory = function(tab, $index) {
		tab.megamenu.categories.splice($index, 1);
		setTimeout(function() { $scope.$apply();}, 1)		;
	}

	$scope.getCategories = function(filter) {
		var url = 'index.php?route=module/journal_menu/categories&token=' + JMenu.CONSTS.token + '&filter=' + filter;
		return $http.get(url, {filter: filter}).then(function(response){
			if (response.data.status === 'success' && response.data.result) {
				return response.data.result;
			}
			alert('Error occured! Check admin permissions.');
			return [];
		});
	}

	/* brands */
	$scope.isBrands = function(tab) { return tab.itemType === 'brands'; }

	$scope.addBrand = function(tab) {
		tab.brands.brands.push({

		});
	}

	$scope.removeBrand = function(tab, $index) {
		tab.brands.brands.splice($index, 1);
	}

	$scope.getBrands = function(filter) {
		var url = 'index.php?route=module/journal_menu/brands&token=' + JMenu.CONSTS.token + '&filter=' + filter;
		return $http.get(url, {filter: filter}).then(function(response){
			if (response.data.status === 'success' && response.data.result) {
				return response.data.result;
			}
			alert('Error occured! Check admin permissions.');
			return [];
		});
	}

	/* custom blocks */
	$scope.isCustomBlock = function(tab) { return tab.itemType === 'customblock'; }

	/* simple menu */
	$scope.isSimpleMenu = function(tab) { return tab.itemType === 'simplemenu'; }

	$scope.addSimpleMenuItem = function(tab) {
		tab.simplemenu.items.push({
			name: {},
			link: '',
			newWindow: 0,
		});
	}

	$scope.removeSimpleMenuItem = function(tab, $index) {
		tab.simplemenu.items.splice($index, 1);
	}

	/* products */
	$scope.isProducts = function(tab) { return tab.itemType === 'products'; }

	$scope.addProducts = function(tab) {
		tab.products.products.push({
		});
	}

	$scope.removeProducts = function(tab, $index) {
		tab.products.products.splice($index, 1);
	}

	$scope.getProducts = function(filter) {
		var url = 'index.php?route=catalog/product/autocomplete&token=' + JMenu.CONSTS.token + '&filter_name=' + filter;
		return $http.get(url, {filter: filter}).then(function(response){
			if ($.isArray(response.data)) {
				return response.data;
			}
			alert('Error occured! Check admin permissions.');
			return [];
		});
	}

	/* save */
	$scope.save = function() {
		if ($('#save-btn').attr('disabled')) return;
		var data = {
			tabs: $.parseJSON(JSON.stringify($scope.tabs)),
			status: $scope.status,
			animation: $scope.animation
		};

		$http.post('index.php?route=module/journal_menu/save&token=' + JMenu.CONSTS.token, {data: data, store_id: $scope.store_id}).then(function(response){
			if(response.data.status === 'error') {
				alert(response.data.message);
			} else {
				location = 'index.php?route=extension/module&token=' + JMenu.CONSTS.token;
			}
		});
	}

	/* load */
	$scope.load = function() {
		$scope.tabs = [];
		$("#content").hide();
		$http.get('index.php?route=module/journal_menu/load&token=' + JMenu.CONSTS.token + '&store_id=' + $scope.store_id).then(function(response){
			if (response.data.result) {
				var tabs = response.data.result.tabs || [];
				_.each(tabs, function(element, index){
					var tab = new JMenu.Tab();
					tab.sort_order = element.sort_order;
					tab.name = element.name;
					var name = {};
					for(var i in tab.name) {
						name[i] = _.string.unescapeHTML(tab.name[i]);
					}
					tab.name = name;
					tab.status = element.status;
					tab.itemType = element.itemType;
					switch (element.itemType) {
						case 'megamenu':
							tab.megamenu.categories = element.megamenu.categories || [];
							tab.megamenu.showImages = element.megamenu.showImages || 1;
							tab.megamenu.maxSubItems = element.megamenu.maxSubItems || '';
							tab.megamenu.top_link = _.string.unescapeHTML(element.megamenu.top_link) || '';
							tab.megamenu.moreText = element.megamenu.moreText || {};
							for (var i in element.megamenu.moreText) {
								tab.megamenu.moreText[i] = _.string.unescapeHTML(element.megamenu.moreText[i]);
							}
							break;
						case 'brands':
							tab.brands.brands = element.brands.brands || [];
							tab.brands.showImages = element.brands.showImages || 1;
							break;
						case 'simplemenu':
							tab.simplemenu.items = element.simplemenu.items || [];
							for (var i in element.simplemenu.items) {
								for (var j in element.simplemenu.items[i].name) {
									tab.simplemenu.items[i].name[j] = _.string.unescapeHTML(element.simplemenu.items[i].name[j]);	
								}
								tab.simplemenu.items[i].link = _.string.unescapeHTML(element.simplemenu.items[i].link);
							}
							tab.simplemenu.link = _.string.unescapeHTML(element.simplemenu.link) || '';
							tab.simplemenu.newWindow = element.simplemenu.newWindow || 0;
							break;
						case 'products':
							tab.products.products = element.products.products || [];
							tab.products.showImages = element.products.showImages || 1;
							break;
					}
					$scope.tabs.push(tab);
				});
				$scope.status = response.data.result.status || 1;
				$scope.animation = 1;
				/* shit fix */
				setTimeout(function(){
					$('#tabs a').tabs();
					$('#tabs a').last().click();
					$('.language-tabs a').tabs();
					$('.vtabs-content').each(function(){
						$(this).find('.language-tabs a').first().click();
					});
					$scope.$apply();
				}, 1);
			}
			$(function(){
				$('#content').show();
			});
		});
	};

	$scope.load();

	/* validate */
	$scope.isValid = function(str) {
		str = str || "";
		return !str.trim().length > 0;
	}

	$scope.resetItems = function(index) {
		$scope.tabs[index].megamenu.categories = [];
		$scope.tabs[index].brands.brands = [];
		$scope.tabs[index].simplemenu.items = [];
		$scope.tabs[index].products.products = [];
	}

});
