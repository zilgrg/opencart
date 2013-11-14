<?php
//==============================================================================
// Smart Search v156.4
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$version = 'v156.4';

// Heading
$_['heading_title']					= 'Smart Search';

// Saving
$_['button_save_exit']				= 'Save & Exit';
$_['button_save_keep_editing']		= 'Save & Keep Editing';
$_['text_saving']					= 'Saving...';
$_['text_saved']					= 'Saved!';
	
// General Settings
$_['entry_smartsearch_explanation']	= 'Smart Search always returns the most relevant results, by performing a search of the selected product fields in four phases:<br />&bull; Phase 1: Finding products that contain the keywords as an exact phrase. If nothing is found, it will move on to Phase 2.<br />&bull; Phase 2: Finding products that contain ALL of the keywords, correctly spelled. If nothing is found, it will move on to Phase 3.<br />&bull; Phase 3: Finding products that contain ALL of the keywords, within the misspelling tolerance level. If nothing is found, it will move on to Phase 4.<br />&bull; Phase 4: Finding products that contain ANY of the keywords, within the misspelling tolerance level.';
$_['entry_status']					= 'Status:';
$_['entry_testing_mode']			= 'Testing Mode:<span class="help">Enabling this will display on the front-end how long each search query takes, for logged-in admin users only. Setting to "Assume No Individual Caching" will display times for both the individual search cache, and how long a first-time search would take.</span>';
$_['text_enabled_run_as_normal']	= 'Enabled, Run as Normal';
$_['text_enabled_assume_no']		= 'Enabled, Assume No Individual Caching';
$_['button_view_report']			= 'View Smart Search History';

// Product Fields Searched
$_['entry_fields_searched']			= 'Fields Searched and Relevance Ranking';
$_['help_fields_searched']			= '<ul><li>For optimal speed, select as few fields as possible. In particular, selecting "Description (Phases 3 & 4)" can slow down search results if you have a lot of products.</li><li>For any selected fields, enter the relevance ranking in the box next to the field name. This will determine the order in which results are displayed by default for Phases 1 and 2. Each different ranking will result in its own database query, so fewer rankings will be faster.</li><li>For example, if you enter a relevance of 1 for "Name" and a relevance of 2 for "Model", then products whose name matches the search term(s) will appear before products whose model matches the search term(s).</li></ul>';
$_['text_name']						= 'Name';
$_['text_description']				= 'Description (Phases 1 & 2)';
$_['text_description_misspelled']	= 'Description (Phases 3 & 4)';
$_['text_meta_description']			= 'Meta Tag Description';
$_['text_meta_keyword']				= 'Meta Tag Keywords';
$_['text_tag']						= 'Tags';
$_['text_model']					= 'Model';
$_['text_sku']						= 'SKU';
$_['text_upc']						= 'UPC';
$_['text_ean']						= 'EAN';
$_['text_jan']						= 'JAN';
$_['text_isbn']						= 'ISBN';
$_['text_mpn']						= 'MPN';
$_['text_location']					= 'Location';
$_['text_manufacturer']				= 'Manufacturer Name';
$_['text_attribute_group']			= 'Attribute Group';
$_['text_attribute_name']			= 'Attribute Name';
$_['text_attribute_value']			= 'Attribute Value';
$_['text_option_name']				= 'Option Name';
$_['text_option_value']				= 'Option Value';

// Search Options
$_['entry_search_options']			= 'Search Options';
$_['entry_default_sorting']			= 'Default Sorting:<span class="help">Select the default way products are sorted in search results. If using a numeric sorting like "Price", you probably want to give all fields the same relevance ranking, since it may not be properly sorted otherwise.</span>';
$_['entry_autorefresh_individual']	= 'Auto-Refresh Individual Search Cache:<span class="help">Each individual search will be cached, making subsequent searches for the same terms quicker. Select how often to generate new individual cache files, based on how often you update your products.</span>';
$_['text_hourly']					= 'Hourly';
$_['text_daily']					= 'Daily';
$_['text_weekly']					= 'Weekly';
$_['text_monthly']					= 'Monthly';
$_['text_yearly']					= 'Yearly';
$_['text_dont_use_cache']			= 'Don\'t Use Cache';
$_['button_clear_cache']			= 'Clear Cache';
$_['text_clear_cache_individual']	= 'This will clear all individual searches that are currently cached, and pre-cache the top searches based on the Smart Search history.\n\nEnter the number of searches to pre-cache (a higher number will take longer):';
$_['text_cache_cleared']			= 'Cache cleared!';
$_['text_searches_cached']			= ' searches have been cached';
$_['entry_account_for_plurals']		= 'Account For Plurals:<span class="help">Select whether searches with simple plurals will also give results for the singular. For example, searches for "macs" would also give results for "mac".</span>';
$_['text_date_added']				= 'Date Added';
$_['text_date_available']			= 'Date Available';
$_['text_date_modified']			= 'Date Modified';
$_['text_model']					= 'Model';
$_['text_name']						= 'Name';
$_['text_price']					= 'Price';
$_['text_quantity']					= 'Quantity in Stock';
$_['text_rating']					= 'Rating';
$_['text_sort_order']				= 'Sort Order';
$_['text_times_purchased']			= 'Times Purchased';
$_['text_times_viewed']				= 'Times Viewed';
$_['text_ascending']				= 'Ascending';
$_['text_descending']				= 'Descending';
$_['entry_include_partial_word']	= 'Include Partial Word Matches:<span class="help">Select whether searches include results where the search terms only partially match a word. For example, searches for "mac" would match products containing "macbook".</span>';
$_['entry_minimum_number']			= 'Minimum Number of Results to Display:<span class="help">Enter the minimum number of results to display for each search. If a Phase does not meet the minimum, then Smart Search will continue on to the next Phase, appending products found in sub-sequent Phases to the end of the results.</span>';
$_['entry_search_in_subcategories']	= 'Search in Sub-Categories:<span class="help">Select whether searches limited to a category will also search within its sub-categories.</span>';
$_['entry_index_database_tables']	= 'Index Database Tables';
$_['help_index_database_tables']	= '<span class="help">This can help speed up search results, as described in <a target="_blank" href="http://forum.opencart.com/viewtopic.php?f=20&t=39759">this forum topic</a>. Clicking this will automatically run all of these INDEX database queries for you.</span>';
$_['text_indexed_success']			= 'Your database tables are indexed! Running this in the future will have no affect on your database.';

// Misspelling Search Settings
$_['entry_misspelling_settings']	= 'Misspelling Search Settings';
$_['entry_misspelling_tolerance']	= 'Misspelling Tolerance:<span class="help">Set the tolerance level when judging misspelled words. A setting of 0% will match anything, while a setting of 100% will match only exact spellings.</span>';
$_['entry_autorefresh_misspelling']	= 'Auto-Refresh Misspelling Cache:<span class="help">Select how often to generate new misspelling cache files. This can take a few extra seconds during the search where they are generated, so if you have a lot of products you may want to do this infrequently or disable caching.</span>';
$_['text_clear_cache_misspelling']	= 'This operation cannot be undone. Continue?';
$_['entry_min_word_length']			= 'Min. Word Length for Cache:<span class="help">The minimum number of letters a keyword needs for it to be included in the cache. Set a higher minimum word length if misspelled searches are matching products that include common words, or are taking too long on a large database.</span>';

// AJAX Search Settings
$_['entry_ajax_search_settings']	= 'AJAX Search Settings';
$_['entry_ajax_search']				= 'AJAX Search:<span class="help">If enabled, products will automatically appear when entering keywords in the header search field.</span>';
$_['entry_selector']				= 'Selector:<span class="help">Enter a CSS selector for the search field. You only need to change this if your custom template changes the search field, since the default (<span style="font-family: monospace; ; font-style: normal">#search input</span>) will work for most themes.</span>';
$_['entry_colors']					= 'Colors:<span class="help">Set the AJAX dropdown colors for the Background, Borders, Font, Highlighting, Price, and Special Price';
$_['text_background']				= 'Background';
$_['text_borders']					= 'Borders';
$_['text_font']						= 'Font';
$_['text_highlight']				= 'Highlight';
$_['text_special']					= 'Special';

$_['entry_display']					= 'Display:<span class="help">Set how the AJAX dropdown displays:<br />&bull; Delay: The delay before appearing, in ms<br />&bull; Limit: The maximum number of products to show<br />&bull; Price: Whether to show the product price<br />&bull; Model: Whether to show the product model<br />&bull; Description: The number of characters for product descriptions (leave blank to show no description)</span>';
$_['text_delay']					= 'Delay (ms)';
$_['text_limit']					= 'Limit (#)';
$_['text_price']					= 'Price';
$_['text_description_ajax']			= 'Description';
$_['text_show']						= 'Show';
$_['text_hide']						= 'Hide';

$_['entry_positioning']				= 'Positioning:<span class="help">Optionally set the top, left, and/or right positioning of the dropdown in pixels. If the dropdown appears over the search bar in your custom theme, add a "Top" position to move it down.</span>';
$_['text_top']						= 'Top';
$_['text_left']						= 'Left';
$_['text_right']					= 'Right';

$_['entry_sizes']					= 'Sizes:<span class="help">Set the AJAX dropdown width, image width, image height, product font size, and description font size (all in pixels). Leave image sizes blank to show no image.</span>';
$_['text_dropdown_width']			= 'Dropdown<br />Width';
$_['text_image_width']				= 'Image<br />Width';
$_['text_image_height']				= 'Image<br />Height';
$_['text_product_font_size']		= 'Product<br />Font Size';
$_['text_description_font_size']	= 'Description<br />Font Size';

$_['entry_text']					= 'Text:<span class="help"> Set the text for the "View All Results" link that appears at the bottom of the AJAX dropdown, and the text displayed when there are no results for a search. HTML is supported.</span>';
$_['text_view_all_results']			= 'View All Results';
$_['text_no_results']				= 'No Results';
$_['entry_additional_css']			= 'Additional CSS:<span class="help">Add any additional CSS styling here. If your CSS does not seem to be applying, try adding <span style="font-family: monospace; font-style: normal">!important</span> at the end of the declarations, to override any other CSS styling.</span>';

// Pre-Search Replacements
$_['entry_pre_search_replacements']	= 'Pre-Search Replacements:';
$_['help_pre_search_replacements']	= 'Optionally enter replacements for the keywords before they are searched. For example, you could replace hyphens with spaces, or commonly misspelled product names with correct ones.';
$_['text_replace']					= 'Replace';
$_['text_with']						= 'With';

// Standard Text
$_['copyright']						= '<div style="text-align: center; font-style: normal" class="help">' . $_['heading_title'] . ' ' . $version . ' &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';
$_['standard_module']				= 'Modules';
$_['standard_shipping']				= 'Shipping';
$_['standard_payment']				= 'Payments';
$_['standard_total']				= 'Order Totals';
$_['standard_feed']					= 'Product Feeds';
$_['standard_error']				= 'Warning: You do not have permission to modify ' . $_['heading_title'] . '!';
?>