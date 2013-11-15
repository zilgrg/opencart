<?php
class ModelJournalRevSlider extends Model {

	public function getSlider($id) {
		$result = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_rev_slider WHERE id = '" . (int)$id . "'");
		return unserialize($result->row['data']);
	}

}
?>