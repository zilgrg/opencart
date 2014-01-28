<?php
//==============================================================================
// Smart Search v156.5
//
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo $header; ?>
<style type="text/css">
	.button {
		text-decoration: none;
	}
</style>
<?php if ($version > 149) { ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<?php } ?>
<div class="box">
	<?php if ($version < 150) { ?><div class="left"></div><div class="right"></div><?php } ?>
	<div class="heading">
		<h1 style="padding: 10px 2px 0"><img src="view/image/<?php echo $type; ?>.png" alt="" style="vertical-align: middle" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a class="button" onclick="if (confirm('<?php echo $text_warning; ?>')) go('<?php echo $type; ?>/<?php echo $name; ?>&table=reset')"><span><?php echo $button_reset; ?></span></a>
		</div>
	</div>
	<div class="content">
		<div style="background: #E4EEF7; border: 1px solid #CDE; padding: 5px; margin-bottom: 15px;">
			<table width="100%">
			<tr>
				<td><?php echo $entry_date_start; ?>
					<input type="text" id="date_start" value="<?php echo $filters['date_start']; ?>" size="10" />
				</td>
				<td><?php echo $entry_date_end; ?>
					<input type="text" id="date_end" value="<?php echo $filters['date_end']; ?>" size="10" />
				</td>
				<td><?php echo $entry_combine_same_searches; ?>
					<select id="combine_searches">
						<option value="1" <?php if ($filters['combine_searches']) echo 'selected="selected"'; ?> ><?php echo $text_yes; ?></option>
						<option value="0" <?php if (!$filters['combine_searches']) echo 'selected="selected"'; ?> ><?php echo $text_no; ?></option>
					</select>
				</td>
				<td><a class="button" onclick="go('<?php echo $type; ?>/<?php echo $name; ?>')"><span><?php echo $button_filter; ?></span></a></td>
				<td align="right"><a class="button" onclick="go('<?php echo $type; ?>/<?php echo $name; ?>/exportCSV')"><span><?php echo $button_export_csv; ?></span></a></td>
			</tr>
			</table>
		</div>
		<p><?php if (!$filters['combine_searches']) echo $text_help; ?></p>
		<table class="list">
		<thead>
			<tr>
				<?php if (!$filters['combine_searches']) { ?>
					<td class="left"><?php echo $column_time; ?></td>
					<td class="left"><?php echo $column_search_terms; ?></td>
					<td class="left"><?php echo $column_phase_reached; ?></td>
					<td class="left"><?php echo $column_results; ?></td>
					<td class="left"><?php echo $column_customer; ?></td>
					<td class="left"><?php echo $column_ip_address; ?></td>
				<?php } else { ?>
					<td class="left"><?php echo $column_first_time; ?></td>
					<td class="left"><?php echo $column_last_time; ?></td>
					<td class="left"><?php echo $column_search_terms; ?></td>
					<td class="left"><?php echo $column_average_results; ?></td>
					<td class="left"><?php echo $column_times_searched; ?></td>
				<?php } ?>
				<td class="left"><?php echo $column_action; ?></td>
			</tr>
		</thead>
		<tbody>
			<?php if ($results) { ?>
				<?php foreach ($results as $result) { ?>
					<tr>
						<?php foreach ($result as $key => $value) { ?>
							<?php if ($key == 'smartsearch_id') continue; ?>
							<td class="left"><?php echo $value; ?></td>
						<?php } ?>
						<td class="left"><a class="button" data-key="<?php echo (!$filters['combine_searches']) ? $result['smartsearch_id'] : $result['search']; ?>" onclick="deleteRecord($(this))"><span><?php echo $button_delete; ?></span></a></td>
					</tr>
				<?php } ?>
			<?php } else { ?>
				<tr>
					<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
				</tr>
			<?php } ?>
		</tbody>
		</table>
		<div class="pagination"><?php echo $pagination; ?></div>
		<?php echo $copyright; ?>
	</div>
</div>
<?php if ($version < 150) { ?>
	<script type="text/javascript" src="view/javascript/jquery/ui/ui.datepicker.js"></script>
<?php } else { ?>
	</div>
<?php } ?>
<script type="text/javascript"><!--
	$(document).ready(function() {
		$('#date_start').datepicker({dateFormat: 'yy-mm-dd'});
		$('#date_end').datepicker({dateFormat: 'yy-mm-dd'});
	});
	
	function go(route) {
		url = 'index.php?route=' + route + '&token=<?php echo $token; ?>';
		url += ($('#date_start').val()) ? '&date_start=' + encodeURIComponent($('#date_start').val()) : '';
		url += ($('#date_end').val()) ? '&date_end=' + encodeURIComponent($('#date_end').val()) : '';
		url += ($('#combine_searches').val()) ? '&combine_searches=' + encodeURIComponent($('#combine_searches').val()) : '';
		location = url;
	}
	
	function deleteRecord(element) {
		if (confirm('<?php echo $text_warning; ?>')) {
			$.ajax({
				type: 'POST',
				url: 'index.php?route=<?php echo $type; ?>/<?php echo $name; ?>/deleteRecord&token=<?php echo $token; ?>',
				data: {key: element.attr('data-key'), combined: <?php echo $filters['combine_searches']; ?>},
				success: function(data) {
					if (data) {
						alert(data);
					} else {
						element.parent().parent().remove();
					}
				}
			});
		}
	}
//--></script>
<?php echo $footer; ?>