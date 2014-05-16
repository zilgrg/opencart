<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">Languages Link</label>
		<div class="controls">
			<input type="hidden" name="data[tools][href_lang][status]" value="">
			<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['href_lang']['status']) echo 'checked="checked"'; ?> name="data[tools][href_lang][status]" class="on_off">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/8ce9jv91beQ?rel=0" frameborder="0" allowfullscreen></iframe>
<p class="colorFC580B">
This feature work only if  SEO URLs was generated (see in tab generators -&gt; SEO URLs)
</p>
<div class="clearfix"></div>
<h3>Help Google serve the correct language or regional URL</h3>

<p>Many websites serve users from around the world, with content that's translated or targeted to users in a certain region. Google uses the rel="alternate" hreflang="x" annotations to serve the correct language or regional URL to searchers.</p>

<h3>Using language annotations</h3>
<p>Imagine you have an English language page hosted at http://www.site.com/, with a Spanish alternative at http://site.com/es. This function indicates to Google that the Spanish URL is the Spanish-language equivalent of the English page via adding this link:</p>
<pre>&lt;rel="alternate" hreflang="es" href="http://site.com/es"/&gt;</pre>

<p>If you have multiple language versions of a URL, each language page must identify all language versions, including itself.  For example, if your site provides content in French, English, and Spanish, the Spanish version must include a rel="alternate" hreflang="x" link for itself in addition to links to the French and English versions. Similarly, the English and French versions must each include the same references to the French, English, and Spanish versions.</p>