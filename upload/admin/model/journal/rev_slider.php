<?php
class ModelJournalRevSlider extends Model {

	public function install() {
		$sql = 'CREATE TABLE IF NOT EXISTS`' . DB_PREFIX . 'journal_rev_slider` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `data` text COLLATE utf8_bin NOT NULL,
		  PRIMARY KEY (`id`)
		)';
		$this->db->query($sql);
	}

	public function uninstall() {
		$sql = 'DROP TABLE IF EXISTS `' . DB_PREFIX . 'journal_rev_slider`';
		$this->db->query($sql);
	}

	public function addSlider($data) {
		$data = $this->db->escape(serialize($data));
		$this->db->query("INSERT INTO " . DB_PREFIX . "journal_rev_slider SET `data` = '{$data}'");
		return $this->db->getLastId();
	}

	public function getSliders() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_rev_slider");
		$res = array();
		foreach ($query->rows as $row) {
			$res[] = array(
				'id'	=> $row['id'],
				'data'	=> unserialize($row['data'])
			);
		}
		return $res;
	}

	public function getSlider($id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_rev_slider WHERE id = '" . (int)$id . "'");
		if ($query->num_rows) {
			return array(
				'id'	=> $query->row['id'],
				'data'	=> unserialize($query->row['data'])
			);
		}
		return null;
	}

	public function deleteSlider($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "journal_rev_slider WHERE id = '" . (int)$id . "'");
	}

	public function editSlider($id, $data) {
		$data = $this->db->escape(serialize($data));
		$this->db->query("UPDATE " . DB_PREFIX . "journal_rev_slider SET `data` = '{$data}' WHERE id = '" . (int)$id . "'");
	}

}
?>