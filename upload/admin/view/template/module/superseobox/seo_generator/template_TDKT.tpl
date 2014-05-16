<!-- header start -->	
	<?php include 'template/header.tpl';?>
<!-- header end -->		
	<tr>
			<td>
				<fieldset>
				<div class="control-group">
					<div class="controls btn-group pull-right">
						<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-all" data-scope=".closest('form').find('input')" class="btn btn-success ajax_action" type="button">Generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for all pages!</a>
						<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-all" class="btn btn-danger ajax_action" type="button">Clear all</a>
					</div>
				</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Generate <?php echo ${'text_category_name_'.$entity_category_name}; ?>:</dt>
					<dd class="info-area">
						Here you can generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for all pages in the one click.
					</dd>
				</dl>
			</td>
	</tr>	
		
	<?php $item_count = 0; foreach ($data['entity'][$entity_category_name] as $key => $val) { ?>	
	<tr>
		<td class="TDKT-td">
			<fieldset>
			<div class="control-group one_control_group">
			<?php 
			if($entity_category_name == 'tags' AND $key == 'product'){
				$intro = "data-position=\"right\" data-intro=\"This is panel, which contain available parameters for templates. Just mouse over on any parameter and see tooltip, and then click on it for inserting to template below.\" data-step=\"8\" data-intro-action=\"$('a[href=#rich_snipets]').click();\"";
			}else{
				$intro = ''; 
			}
			?>
			<div class="pattern_line_label_hide">
				<button type="button" class="close close-popup">x</button>
				<H4>Click for insert</H4>
				<div class="btn-group pattern_line_label" <?php /*echo $intro;*/ ?> >
				
				<?php foreach ($CPBI_parameters[$key] as $parameter) {
					/* set additional value before insert START*/
					$addValDefault = '';
					if(isset($patterns_setting[$parameter]['additional'])){

						$additional_default = isset($patterns_setting[$parameter]['additional'][$key]) ? $patterns_setting[$parameter]['additional'][$key] : $patterns_setting[$parameter]['additional']['default'];
						
						$add_metaData = isset($patterns_setting[$parameter]['add_metaData'][$key]) ? $patterns_setting[$parameter]['add_metaData'][$key] : $patterns_setting[$parameter]['add_metaData']['default'];
						
			
						$addValDefault = str_replace('"','\'',json_encode(array('name' => $add_metaData, 'value' => $additional_default)));
					}
					/* set additional value before insert END*/
					
					$settingInfo_status = false;
					if(isset($patterns[$parameter]['settingInfo'])){
						$settingInfo_text = isset($patterns[$parameter]['settingInfo'][$key]) ? $patterns[$parameter]['settingInfo'][$key] : $patterns[$parameter]['settingInfo']['all'];
						if($settingInfo_text != ''){
							$settingInfo_status = true;
						}
					}
				?>	
					<a data-paramName="<?php echo $patterns[$parameter]['name']; ?>" data-addValPattern="<?php if($settingInfo_status){echo $settingInfo_text;} ?>" data-addValue ="<?php echo $addValDefault; ?>" data-toggle="tooltip" title="<?php echo $patterns[$parameter]['name']; if($settingInfo_status) { ?> </br>Possible additional setting: <?php echo $settingInfo_text;} ?>" class="seo_button_pattern btn btn-small"> !<?php echo $parameter; ?> </a>
				<?php } ?>
				</div>
			</div>
				<!--<?php if(count($languages)){ ?>
				<a class="btn">Copy template for all languages</a>
				<?php } ?>!-->
				<div class="tabbable"> 
					<ul class="nav nav-tabs">
						<?php $i_seo_descrip_lang_nav1 = 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
							<li <?php if($i_seo_descrip_lang_nav1 ==1) echo  "class=\"active\"";?>>
								<?php if(isset($val['pattern'])) { ?>
									<a href="#TDKT_<?php echo $entity_category_name.'-'.$key;?>_<?php echo $l_code;?>" data-toggle="tab">
										<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
									</a>
								<?php } ?>
							</li>
						<?php $i_seo_descrip_lang_nav1++; } ?>
						
					</ul>
				
					<div class="tab-content one_entity" style="overflow: hidden;">
						<?php $i_seo_descrip_lang_nav2 = 1; 
						foreach ($languages as $l_code => $language){ if(!$language['status'])continue; 
						if($entity_category_name == 'tags' AND $i_seo_descrip_lang_nav2 == 1 AND $key == 'product'){
							$intro = "data-position=\"right\" data-intro=\"This is area, where you can write your templates on the all languages and then generate SEO texts. Close tour and then try click on this field and you will see popup window with parameters for template.\" data-step=\"7\" data-intro-action=\"$('a[href=#rich_snipets]').click();\"";
						}else{
							$intro = '';
						}
						?>
						<div class="tab-pane <?php if($i_seo_descrip_lang_nav2 ==1) echo  "active";?>" id="TDKT_<?php echo $entity_category_name.'-'.$key;?>_<?php echo $l_code;?>">
							<!-- edit area -->
							<div class="controls <?php if($intro)echo "intro-input-click"; ?>" <?php echo $intro;?> >
								<div style="" class="input-prepend input-append">
									<span class="add-on item_name"> <?php echo ${'text_entity_name_'.$key}; ?></span>
									<span class="add-on status <?php if($val['status'] ==1){echo "status-on";}else{echo "status-off";}?>" data-toggle="tooltip" title="<?php if($val['status'] ==1){echo $text_status_on;}else{echo $text_status_off;}?>" data-placement="bottom"></span>
									<!-- set data for categories templates -->
										<?php if($key == 'product'){ ?>
											<?php 
											$additional_data = 'additionData[function]=setCategoryTemplateData&additionData[data][0]='. $entity_category_name .'&additionData[data][1]='. $key;
											$categor_templ_url = $this->url->link('module/superseobox/ajax', 'token=' . $this->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/category_template&'.$additional_data, 'SSL');
											?>
											<a style="padding-bottom: 3px;" data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $categor_templ_url; ?>" class="btn" type="button" data-toggle="modal"><span style="margin-top: 4px;" class="icon-filter"></span></a>
										<?php } ?>
										<!-- set data for categories templates -->
									<?php if(isset($val['pattern'])) { ?>
										<!-- data has language array !-->
										<input  data-toggle="popover" data-placement="top" data-content="<p>/<p><p>/<p>" data-original-title="Parameters for template" type="text" name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][data][<?php echo $l_code; ?>]" class="seo_input_pattern <?php if($key == 'product') echo"shortstyle"; ?>" value="<?php echo $val['data'][$l_code]; ?>">
									<?php }else{ ?>
										<!-- data has string emplate !-->
										<input  data-toggle="popover" data-placement="top" data-content="<p>/<p><p>/<p>" data-original-title="Parameters for template" type="text" name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][data]" class="seo_input_pattern <?php if($key == 'product') echo"shortstyle"; ?>" value="<?php echo $val['data']; ?>">
									<?php } ?>
									
									<div class="btn-group">
										<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-scope=".closest('.one_entity').find('input')" class="btn btn-success ajax_action" type="button">Generate!</a>
										
										<a class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li>
												<?php 
												$additional_data = 'additionData[function]=setReplacingData&additionData[data][0]='. $entity_category_name .'&additionData[data][1]='. $key;
												$exclusion_url = $this->url->link('module/superseobox/ajax', 'token=' . $this->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/replacing&'.$additional_data, 'SSL');
												?>
												<a data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $exclusion_url; ?>" class="btn-nonstyle" type="button" data-toggle="modal">Replacing</a>
											</li>
											<li>
												<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" class="bg_red btn-nonstyle ajax_action" type="button">Clear</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<!-- edit area -->
						</div>
						<?php $i_seo_descrip_lang_nav2++; } ?>
					</div>
				</div>
			</div>
			</fieldset>
		</td>
		<?php if($item_count == 0){ ?>
		<td class="info_text" rowspan="4">
			<dl>
				<dt>
				<?php echo 'Info of the generator for ' . ${'text_category_name_'.$entity_category_name} ?>:</dt>
				<dd class="info-area">
					<?php if($entity_category_name == 'alt_image' || $entity_category_name == 'title_image'){ ?>
					Here you can generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for Categories and Products. You can write own template for creating <?php echo ${'text_category_name_'.$entity_category_name}; ?> for every items. If you click on the button "Replacing", before use generator, you can easily add char or string for replacing in the <?php echo ${'text_category_name_'.$entity_category_name}; ?>. Button "Clear" removes all <?php echo ${'text_category_name_'.$entity_category_name}; ?>. <p class="colorFC580B">(Click on the button with caret (after button Generate) to see the buttons "Replacing" and "Clear")</p>
					<?php }else{ ?>
					Here you can generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for Categories, Products, Brands and Informations pages (CPBI). You can write own template for creating <?php echo ${'text_category_name_'.$entity_category_name}; ?> for every CPBI page. If you click on the button "Replacing", before use generator, you can easily add char or string for replacing in the <?php echo ${'text_category_name_'.$entity_category_name}; ?>. Button "Clear" removes all <?php echo ${'text_category_name_'.$entity_category_name}; ?>. <p class="colorFC580B">(Click on the button with caret (after button Generate) to see the buttons "Replacing" and "Clear")</p>
					<?php } ?>
				</dd>
			</dl>
		</td>
		<?php } ?>	
	</tr>
	<?php $item_count++; } ?>	
	</tbody>
</table>
<!-- header start -->	
	<?php include 'template/footer.tpl';?>
<!-- header end -->	