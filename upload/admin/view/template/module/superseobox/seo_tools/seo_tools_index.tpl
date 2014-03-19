<div class="box-block work-seo-box">
	<h2>SEO Tools</h2>
	<div class="tabbable tabs-left">
		<ul id="seo_tools_menu" class="seo-item-menu nav nav-tabs" data-position="right" data-intro="Now, we are in tab 'SEO tools' and this is it's menu. Here we can add many useful SEO features, such as Canonical Links, Social Buttons, QR-code and other." data-intro-action="$('a[href=#question]').click();" data-step="10" >
			<span>tools</span>
			<li class="active">
				<a href="#seo_tool_store" data-toggle="tab">
					<i class="icon-flag"></i> 
					SEO Store
				</a>
			</li>
			<li>
				<a href="#seo_tool_site_map" data-toggle="tab">
					<i class="icon-globe"></i> 
					Sitemap
				</a>
			</li>
			<li>
				<a href="#seo_tool_seo_pagination" data-toggle="tab">
					<i class="icon-random"></i> 
					SEO Pagination
				</a>
			</li>
			<li>
				<a href="#seo_tool_canonical" data-toggle="tab">
					<i class="icon-road"></i> 
					Canonical Link
				</a>
			</li>
			<li>
				<a href="#seo_tool_lan_dir_link" data-toggle="tab">
					<i class="icon-upload"></i> 
					Direct Links
				</a>
			</li>
			<li>
				<a href="#seo_tool_traling_slash" data-toggle="tab">
					<i class="icon-resize-horizontal"></i> 
					Trailing Slash
				</a>
			</li>
			<li>
				<a href="#seo_tool_social_buttons" data-toggle="tab">
					<i class="icon-move"></i> 
					Social Buttons
				</a>
			</li>
			<li>
				<a href="#seo_tool_qr_code" data-toggle="tab">
					<i class="icon-qrcode"></i> 
					QR-code
				</a>
			</li>	
			<li>
				<a href="#seo_tool_ver_webm_tool" data-toggle="tab">
					<i class="icon-briefcase"></i> 
					Webmaster Tools
				</a>
			</li>
			<li>
				<a href="#seo_tool_set_panel_bar" data-toggle="tab">
					<i class="icon-wrench"></i> 
					Setting Panel Bar
				</a>
			</li>
		</ul>
		
		<div class="tab-content">
			<div class="tab-pane active" id="seo_tool_store">
				<h3>SEO STORE</h3>
				<?php require_once 'tabs/seo_store.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_site_map">
				<h3>SITEMAP</h3>
				<?php require_once 'tabs/site_map.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_seo_pagination">
				<h3>SEO PAGINATION</h3>
				<?php require_once 'tabs/seo_pagination.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_canonical">
				<h3>CANONICAL LINK</h3>
				<?php require_once 'tabs/canonical.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_lan_dir_link">
				<h3>DIRECT LINKS</h3>
				<?php require_once 'tabs/lan_dir_link.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_traling_slash">
				<h3>Trailing slash of URL</h3>
				<?php require_once 'tabs/trailing_slash.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_social_buttons">
				<h3>SOCIAL BUTTONS</h3>
				<?php require_once 'tabs/social_buttons.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_qr_code">
				<h3>QR-CODE</h3>
				<?php require_once 'tabs/qr_code.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_ver_webm_tool">
				<h3>WEBMASTER TOOLS</h3>
				<?php require_once 'tabs/ver_webm_tool.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_set_panel_bar">
				<h3>SETTING PANEL BAR</h3>
				<?php require_once 'tabs/set_panel_bar.tpl';?>
			</div>
		</div>
	</div>
</div>