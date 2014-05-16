<script type="text/javascript">
	var PSBdat = {
		data 			: <?php echo json_encode($data); ?>,
		
		patterns		: <?php echo json_encode($patterns); ?>,
		CPBI_parameters	: <?php echo json_encode($CPBI_parameters); ?>,
		MD_PatternAddVal: <?php echo json_encode($MD_PatternAddVal); ?>,
		
		url				: <?php echo htmlspecialchars_decode(json_encode($urls)); ?>,
		
		token 			: '<?php echo $token; ?>',
		VER_status 		: <?php echo $VER_status; ?>,
		seo_power		: <?php echo $seo_power; ?>,
		update_text		: '<?php echo $update_text; ?>',
		HTTP_SERVER		: '<?php echo $HTTP_SERVER; ?>'
	}
	/* set additional value before insert => MD_PatternAddVal */
</script>

<?php if ($success) { ?>
	<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box-block header-seo-box">
	<div class="seo-power-box" data-position="right" data-intro="This is the index of SEO level for your site, here you can see percent of use SEO optimization." data-step="1">
		<input id="seo-gauge" data-linecap="round" class="knob" data-thickness=".2" data-fgColor="#FE9D00" data-bgColor="#EDEBEC" data-angleOffset=-125 data-angleArc=250 readOnly="true" class="knob" data-width="154" value="70%">
		<span>SEO POWER</span>
	</div>
	<div class="header-seo">
		<div class="auto-create-box">
			
		</div>
	</div>
</div>

<!--  -->

<div class="box-block" id="global_box">
	<div class="tabbable"> 
		<ul id="main_menu" class="main-menu nav nav-tabs" data-intro-action="$('a[href=#seo_generator]').click();" data-intro="This is main menu. Click here to navigate on another SEO tool." data-step="2">
			<li class="active">
				<a href="#seo_generator" data-toggle="tab">
					<i class="icon-fire"></i> Generators
				</a>
			</li>
			<li>
				<a href="#seo_tools" data-toggle="tab">
					<i class="icon-magnet"></i> SEO tools
				</a>
			</li>
			<li>
				<a href="#seo_edit" data-toggle="tab">
					<i class="icon-edit"></i> SEO Editor
				</a>
			</li>
			<li>
				<a href="#seo_social" data-toggle="tab">
					<i class="icon-share"></i> Social & share
				</a>
			</li>
			<li>
				<a href="#rich_snipets" data-toggle="tab">
					<i class="icon-th"></i> Rich Snippets
				</a>
			</li>
			<li>
				<a href="#imp_exp" data-toggle="tab">
					<i class="icon-retweet"></i> Imp/Exp
				</a>
			</li>
			<li>
				<li class="dropdown" style="position: absolute;top: -162px;left: 125px;">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-bell"></i> Get Support <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#seo_support" data-toggle="tab">Get Support and Updates</a></li>
						<li class="divider"></li>
						<li><a href="#question" data-toggle="tab">Frequently Asked Questions</a></li>
						<li class="divider"></li>
						<li><a href="#improve_mod" data-toggle="tab">Improving module</a></li>
					</ul>
				</li>
			</li>
		</ul>
		<div class="main-content tab-content">
			<div class="tab-pane active" id="seo_generator">
				<div class="tab_title_info">
					<i class="icon-fire"></i>
					Generate and automatically adding SEO URLs, meta keywords, meta descriptions, tags, titles and descriptions for every product, category, brand and info page, etc. This is very powerful tool for time saver for you and SEO promotion for search engines. It works on the basis of template system and of simple parameters for generate SEO texts for pages.<span class="colorFC580B">
					Before use generator, necessarily make the backup of Database and the copy of image folder.</span>  
				</div>
				<?php require_once 'seo_generator/seo_generator_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_tools">
				<div class="tab_title_info">
					<i class="icon-magnet"></i>
					Here you can find tools, which will give your site additional SEO promotion in search engines. Canonical links is the new option lets site owners suggest the version of a page that Google should treat as canonical. Use Direct links, if you have a few languages for switching language.
				</div>
				<?php require_once 'seo_tools/seo_tools_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_edit">
				<div class="tab_title_info">
					<i class="icon-edit"></i>
					Here, in one place, you can easy viewing and edit all your SEO data. Below you can see table, which represent all SEO data for products, categories, brand, info and home pages, plus the Seo setting for common Opencart pages, as account, cart, login and other. This list gives you possibility to improve your SEO level and saves your time.</br><span class="colorFC580B">For edit any texts, just click on it and do it. To change the language, just click on appropriate link and your list will be refreshed.</span>
				</div>
				<?php require_once 'seo_edit/seo_edit.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_social">
				<div class="tab_title_info">
					<i class="icon-th"></i>
					QR-code gives your customers easy way to enter in your site from mobile device.
				</div>
				<?php require_once 'seo_social/seo_social_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="rich_snipets">
				<div class="tab_title_info">
					<i class="icon-th"></i>
					Make your site more friendly for Google, Twitter and Facebook using this tools for insert on your pages  the few lines of special texts (Rich snippets). Here you can find the few tools such as Google Microdata, Facebook's Open Graph META Tags and Twitter Card, which will improve your pages.
				</div>
				<?php require_once 'rich_snipets/rich_snipets_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="imp_exp">
				<div class="tab_title_info">
					<i class="icon-retweet"></i>
					If you want to move your site to another host, you can use export/import features for passing settings from this module to another host. All templates of  keywords, tags, titles, descriptions, meta descriptions, settings of rich snippets and SEO tools will be transfered. To get the code for export, just click on "Get Settings for export" and then copy it and paste in field "Import Settings for Paladin SEO Manager" in new site and press "Import".
				</div>
				<?php require_once 'imp_exp/imp_exp_index.tpl';?>
			</div>

			<div class="tab-pane" id="seo_support">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					The our support page is your starting point for help with Paladin SEO Manager software, just write us and we solve your problem within 24 hours. We work for you and  offer you the best support, just try it.
				</div>
				<?php require_once 'support/support_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="question">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					The our support page is your starting point for help with Paladin SEO Manager software, just write us and we solve your problem within 24 hours. We work for you and  offer you the best support, just try it.
				</div>
				<?php require_once 'support/support_question.tpl';?>
			</div>
			
			<div class="tab-pane" id="improve_mod">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					The our support page is your starting point for help with Paladin SEO Manager software, just write us and we solve your problem within 24 hours. We work for you and  offer you the best support, just try it.
				</div>
				<?php require_once 'support/support_improve.tpl';?>
			</div>
		</div>
			
	</div>
</div>