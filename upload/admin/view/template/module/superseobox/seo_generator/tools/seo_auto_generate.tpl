<h3>Auto generate</h3><form class="form-horizontal"><table class="table table-condensed no-border">	<tbody>	<?php $i_auto_gen=1; foreach ($data['categoryEntity'] as $key => $val){	if($MD_CategoryEntites[$key]['type'] != 'generator')continue; ?>		<tr>			<td><span class="badge"><?php echo $i_auto_gen; ?></span></td>			<td>				<fieldset>				<div class="control-group">				<label class="control-label"><?php echo ${'text_category_name_'.$key}; ?></label>					<div class="controls">						<input type="hidden" name="data[categoryEntity][<?php echo $key; ?>][auto]" value=""/>						<input data-action="changeAutoGenerate" data-entity="<?php echo $key; ?>-all" data-scope=".parents('.controls').find('input')"  type="checkbox" value="true" <?php if($val['auto']) echo ' checked="checked" '; ?> name="data[categoryEntity][<?php echo $key; ?>][auto]" class="on_off" />					</div>				</div>				</fieldset>			</td>			<td class="info_text">				<dl>					<dt><?php echo ${'text_category_name_'.$key}; ?>:</dt>					<dd class="info-area">						<?php echo ${'text_auto_generator__'.$key}; ?>					</dd>				</dl>			</td>		</tr>	<?php $i_auto_gen++; } ?>		</tbody></table></form>	