<?php
class ModelJournalGallery extends Model {

	public function install() {
		$sql = 'CREATE TABLE IF NOT EXISTS`' . DB_PREFIX . 'journal_gallery` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `options` text COLLATE utf8_bin NOT NULL,
		  `images` text COLLATE utf8_bin NOT NULL,
		  PRIMARY KEY (`id`)
		)';
		$this->db->query($sql);
	}

	public function uninstall() {
		$sql = 'DROP TABLE IF EXISTS `' . DB_PREFIX . 'journal_gallery`';
		$this->db->query($sql);
	}

	public function addGallery($options, $images) {
		foreach ($options as &$opt) {
			$opt = htmlentities($opt);
		}
		$options = $this->db->escape(serialize($options));
		$images = $this->db->escape(serialize($images));
		$this->db->query("INSERT INTO " . DB_PREFIX . "journal_gallery
                          SET `options` = '{$options}', `images` = '{$images}'");
	}

	public function getGalleries() {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_gallery");
		return $filters->rows;
	}

	public function getGallery($id) {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_gallery WHERE id = '" . (int)$id . "'");
		return $filters->row;	
	}

	public function deleteGallery($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "journal_gallery WHERE id = '" . (int)$id . "'");
	}

	public function editGallery($id, $options, $images) {
		foreach ($options as &$opt) {
			$opt = htmlentities($opt);
		}
		$options = $this->db->escape(serialize($options));
		$images = $this->db->escape(serialize($images));
		$this->db->query("UPDATE " . DB_PREFIX . "journal_gallery
                          SET `options` = '{$options}', `images` = '{$images}' WHERE id = '" . (int)$id . "'");
	}

}
?>