<?php echo $header; ?>
<style type="text/css">
    .img-select img {
        max-width: 733px;
        height: auto;
        display: block;
    }
    i.icon-plus, i.icon-remove{
        cursor: pointer;
        background-color: #5bb75b;
        border-radius: 20px;
        width: 25px;
        height: 24px;
        background-position: -402px -92px;
        margin-top: 0;
        position: relative;
        top: -2px;
    }

    i:hover{
        background-color: #38BED8 !important;
    }
    

    i.icon-remove{
        background-position: -307px 5px;
        background-color: #f4f4f4;
        margin-left: 15px;
    }
   
    table.form tbody tr:last-child td{
        border-bottom: 1px dotted #CCC;
    }
    table.form > tbody > tr > td:first-child{
        width: 130px;
    }
    .button-remove{
        float: right;
    }
    .vtabs-content table tr:last-child td:last-child,
    .vtabs-content table tr:last-child td:first-child{
        border-radius: 0;
    }
    table.list{
        width:730px;
        margin-bottom: 0;
    }
    table.list td{
        text-align: center;
        height: 25px;
        padding:8px 0;
    }
    .buttons a{
        color:white;
    }
    .htabs{
        margin-left: 0;
    }
    .htabs a{
        float:left;
    }
    input[type="text"]{
        width: 90px;
    }
</style>
<div id="JRev" data-ng-app="JRev">
    <div id="content" data-ng-controller="JRevMainCtrl">
        <div class="heading">
            <h1><?php echo $doc_title; ?></h1>
            <div class="links">
                <a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
                <a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
            </div>
            <div class="buttons">
                <span class="loading" style="display: none; font-size:15px; font-weight:bold;">Saving...</span>
                <a class="btn btn-success" data-ng-click="save();"><?php echo $button_save; ?></a>
                <a class="btn btn-danger" href="<?php echo $consts['list_url']; ?>"><?php echo $button_cancel; ?></a>
            </div>
        </div>

        <div class="box">
            <div class="content">
                <form id="form">
                    <div class="htabs top-tabs" ui-tabs>
                        <a href="#top-tab-general-options">General options</a>
                        <a href="#top-tab-slide-{{$index}}" data-ng-click="selectTab($event)" ng-repeat="slide in slider.slides">{{slide.title}}<i class="icon-remove" data-ng-click="removeSlide(slide, $index)" onclick="return false;"></i></a>
                        <a href="#top-tab-add-slide" onclick="return false;"><i class="icon-plus" data-ng-click="addSlide()"></i></a>
                    </div>
                    <!-- general options -->
                    <div id="top-tab-general-options">
                        <table class="form">
                            <tr>
                                <td>Slider Name: </td>
                                <td><input type="text" data-ng-model="slider.title" /></td>
                            </tr>
                            <tr>
                                <td>Maine Slide Duration: </td>
                                <td><input type="text" data-ng-model="slider.data.delay" /></td>
                            </tr>
                            <tr>
                                <td>Timer position: </td>
                                <td><select data-ng-model="slider.timer" custom-select>
                                    <option value="none">None</option>
                                    <option value="top">Top</option>
                                    <option value="bottom">Bottom</option>
                                </select></td>
                            </tr>
                            <tr>
                                <td>Pause Slider on Hover: </td>
                                <td><select data-ng-model="slider.data.onHoverStop" switchify>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select></td>
                            </tr>
                            <tr>
                                <td>Navigation Style: </td>
                                <td><select data-ng-model="slider.data.navigationStyle" custom-select data-ng-options="k as v for (k,v) in navigation_styles"></select></td>
                            </tr>
                            <tr>
                                <td>Nav Hozizontal Align: </td>
                                <td><select data-ng-model="slider.data.navigationHAlign" custom-select data-ng-options="k as v for (k,v) in navigation_haligns"></select></td>
                            </tr>
                            <tr>
                                <td>Nav Vertical Align: </td>
                                <td><select data-ng-model="slider.data.navigationVAlign" custom-select data-ng-options="k as v for (k,v) in navigation_valigns"></select></td>
                            </tr>
<!--                             <tr>
                                <td>Touch Enabled: </td>
                                <td><select data-ng-model="slider.data.touchenabled" switchify>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select></td>
                            </tr> -->
                            <tr>
                                <td>Full Width: </td>
                                <td><select data-ng-model="slider.data.fullWidth" switchify>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select></td>
                            </tr>
                            <tr>
                                <td>Slider Height: </td>
                                <td><input type="text" data-ng-model="slider.height" /></td>
                            </tr>
                        </table>
                    </div>
                    <!-- slides -->
                    <div id="top-tab-slide-{{$index}}" ng-repeat="slide in slider.slides" class="htabs-content" style="display: none;">
                        <table class="form">
                            <tr>
                                <td>Slide Name: </td>
                                <td><input type="text" data-ng-model="slide.title" /></td>
                            </tr>
                            <tr>
                                <td>Maine Slide Image: </td>
                                <td><image-select image="slide.bgimage"></image-select></td>
                            </tr>
                            <tr>
                                <td>Transition: </td>
                                <td>
                                    <select data-ng-model="slide.data.transition" custom-select data-ng-options="k as v for (k,v) in slide_transitions"></select>
                                </td>
                            </tr>
                            <tr>
                                <td>Slot Amount : </td>
                                <td><input type="text" data-ng-model="slide.data.slotamount" /></td>
                            </tr>
                            <tr>
                                <td>Master Speed: </td>
                                <td><input type="text" data-ng-model="slide.data.masterspeed" /></td>
                            </tr>
                            <tr>
                                <td>Delay: </td>
                                <td><input type="text" data-ng-model="slide.data.delay" /></td>
                            </tr>
                            <tr>
                                <td>Link: </td>
                                <td><input type="text" style='width:300px;' data-ng-model="slide.data.link" /></td>
                            </tr>
                            <tr>
                                <td>New Tab: </td>
                                <td>
                                    <select data-ng-model="slide.data.new_window" switchify>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Sort order: </td>
                                <td><input type="text" data-ng-model="slide.sort_order" /></td>
                            </tr>
                        </table>
                        <div class="htabs bot-tabs" ui-tabs>
                            <a href="#bot-tab-caption-{{$parent.$index}}-{{$index}}" ng-repeat="caption in slide.captions">{{caption.title}}<i class="icon-remove" data-ng-click="removeCaption(slide, caption, $index, $event)" onclick="return false;"></i></a>
                            <a href="#bot-tab-add-caption" onclick="return false;"><i class="icon-plus" data-ng-click="addCaption(slide, $event)"></i></a>
                        </div>
                        <div id="bot-tab-caption-{{$parent.$index}}-{{$index}}" ng-repeat="caption in slide.captions" class="htabs-content">
                            <table class="form">
                                <tr>
                                    <td>Caption Name: </td>
                                    <td><input type="text" data-ng-model="caption.title" /></td>
                                </tr>
                                <tr>
                                    <td>Caption Type: </td>
                                    <td>
                                        <select data-ng-model="caption.caption_type" custom-select>
                                            <option value="text">Text</option>
                                            <option value="img">Image</option>
                                            <option value="video">Video</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr ng-show="caption.isText()">
                                    <td>Text: </td>
                                    <td><textarea style='width:300px;' data-ng-model="caption.text"></textarea></td>
                                </tr>
                                <tr ng-show="caption.isImage()">
                                    <td>Image: </td>
                                    <td><image-select image="caption.image"></image-select></td>
                                </tr>

                                <tr ng-show="caption.isImage() || caption.isText()">
                                    <td>Caption Url: </td>
                                    <td><input type="text" style='width:300px;' data-ng-model="caption.caption_url" /></td>
                                </tr>
                                <tr ng-show="caption.isImage() || caption.isText()">
                                    <td>Caption Url New Tab: </td>
                                    <td><select data-ng-model="caption.caption_url_new_tab" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select></td>
                                </tr>
                                <tr ng-show="caption.isText()">
                                    <td>Color: </td>
                                    <td><input type="text" class="color" colorpicker data-ng-model="caption.text_color" /></td>
                                </tr>
                                <tr ng-show="caption.isText()">
                                    <td>Hover Color: </td>
                                    <td><input type="text" class="color" colorpicker data-ng-model="caption.caption_url_hover" /></td>
                                </tr>

                                <tr ng-show="caption.isText()">
                                    <td>Font: </td>
                                    <td>
                                        <!-- <select data-ng-model="caption.font_name" custom-select>
                                            <optgroup label="System">
                                                <option data-ng-repeat="font in fonts.system">{{font.font_name}}</option>
                                            </optgroup>
                                            <optgroup label="Google">
                                                <option data-ng-repeat="font in fonts.google">{{font.font_name}}</option>
                                            </optgroup>
                                        </select> -->
                                        <select data-ng-model="caption.font_name" custom-select data-ng-options="font.font_name as font.font_family group by font.group for font in fonts">
                                        </select>
                                        <select data-ng-model="caption.font_size" custom-select data-ng-options="v as v for v in font_sizes">
                                        </select>
                                        <select data-ng-model="caption.font_weight" custom-select>
                                            <option value="bold">Bold</option>
                                            <option value="normal">Normal</option>
                                        </select>
                                        <select data-ng-model="caption.font_transform" custom-select>
                                            <option value="none">None</option>
                                            <option value="uppercase">Uppercase</option>
                                            <option value="lowercase">Lowercase</option>
                                        </select>
                                    </td>
                                </tr>

                                <tr ng-show="caption.isVideo()">
                                    <td>Video Type: </td>
                                    <td>
                                        <select data-ng-model="caption.video_type" custom-select>
                                            <option value="youtube">Youtube</option>
                                            <option value="vimeo">Vimeo</option>
                                            <option value="local">Local HTML5</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Video Url:</td>
                                    <td><input type="text" data-ng-model="caption.url" /></td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Fullscreen Video: </td>
                                    <td>
                                        <select data-ng-model="caption.fullscreen_video" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Autoplay Video: </td>
                                    <td>
                                        <select data-ng-model="caption.data.autoplay" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Next Slide on End: </td>
                                    <td>
                                        <select data-ng-model="caption.data.nextslideatend" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Video Width: </td>
                                    <td><input type="text" data-ng-model="caption.video_width" /></td>
                                </tr>
                                <tr ng-show="caption.isVideo()">
                                    <td>Video Height: </td>
                                    <td><input type="text" data-ng-model="caption.video_height" /></td>
                                </tr>

                                <tr ng-show="caption.isVideo()">
                                    <td>Next Slide on End: </td>
                                    <td>
                                        <select data-ng-model="caption.data.nextslideatend" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Absolute Positioning: <br /><small>More precise on responsive</small> </td>
                                    <td>
                                        <select data-ng-model="caption.data.position" switchify>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr data-ng-show="caption.data.position=='1'">
                                    <td>X: </td>
                                    <td><input type="text" data-ng-model="caption.data.xx" /></td>
                                </tr>
                                <tr data-ng-show="caption.data.position=='1'">
                                    <td>Y: </td>
                                    <td><input type="text" data-ng-model="caption.data.yy" /></td>
                                </tr>

                                <tr data-ng-show="caption.data.position=='0'">
                                    <td>Horizontal Offset: </td>
                                    <td><input type="text" data-ng-model="caption.data.hoffset" /></td>
                                </tr>
                                <tr data-ng-show="caption.data.position=='0'">
                                    <td>Vertical Offset: </td>
                                    <td><input type="text" data-ng-model="caption.data.voffset" /></td>
                                </tr>

                                <tr>
                                    <td>Intro Animation: </td>
                                    <td><select data-ng-model="caption.animationfrom" custom-select data-ng-options="k as v for (k,v) in animations_from"></select></td>
                                </tr>
                                <tr data-ng-show="isIntroAnimated(caption)">
                                    <td>Intro Animation Speed: </td>
                                    <td><input type="text" data-ng-model="caption.data.speed" /></td>
                                </tr>
                                <tr data-ng-show="isIntroAnimated(caption)">
                                    <td>Intro Animation Delay: </td>
                                    <td><input type="text" data-ng-model="caption.data.start" /></td>
                                </tr>
                                <tr data-ng-show="isIntroAnimated(caption)">
                                    <td>Intro Animation Easing: </td>
                                    <td><select data-ng-model="caption.data.easing" custom-select data-ng-options="k as v for (k,v) in animation_easings"></select></td>
                                </tr>
                                <tr>
                                    <td>Outro Animation: </td>
                                    <td><select data-ng-model="caption.animationto" custom-select data-ng-options="k as v for (k,v) in animations_to"></select></td>
                                </tr>

                                <tr data-ng-show="isOutroAnimated(caption)">
                                    <td>Outro Animation Speed: </td>
                                    <td><input type="text" data-ng-model="caption.data.endspeed" /></td>
                                </tr>

                                <tr data-ng-show="isOutroAnimated(caption)">
                                    <td>Outro Animation Delay: </td>
                                    <td><input type="text" data-ng-model="caption.data.end" /></td>
                                </tr>

                                <tr data-ng-show="isOutroAnimated(caption)">
                                    <td>Outro Animation Easing: </td>
                                    <td><select data-ng-model="caption.data.endeasing" custom-select data-ng-options="k as v for (k,v) in animation_easings"></select></td>
                                </tr>
                                <tr>
                                    <td>Sort order: </td>
                                    <td><input type="text" data-ng-model="caption.sort_order" /></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $js_consts; ?>
<?php echo $footer; ?>


