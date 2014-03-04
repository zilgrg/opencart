<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">Direct Languages Links</label>
		<div class="controls">
			<input type="hidden" name="data[tools][lang_dir_link][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['lang_dir_link']['status']) echo 'checked="checked"'; ?> name="data[tools][lang_dir_link][status]" class="on_off noAlert">
		</div>
	</div>
</div>

<h3>What is a Language Direct Links?</h3>

<p class="colorFC580B">
This feature work only if  SEO URLs was generated (see in tab generators -> SEO URLs)
</p>

<p>If you have a few languages, then switching on other language occurs through js-code, which prepares request on server and on your page not present direct link on other pages languages. This module replaces standard block of languages:</p>
<pre>
<?php echo htmlspecialchars(
	'<div id="language">
        <img src="image/flags/us.png" alt="English" title="English" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'en\'); $(this).parent().parent().submit();">
        <img src="image/flags/fr.png" alt="French" title="French" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'fr\'); $(this).parent().parent().submit();">
        <img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'uk\'); $(this).parent().parent().submit();">
        <input type="hidden" name="language_code" value="">
		<input type="hidden" name="redirect" value="http://site.com">
	</div>'); 
  
?>
</pre>
<p>on direct links, like this:</p>
<pre>
<?php echo htmlspecialchars(
'<div id="language">Language<br>
	<a href="http://site.com"><img src="image/flags/us.png" alt="English" title="English"></a>
	<a href="http://site.com/fr"><img src="image/flags/fr.png" alt="French" title="French"></a>
	<a href="http://site.com/uk"><img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian"></a>
</div>
'); 
?>
</pre>
<p>
After this transform, any search Engine will find this links and will make index for them.
</p>