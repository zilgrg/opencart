<p>This panel is using for show Social buttons and QR-code.
Here you can customize it special for your site.</p>

<form class="form-horizontal shar-setting-tabs">
<a data-afteraction="afterAction" data-action="save" data-scope=".closest('form').find('.save_all_true input, .save_all_true select')" class="btn btn-success ajax_action span2" type="button">Save all</a>
<table class"table">
	<tbody>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Display Mode</label>
						<div class="controls">
							<select style="margin-bottom:5px;" name="data[tools][panel_box][mode]">
								<option value="button" <?php if($data['tools']['panel_box']['mode'] == 'button') { echo 'selected="selected"';} ?> >Button</option>
								<option value="panel" <?php if($data['tools']['panel_box']['mode'] == 'panel') { echo 'selected="selected"';} ?> >Panel</option>
							</select>
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Animate:</dt>
					<dd class="info-area">
						Animate for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Background color</label>
						<div class="controls">
							<input name="data[tools][panel_box][css][background]" type="text" class="span2 color {hash:true,  pickerFaceColor:'transparent',pickerFace:3,pickerBorder:0,pickerInsetColor:'black'}" value="<?php echo $data['tools']['panel_box']['css']['background']; ?>">
							Status:
							<input type="hidden" name="data[tools][panel_box][css][bg_status]" value="">
							<input data-afteraction="afterAction" data-action="save" data-scope=".closest('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['css']['bg_status']) echo 'checked="checked"'; ?> name="data[tools][panel_box][css][bg_status]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Background color:</dt>
					<dd class="info-area">
						Background color for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Opacity</label>
						<div class="controls">
							<input class="span2" name="data[tools][panel_box][css][opacity]" type="text" placeholder="Add opacity" value="<?php echo $data['tools']['panel_box']['css']['opacity']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Opacity:</dt>
					<dd class="info-area">
						Opacity for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Border Radius</label>
						<div class="controls">
							<input  class="span2" name="data[tools][panel_box][css][border_r]" type="text" value="<?php echo $data['tools']['panel_box']['css']['border_r']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Border Radius:</dt>
					<dd class="info-area">
						Border Radius for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Margin</label>
						<div class="controls">
							<input  class="span2" name="data[tools][panel_box][css][margin]" type="text" value="<?php echo $data['tools']['panel_box']['css']['margin']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Margin:</dt>
					<dd class="info-area">
						Margin for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Direction</label>
						<div class="controls">
							<select name="data[tools][panel_box][position][direction]">
								<option value="">Choose direction</option>
								<option value="horizontal" <?php if($data['tools']['panel_box']['position']['direction'] == 'horizontal') { echo 'selected="selected"';} ?> >Horizontal</option>
								<option value="vertical" <?php if($data['tools']['panel_box']['position']['direction'] == 'vertical') { echo 'selected="selected"';} ?> >Vertical</option>
							</select>
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Direction:</dt>
					<dd class="info-area">
						Direction for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
		<div class="control-group shar-bar-position">
			<div class="empty_field">
			<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="">
			<input type="hidden" name="data[tools][panel_box][position][centerX]" value="">
			<input type="hidden" name="data[tools][panel_box][position][centerY]" value="">
			</div>
			<label style="font-weight:bold;" class="control-label">Position</label>
			<table style="width:auto;" class="table share-box-position">
				<tbody>
					<tr>
						<td class="targetLeft-targetTop">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lt">
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lt') echo 'btn-success' ?>">Move to upper left</a>
						</td>
						<td class="targetLeft-targetTop-centerX">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="ltx">
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerX]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop-centerX input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'ltx') echo 'btn-success' ?>">Move to upper center</a>
						</td>
						<td class="targetRight-targetTop">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rt">
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetTop input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rt') echo 'btn-success' ?>">Move to upper right</a>
						</td>
					</tr>
					<tr>
						<td class="targetLeft-targetTop-centerY">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lty">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerY]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop-centerY input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lty') echo 'btn-success' ?>">Move to center left</a>
						</td>
						<td>
						
						</td>
						<td class="targetRight-targetTop-centerY">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rty">
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerY]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetTop-centerY input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rty') echo 'btn-success' ?>">Move to center right</a>
						</td>
					</tr>
					<tr>
						<td class="targetLeft-targetBottom">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lb">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetBottom input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lb') echo 'btn-success' ?>">Move to lower left</a>
						</td>
						<td class="targetLeft-targetBottom-centerX ">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lbx">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerX]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetBottom-centerX input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lbx') echo 'btn-success' ?>">Move to lower center</a>
						</td>
						<td class="targetRight-targetBottom">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rb">	
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetBottom input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rb') echo 'btn-success' ?>">Move to lower right</a>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="controls">
				
			</div>
		</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Position:</dt>
					<dd class="info-area">
						Position for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Animate</label>
						<div class="controls">
							<input type="hidden" name="data[tools][panel_box][animate]" value="">
							<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['animate']) echo 'checked="checked"'; ?> name="data[tools][panel_box][animate]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Animate:</dt>
					<dd class="info-area">
						Animate for Panel Bar.
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Behavior</label>
						<div class="controls">
							if width of window is less then
							<input style="margin-bottom:5px;"  class="span2" name="data[tools][panel_box][behavior][width_less]" type="text" value="<?php echo $data['tools']['panel_box']['behavior']['width_less']; ?>"></br>
							, then move panel box to
							<select style="margin-bottom:5px;" name="data[tools][panel_box][behavior][move_to]">
								<option value="">Choose position</option>
								<option value="top" <?php if($data['tools']['panel_box']['behavior']['move_to'] == 'top') { echo 'selected="selected"';} ?> >Top</option>
								<option value="bottom" <?php if($data['tools']['panel_box']['behavior']['move_to'] == 'bottom') { echo 'selected="selected"';} ?> >Bottom</option>
							</select></br>
							, or hide this block
							<input type="hidden" name="data[tools][panel_box][behavior][hide]" value="">
							<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['behavior']['hide']) echo 'checked="checked"'; ?> name="data[tools][panel_box][behavior][hide]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Behavior:</dt>
					<dd class="info-area">
						Behavior for Panel Bar during resize windows, and changing position for device with small screen.
					</dd>
				</dl>
			</td>
		</tr>		
	</tbody>
</table>
</form>
<h3>A few examples customization of Panel Bar:</h3>
<div class="panel-bar-example"></div>

