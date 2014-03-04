<form class="form-horizontal">
<div class="pull-left">
	<div class="control-group" style="margin: 0px 40px 0 0;"><span class="pull-right">Sort on Panel Box</span></div>
	<div class="control-group">
		<label class="control-label">QR-code</label>
		<div class="controls">
			<input type="hidden" name="data[tools][qr_code][status]" value="">
			<input type="checkbox" value="true" <?php if($data['tools']['qr_code']['status']) echo 'checked="checked"'; ?> name="data[tools][qr_code][status]" class="on_off noAlert">
			<input type="number" name="data[tools][qr_code][data][sort]" class="span1" min="1" max="10" value="<?php echo $data['tools']['qr_code']['data']['sort']; ?>" >
			<a data-afteraction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" class="btn btn-success ajax_action" type="button">Save</a>
		</div>
	</div>
</div>
</form>
<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/vnjP7Q66x-I?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>About QR-code</h3>

<p>A QR code consists of black modules (square dots) arranged in a square grid on a white background, which can be read by an imaging device such as a camera, smartphone and other.</p>

<p>This function adds QR-code with url of page to every page and your client can read url-page on own smartphone.</p>

<p>QR Codes can help your search engine optimisation greatly if used well. Combine all of your marketing efforts by including the innovative marketing trick that is the QR code and you could just find that your conversions soar.</p>

