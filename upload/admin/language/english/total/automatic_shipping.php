<?php
//==============================================================================
// Automatic Shipping v155.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$version = 'v155.2';

// Heading
$_['heading_title']				= 'Automatic Shipping';

// Buttons
$_['button_save_exit']			= 'Save & Exit';
$_['button_save_keep_editing']	= 'Save & Keep Editing';

// Entries
$_['entry_status']				= 'Status:';
$_['entry_sort_order']			= 'Sort Order:<br /><span class="help">This must be higher than the Sort Order for the "Shipping" Order Total.</span>';
$_['entry_shipping_methods']	= 'Shipping Methods<br /><span class="help">Select the shipping methods that are eligible to be automatically applied.<br /><br />Disabled shipping methods are displayed in italics.</span>';

// Text
$_['text_help']					= '
	If this extension is enabled and a shipping method is not selected by the customer, the lowest applicable shipping cost will automatically be applied to their order.<br />
	Once the customer selects a shipping method, the selected shipping cost will override the automatic shipping cost.<br />
	The location compared against will be the customer\'s checkout address if entered, their account address if not, and the store\'s default address if not logged in.<br />
	<br />
	If you do not need to give the customer a choice of shipping methods, and want to skip the shipping steps altogether,<br />
	then set the "Requires Shipping" setting to "No" for all products, or use the free vQmod downloadable from <a target="_blank" href="http://forum.opencart.com/viewtopic.php?f=131&t=59706">this forum topic</a>.<br />
	You\'ll also probably want to disable the "Shipping" Order Total, so the shipping estimator does not appear.<br />
	<br />
	Note: If you skip the shipping steps, you will not be able to collect different shipping and payment addresses.
';

// Copyright
$_['copyright']					= '<div style="text-align: center" class="help">' . $_['heading_title'] . ' ' . $version . ' &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';

// Standard Text
$_['standard_module']			= 'Modules';
$_['standard_shipping']			= 'Shipping';
$_['standard_payment']			= 'Payments';
$_['standard_total']			= 'Order Totals';
$_['standard_feed']				= 'Product Feeds';
$_['standard_success']			= 'Success: You have modified ' . $_['heading_title'] . '!';
$_['standard_error']			= 'Warning: You do not have permission to modify ' . $_['heading_title'] . '!';
?>