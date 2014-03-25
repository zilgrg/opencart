<a data-afteraction="afterSnipetToolsCahnge" data-action="save" data-scope=".parent().find('form').find('input')" class="btn btn-success ajax_action span2" type="button">Save all</a>
<form class="form-horizontal">
<div class="pull-left">
	<div class="control-group" style="margin: 0px 30px 0 0;"><span class="pull-right">Sort</span></div>
	<?php foreach($data['tools']['soc_buttons']['data'] as $name => $soc_data){ ?>
	<div class="control-group">
		<label class="control-label"><?php echo $name; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][soc_buttons][data][<?php echo $name; ?>][status]" value="">
			<input type="checkbox" value="true" <?php if($data['tools']['soc_buttons']['data'][$name]['status']) echo 'checked="checked"'; ?> name="data[tools][soc_buttons][data][<?php echo $name; ?>][status]" class="on_off noAlert">
			
			<input type="number" class="span1" min="0" max="10"  name="data[tools][soc_buttons][data][<?php echo $name; ?>][data][sort]" value="<?php echo $data['tools']['soc_buttons']['data'][$name]['data']['sort']; ?>" >
		</div>
	</div>
	<?php }?>
</div>
</form>

<p class="pull-left span6 info_text">
Here you can add social buttons on every page on your site. 
</br>
<span class="colorFC580B"> After you turn on any of these buttons on your pages will be created floating or fixed panel bar, which you can customize in <a href="#seo_social_set_panel_bar" data-toggle="tab">Setting Panel bar</a></span>
</p>


