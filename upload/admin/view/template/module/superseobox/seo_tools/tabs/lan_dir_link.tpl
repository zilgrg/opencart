<div>
	<div class="control-group form-horizontal">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Mode for Direct Languages Links</label>
				<?php $mode = $data['tools']['lang_dir_link']['data']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="natural" class="btn btn-success <?php if($mode == 'natural') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set natural mode" >
						Natural</a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="special" class="btn btn-success <?php if($mode == 'special') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set special mode" >
						Special</a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul mode" >
						Default</a>
					</div>
					<input type="hidden" name="data[tools][lang_dir_link][data][mode]" value="<?php echo $mode; ?>">
				</div>
			</div>
		</form>
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
<h3>With Direct Languages Links, this will be a like this:</h3>

<p>
	<h4>In Natural mode</h4>
	After domain Paladin adding the language prefix fr/ - for french and uk/ - for ukrainian</br>
	THIS MODE IS NOT SAFE FOR OTHER MODULES AND DOES NOT WARRANT THE CORRECT CHANGING LANGUAGES.
	<pre>
	<?php echo htmlspecialchars(
	'<div id="language">Language<br>
		<a href="http://site.com/category"><img src="image/flags/us.png" alt="English" title="English"></a>
		<a href="http://site.com/fr/category"><img src="image/flags/fr.png" alt="French" title="French"></a>
		<a href="http://site.com/uk/category"><img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian"></a>
	</div>');?></pre></br>
</p>

<p>
	<h4>In Special mode</h4>
	After domain Paladin adding the special prefix change-fr/ - for french and change-uk/ - for ukrainian</br>
	THIS MODE IS SAFE FOR OTHER MODULES AND WARRANT THE CORRECT CHANGING LANGUAGES
	<pre>
	<?php echo htmlspecialchars(
	'<div id="language">Language<br>
		<a href="http://site.com"/category><img src="image/flags/us.png" alt="English" title="English"></a>
		<a href="http://site.com/change-fr/category"><img src="image/flags/fr.png" alt="French" title="French"></a>
		<a href="http://site.com/change-uk/category"><img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian"></a>
	</div>');?></pre></br>
</p>

<p>
	<h4>In Default mode</h4>
	Uses the standard Opencart languages block
</p>

<h5>
After this transform, any search Engine will find this links and will make index for them.
</h5>