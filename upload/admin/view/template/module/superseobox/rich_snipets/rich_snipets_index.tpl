

<div class="box-block work-seo-box">
	<h2>Rich Snippets</h2>
	<div class="tabbable tabs-left">
		<ul id="rich_snippets_menu" class="seo-item-menu nav nav-tabs" data-position="right" data-intro="Now, we are in tab 'Rich Snipets' and this is it's menu. Here we can easily insert Google, Facebook and Twitter code on your page for improve display on SERP(Search Engine Results Page) on Google and correct displaying  yours pages on the Facebook and Twitte." data-intro-action="$('a[href=#seo_tools]').click();" data-step="9">
			<span>Snipets</span>
			<li class="active">
				<a href="#rich_snippets_micro_data" data-toggle="tab">
					<i class="icon-play"></i> 
					Google Microdata
				</a>
			</li>
			<li>
				<a href="#rich_snippets_open_graph" data-toggle="tab">
					<i class="icon-fast-backward"></i> 
					Open Graph
				</a>
			</li>
			<li>
				<a href="#rich_snippets_twitter_card" data-toggle="tab">
					<i class="icon-backward"></i> 
					Twitter Card
				</a>
			</li>
		</ul>
		
		<div class="tab-content">
			<div class="tab-pane active" id="rich_snippets_micro_data">
				<h3>GOOGLE MICRODATA</h3>
				<?php require_once 'tabs/micro_data.tpl';?>
			</div>
			<div class="tab-pane" id="rich_snippets_open_graph">
				<h3>FACEBOOK OPEN GRAPH META TAGS</h3>
				<?php require_once 'tabs/open_graph.tpl';?>
			</div>
			
			<div class="tab-pane" id="rich_snippets_twitter_card">
				<h3>TWITTER CARD</h3>
				<?php require_once 'tabs/twitter_card.tpl';?>
			</div>
		</div>
	</div>
</div>