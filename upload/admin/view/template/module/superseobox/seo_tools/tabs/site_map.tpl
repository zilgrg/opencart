<div class="pull-left form-horizontal" style="margin-bottom:20px; margin-right:20px;">
	<div class="control-group">
		<label class="control-label">Sitemap</label>
		<div class="controls">
			<input type="hidden" name="additionData[changeSitemapStatus]" value="true">
			<input type="hidden" name="data[tools][sitemap][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('.pull-left').find('input, select')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['status']) echo 'checked="checked"'; ?> name="data[tools][sitemap][status]" class="on_off noAlert">
			<a data-afteraction="afterAction" data-action="save" data-scope=".closest('.pull-left').find('input, select')" class="btn ajax_action btn-success" type="button">Save</a>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Only canonical links</label>
		<div class="controls">
			<input type="hidden" name="data[tools][sitemap][data][only_canonical]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['data']['only_canonical']) echo 'checked="checked"'; ?> name="data[tools][sitemap][data][only_canonical]" class="on_off">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Links in the all languages</label>
		<div class="controls">
			<input type="hidden" name="data[tools][sitemap][data][all_language]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['data']['all_language']) echo 'checked="checked"'; ?> name="data[tools][sitemap][data][all_language]" class="on_off">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="">
			Priority for products
		</label>
		<div class="controls">
			<input name="data[tools][sitemap][data][priorProduct]" class="span1" value="<?php echo $data['tools']['sitemap']['data']['priorProduct'];?>" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="">
			Priority for other
		</label>
		<div class="controls">
			<input name="data[tools][sitemap][data][priorOther]" class="span1" value="<?php echo $data['tools']['sitemap']['data']['priorOther'];?>" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
		</div>
	</div>
	<div class="control-group" style="margin-bottom: 10px;">
		<label class="control-label" for="">
			Change frequency
		</label>
		<div class="controls">
			<?php $freqs = array('always', 'hourly', 'daily' , 'weekly', 'monthly', 'yearly', 'never'); ?>
			<select name="data[tools][sitemap][data][freq]">
				<?php foreach ($freqs as $freq) { ?>
				<option value="<?php echo $freq; ?>" <?php if($freq == $data['tools']['sitemap']['data']['freq']) echo 'selected="selected"' ?> ><?php echo ucwords($freq); ?></option>
				<?php } ?>
			</select>
		</div>
	</div>
</div>
<h4>What is the "Only canonical links"?</h4>
<p>A canonical page is the preferred version of a set of pages with highly similar content.</p>
<p>If you have products in a few categories your sitemap will be contain all links to this product from other categories and this is not good.<p>
<p>Also, if you have the manufacturers, then sitemap will be contain the link on the products from the manufacturers, plus will be the canonical links on the same products - this is bad for Google.</p>
<p>Turn On this function will be guarantee, that only the one links will be to the one product.</p>

<h4>What is the "Links in the all languages"?</h4>
<p>If you have a few languages sitemap will contain links of pages only on the default language. When you turn ON this function the sitemap will contain links in all languages. Before use this function you must generate SEO URLs in the "Generator -> SEO URLs".</p>
<p>

<h4>After you have turn ON Sitemap, you can check result below</h4>
If you generated SEO URL, then you can find sitemap from the address below:</br>
<a href="<?php echo HTTP_CATALOG; ?>sitemap.xml"><?php echo HTTP_CATALOG; ?>sitemap.xml</a>
</p>
<p>
If not, then:</br>
<a href="<?php echo HTTP_CATALOG; ?>index.php?route=feed/google_sitemap"><?php echo HTTP_CATALOG; ?>index.php?route=feed/google_sitemap</a>
</p>