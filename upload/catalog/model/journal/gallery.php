<?php
class ModelJournalGallery extends Model {

	public function getGallery($id) {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_gallery WHERE id = '" . (int)$id . "'");
		return $filters->row;
	}

}
?>