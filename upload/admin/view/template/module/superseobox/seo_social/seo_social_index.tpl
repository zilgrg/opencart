<div class="box-block work-seo-box">
	<h2>SEO Social & share function</h2>
	<div class="tabbable tabs-left">
		<ul id="seo_tools_menu" class="seo-item-menu nav nav-tabs">
			<span>tools</span>
			<li class="active">
				<a href="#seo_social_buttons" data-toggle="tab">
					<i class="icon-move"></i> 
					Social Buttons
				</a>
			</li>
			<li>
				<a href="#seo_social_qr_code" data-toggle="tab">
					<i class="icon-qrcode"></i> 
					QR-code
				</a>
			</li>	
			<li>
				<a href="#seo_social_set_panel_bar" data-toggle="tab">
					<i class="icon-wrench"></i> 
					Setting Panel Bar
				</a>
			</li>
		</ul>
		
		<div class="tab-content">
			<div class="tab-pane active" id="seo_social_buttons">
				<h3>SOCIAL BUTTONS</h3>
				<?php require_once 'tabs/social_buttons.tpl';?>
			</div>
			<div class="tab-pane" id="seo_social_qr_code">
				<h3>QR-CODE</h3>
				<?php require_once 'tabs/qr_code.tpl';?>
			</div>
			<div class="tab-pane" id="seo_social_set_panel_bar">
				<h3>SETTING PANEL BAR</h3>
				<?php require_once 'tabs/set_panel_bar.tpl';?>
			</div>
		</div>
	</div>
</div>