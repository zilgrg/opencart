<?php
class ModelJournalProductSlider extends Model {

	public function getBanner($id) {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_slider WHERE id = '" . (int)$id . "'");
		return $filters->row;
	}

}
?>