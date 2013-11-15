/* todo: multiple slider_id=x on consecutive edits */

var JRev = {};

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
            };
        }
    };
});

angular.module('ui-tabs', []).directive('uiTabs', function() {
    return {
        require: '?ngModel',
        restrict: 'A',
        link: function(scope, element, attrs, ngModel) {
            $(element).find('a').tabs();
            scope.$watch('slider.slides', function(){
                $(element).find('a').tabs();
            });
        }
    };
});

angular.module('colorpicker', []).directive('colorpicker', function() {
    return {
        require: '?ngModel',
        restrict: 'A',
        link: function(scope, element, attrs, ngModel) {
            new jscolor.color($(element)[0], {
                required: false
            });
            $(element).change(function(){
                ngModel.$setViewValue($(element).val());
            });
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
            // console.log($element.attr('data-ng-model'));
            scope.$watch($element.attr('data-ng-model'), function(val){
                var text = $element.find('option:selected').text();
                // console.log($element.attr('data-ng-model') + ": " + text);
                $element.parent().find('.val').text(text);
            });
            // scope.$watch('module.layout_id', function(val){
            //     var text = $element.find('option:selected').text();
            //     $element.parent().find('.val').text(text);
            // });
        }
    };
});

JRev.consts = {
    NO_IMAGE: 'no_image.jpg',
    ID: null,
    SLIDE_TRANSITIONS: [
        'boxslide', 'boxfade',
        'slotzoom-horizontal', 'slotzoom-vertical', 'slotslide-horizontal', 'slotslide-vertical', 'slotfade-horizontal', 'slotfade-vertical',
        'curtain-1', 'curtain-2', 'curtain-3',
        'slideleft', 'slideright',
        'slideup', 'slidedown', 'slidehorizontal', 'slidevertical',
        'fade',
        'random',
        'papercut',
        'flyin',
        'turnoff',
        'cube',
        '3dcurtain-vertical',
        '3dcurtain-horizontal',
        'premium-random'
    ],
    ON_OFF: [
        '1',
        '0'
    ],
    NAVIGATION_TYPES: [
        'none',
        'bullet',
        'thumb'
    ],
    NAVIGATION_ARROWS: [
        'solo',
        'nexttobullets'
    ],
    NAVIGATION_STYLES: [
        'round',
        'square',
        'round-old',
        'square-old',
        'navbar-old'
    ],
    NAVIGATION_HALIGNS: [
        'left',
        'center',
        'right'
    ],
    NAVIGATION_VALIGNS: [
        'top',
        'center',
        'bottom'
    ],
    TARGETS_LINK: [
        '_blank',
        '_self'
    ],
    ANIMATION_EASINGS: [
    'easeOutBack', 'easeInQuad', 'easeOutQuad', 'easeInOutQuad', 'easeInCubic', 'easeOutCubic',
    'easeInOutCubic', 'easeInQuart', 'easeOutQuart', 'easeInOutQuart', 'easeInQuint',
    'easeOutQuint', 'easeInOutQuint', 'easeInSine', 'easeOutSine', 'easeInOutSine',
    'easeInExpo', 'easeOutExpo', 'easeInOutExpo', 'easeInCirc', 'easeOutCirc', 'easeInOutCirc',
    'easeInElastic', 'easeOutElastic', 'easeInOutElastic', 'easeInBack', 'easeOutBack', 'easeInOutBack',
    'easeInBounce', 'easeOutBounce', 'easeInOutBounce'
    ],

    ANIMATIONS_FROM: {
        '_none': 'None',
        'sft': 'Short from Top',
        'sfb': 'Short from Bottom',
        'sfr': 'Short from Right',
        'sfl': 'Short from Left',
        'lft': 'Long from Top',
        'lfb': 'Long from Bottom',
        'lfr': 'Long from Right',
        'lfl': 'Long from Left',
        'fade': 'fading',
        'randomrotate': 'Fade in, Rotate from a Random position and Degree'
    },

    ANIMATIONS_TO: {
        '_none': 'None',
        'stt': 'Short to Top',
        'stb': 'Short to Bottom',
        'str': 'Short to Right',
        'stl': 'Short to Left',
        'ltt': 'Long to Top',
        'ltb': 'Long to Bottom',
        'ltr': 'Long to Right',
        'ltl': 'Long to Left',
        'fadeout': 'fading',
        'randomrotateout': 'Fade in, Rotate from a Random position and Degree'
    },

    FONTS: []
};

JRev.AngularModule = angular.module('JRev', ['ck', 'switchify', 'custom-select', 'ui-tabs', 'colorpicker']);

JRev.AngularModule.directive('imageSelect', function(){
    return {
        replace: true,
        restrict: 'E',
        scope: {
            image: '=image'
        },
        templateUrl: 'view/javascript/journal/angular/template/image-select.html',
        controller: function($scope) {
            $scope.selectImage = function() {
                $('#dialog').remove();

                $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=' + JRev.consts.TOKEN + '&field=' + $scope.fieldId + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

                $('#dialog').dialog({
                    title: JRev.consts.IMAGE_MANAGER_TITLE,
                    bgiframe: false,
                    width: 700,
                    height: 400,
                    resizable: false,
                    modal: false,
                    close: function() {
                        var val = $('#' + $scope.fieldId).val();
                        if(val) {
                            $scope.image = val;
                            $scope.$apply();
                        }
                    }
                });
            };

            $scope.getImgLink = function() {
                return JRev.consts.IMAGE_URL + $scope.image;
            };

            $scope.clearImage = function() {
                $scope.image = JRev.consts.NO_IMAGE;
            };
        },
        link: function(scope, elem) {
            /* non optimal algorithm, to be improved! */
            var rnd;
            do {
                rnd = 'img-' + Math.floor((Math.random() * 10000000) + 1);
            } while($('#' + rnd).length);
            /* end of it */
            scope.fieldId = rnd;
            elem.find('input[type="hidden"]').attr('id', scope.fieldId);
        }
    };
});

JRev.JRevSlider = function() {
    var self = this;

    this.title = 'New Slider';
    this.height = 500;
    this.timer = 'top';
    /* model data */
    this.data = {};
    /* global settings */
    this.data.delay = 4000;
    // this.data.startheight = 500;
    // this.data.startwidth = 960;
    /* nav settings */
    this.data.onHoverStop = '1';
    // this.data.thumbWidth = 100;
    // this.data.thumbHeight = 50;
    // this.data.thumbAmount = 3;
    // this.data.hideThumbs = 0;
    this.data.navigationType = 'bullet';
    this.data.navigationArrows = 'solo';
    this.data.navigationStyle = 'round';
    this.data.navigationHAlign = 'center';
    this.data.navigationVAlign = 'bottom';
    this.data.navigationHOffset = 0;
    this.data.navigationVOffset = 10;
    this.data.touchenabled = 'on';
    this.data.fullWidth = '1';
    this.data.shadow = 0;
    /* slider slides */
    this.slides = [];

    this.addSlide = function(slide) {
        self.slides.push(slide);
        setTimeout(function(){
            $('.top-tabs a').tabs();
        }, 1);
    };

    this.removeSlide = function(index) {
        self.slides.splice(index, 1);
    };

    this.save = function() {
        var data = {
            height: self.height,
            title: self.title,
            timer: self.timer,
            data: self.data,
            slides: []
        };
        angular.forEach(self.slides, function (slide){
            this.push(slide.save());
        }, data.slides);
        return data;
    };

    this.load = function(data) {
        self.title = data.title;
        self.height = data.height;
        self.timer = data.timer || 'none';
        self.data = angular.extend(self.data, data.data);
        if (data.slides) {
            data.slides.forEach(function(data){
                var slide = new JRev.JRevSlide();
                slide.title = data.title;
                slide.bgimage = data.bgimage;
                slide.data = angular.extend(slide.data, data.data);
                slide.sort_order = data.sort_order;
                slide.data.link = _.string.unescapeHTML(slide.data.link);

                if(data.captions) {
                    data.captions.forEach(function(data){
                        var caption = new JRev.JRevCaption();
                        caption.title = data.title;
                        caption.caption_type = data.caption_type;
                        caption.video_type = data.video_type;
                        caption.video_height = data.video_height;
                        caption.video_width = data.video_width;
                        caption.url = _.string.unescapeHTML(data.url);
                        caption.caption_url = _.string.unescapeHTML(data.caption_url);
                        caption.caption_url_new_tab = data.caption_url_new_tab;
                        caption.caption_url_hover = data.caption_url_hover;
                        caption.image = data.image;
                        caption.animationfrom = data.animationfrom;
                        caption.animationto = data.animationto;
                        caption.fullscreen_video = data.fullscreen_video;
                        caption.text = _.string.unescapeHTML(data.text);
                        caption.text_color = data.text_color;
                        caption.font_name = data.font_name;
                        caption.font_size = data.font_size;
                        caption.font_weight = data.font_weight;
                        caption.font_transform = data.font_transform;
                        caption.sort_order = data.sort_order;
                        caption.data = angular.extend(caption.data, data.data);
                        slide.addCaption(caption);
                    });
                }

                self.addSlide(slide);
            });
        }
    };

};

JRev.JRevSlide = function() {
    var self = this;

    this.title = 'New Slide';
    /* slide options */
    this.bgimage = JRev.consts.NO_IMAGE;
    this.data = {};
    this.data.transition = 'random';
    this.data.slotamount = 1;
    this.data.masterspeed = 300;
    this.data.delay = '';
    this.data.link = '';
    this.data.new_window = '0';
    this.data.slideindex = 'next';
    this.sort_order = '';
    /* slide captions */
    this.captions = [];

    this.addCaption = function(caption) {
        self.captions.push(caption);
        setTimeout(function(){
            $('.bot-tabs a').tabs();
        }, 1);
    };

    this.removeCaption = function(index) {
        self.captions.splice(index, 1);
    };

    this.save = function() {
        var data = {
            title: self.title,
            bgimage: self.bgimage,
            data: self.data,
            sort_order: self.sort_order,
            captions: []
        };
        angular.forEach(self.captions, function(caption){
            this.push(caption.save());
        }, data.captions);
        return data;
    };
};

JRev.JRevCaption = function() {
    var self = this;

    this.title = 'New caption';
    this.caption_type = 'img';
    this.video_type = 'youtube';
    this.video_height = '';
    this.video_width = '';
    this.url = '';
    this.caption_url = '';
    this.caption_url_new_tab = '0';
    this.caption_url_hover = 'EA2E49';
    this.image = JRev.consts.NO_IMAGE;
    this.text = '';
    this.text_color = 'FFFFFF';
    this.font_name = 'Georgia, serif';
    this.font_size = '12px';
    this.font_weight = 'normal';
    this.font_transform = 'none';
    this.animationfrom = '_none';
    this.animationto = '_none';
    this.data = {};
    this.data.xx = 10;
    this.data.yy = 10;
    this.data.position = 1;
    this.data.hoffset = 0;
    this.data.voffset = 0;
    this.data.start = 0;
    this.data.speed = 500;
    this.data.end = 0;
    this.data.endspeed = 500;
    this.data.endeasing = 'easeOutQuart';
    this.data.easing = 'easeOutQuart';
    this.fullscreen_video = '0';
    this.data.autoplay = '0';
    this.data.nextslideatend = '0';
    this.sort_order = '';

    this.isImage = function() { return self.caption_type === 'img'; };
    this.isText = function() { return self.caption_type === 'text'; };
    this.isVideo = function() { return self.caption_type === 'video'; };

    this.save = function() {
        return {
            title: self.title,
            caption_type: self.caption_type,
            video_type: self.video_type,
            video_width: self.video_width,
            video_height: self.video_height,
            url: self.url,
            caption_url: self.caption_url,
            caption_url_new_tab: self.caption_url_new_tab,
            caption_url_hover: self.caption_url_hover,
            image: self.image,
            animationfrom: self.animationfrom,
            animationto: self.animationto,
            fullscreen_video: self.fullscreen_video,
            text: self.text,
            text_color: self.text_color,
            font_name: self.font_name,
            font_size: self.font_size,
            font_weight: self.font_weight,
            font_transform: self.font_transform,
            sort_order: self.sort_order,
            data: self.data
        };
    };
};

JRev.AngularModule.controller('JRevMainCtrl', function($scope){
    function loadConsts (c) {
        var res = [];
        angular.forEach(c, function(o, v){
            if ($.isNumeric(v)) {
                v = o;
            }
            this[v] = o.charAt(0).toUpperCase() + o.slice(1);
        }, res);
        return res;
    }
    /* load dropdown values */
    $scope.slide_transitions    = loadConsts(JRev.consts.SLIDE_TRANSITIONS);
    $scope.on_off               = loadConsts(JRev.consts.ON_OFF);
    $scope.navigation_types     = loadConsts(JRev.consts.NAVIGATION_TYPES);
    $scope.navigation_arrows    = loadConsts(JRev.consts.NAVIGATION_ARROWS);
    $scope.navigation_styles    = loadConsts(JRev.consts.NAVIGATION_STYLES);
    $scope.navigation_valigns   = loadConsts(JRev.consts.NAVIGATION_VALIGNS);
    $scope.navigation_haligns   = loadConsts(JRev.consts.NAVIGATION_HALIGNS);
    $scope.targets_link         = loadConsts(JRev.consts.TARGETS_LINK);
    $scope.animation_easings    = loadConsts(JRev.consts.ANIMATION_EASINGS);
    $scope.animations_from      = loadConsts(JRev.consts.ANIMATIONS_FROM);
    $scope.animations_to        = loadConsts(JRev.consts.ANIMATIONS_TO);

    /* load fonts */
    $.get(JRev.consts.GET_FONTS_URL, null, function(response){
        $scope.fonts = $.parseJSON(response);
        $scope.$apply();
        setTimeout(function(){
            $('[data-ng-model="caption.font_name"]').each(function(){
                var text = $(this).find('option:selected').text();
                $(this).parent().find('.val').text(text);    
            });
        }, 1);
    });

    $scope.font_sizes = [];
    for (var i=8; i<=100; i++) {
        $scope.font_sizes.push(i + 'px');
    }

    /* slider module */
    $scope.slider = new JRev.JRevSlider();

    /* load default data if exists */
    if (JRev.consts.GET_SLIDER_URL) {
        $.get(JRev.consts.GET_SLIDER_URL, null, function(response){
            if(response.data) {
                $scope.slider.load(response.data);
                $scope.$apply();
            }
            $(function(){
                $('#content').show();
            });
        }, 'json');
    }

    $scope.addSlide = function() {
        var slide = new JRev.JRevSlide();
        slide.active = true;
        $scope.slider.addSlide(slide);
        setTimeout(function(){
            $('.top-tabs a').last().prev().click();
        }, 10);
        return false;
    };

    $scope.removeSlide = function(slide, $index) {
        if(confirm('Delete slide ' + slide.title + '?')) {
            $scope.slider.removeSlide($index);
            setTimeout(function(){
                $('.top-tabs a').first().click();
            }, 10);
        }
        return false;
    };

    $scope.selectTab = function(e) {
        var $e = $(e.srcElement);
        $($e.attr('href')).find('.htabs a').first().click();
    }

    $scope.addCaption = function(slide, e) {
        var caption = new JRev.JRevCaption();
        caption.active = true;
        slide.addCaption(caption);
        setTimeout(function(){
            $(e.srcElement).closest('.bot-tabs').find('a').last().prev().click();
        }, 10);
        return false;
    };

    $scope.removeCaption = function(slide, caption, $index, e) {
        if(confirm('Delete caption ' + caption.title + '?')) {
            slide.removeCaption($index);
            setTimeout(function(){
                $(e.srcElement).closest('.bot-tabs').find('a').first().click();
            }, 10);
        }
        return false;
    };

    $scope.save = function() {
        var data = $scope.slider.save();
        // console.log(data); return;
        $('.loading').show();
        $.post(JRev.consts.SAVE_SLIDER_URL, {data: data}, function(response){
            $('.loading').hide();
            if(response.error) {
                alert('Error occured! Check admin permissions.');
                return;
            }
            JRev.consts.SAVE_SLIDER_URL += '&slider_id=' + response.id;
            $('.loading').hide();
            // location = JRev.consts.LIST_URL;
        }, 'json');
    };

    $scope.isIntroAnimated = function(caption) {
        return caption.animationfrom !== '_none';
    }

    $scope.isOutroAnimated = function(caption) {
        return caption.animationto !== '_none';
    }

});

JRev.AngularModule.controller('JRevPosCtrl', function($scope){
    $scope.modules = [];
    $scope.sliders = [];
    $scope.layouts = [];

    $.get(JRev.consts.GET_MODULES_URL, null, function(response){
        $scope.modules = response.modules || [];
        $scope.sliders = response.sliders || [];
        $scope.layouts = response.layouts || [];
        $scope.$apply();
    }, 'json');

    $scope.insertModule = function() {
        $scope.modules.push({
            position: 'content_top',
            sort_order: '',
            status: 1,
            slider: $scope.sliders[0].id,
            layout_id: $scope.layouts[0].layout_id
        });
    };

    $scope.deleteModule = function(index) {
        $scope.modules.splice(index, 1);
    };

    $scope.save = function() {
        $.post(JRev.consts.SAVE_MODULES_URL, {data: $scope.modules}, function(response){
            if(response.error) {
                alert('Error occured! Check admin permissions.');
                return;
            }
            location = JRev.consts.EXTENSIONS_URL;
        }, 'json');
    };

});

JRev.AngularModule.controller('JRevSlidersCtrl', function($scope){
    $scope.sliders = [];

    console.log(JRev.consts.GET_SLIDERS_URL);

    $.get(JRev.consts.GET_SLIDERS_URL, null, function(response){
        $scope.sliders = response.sliders;
        $scope.$apply();
        $('.check').prettyCheckable();
    }, 'json');

    $scope.editUrl = function(id) {
        return JRev.consts.EDIT_URL + '&slider_id=' + id;
    };

    $scope.deleteSliders = function() {
        var ids = [];
        $('.check:checked').each(function(){
            ids.push($(this).val());
        });
        if (ids.length) {
            $.post(JRev.consts.DELETE_SLIDERS_URL, {slider_ids: ids.join(',')}, function(response){
                if(response.error) {
                   alert('Error occured! Check admin permissions.');
                    return;
                }
               location = JRev.consts.LIST_URL;
            }, 'json');
        }
    };

});


$(window).load(function(){
    $('#content').show();
});