<?php
class ModelJournalProductSlider extends Model {

	public function install() {
		$sql = 'CREATE TABLE IF NOT EXISTS`' . DB_PREFIX . 'journal_product_slider` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `options` text COLLATE utf8_bin NOT NULL,
		  `products` text COLLATE utf8_bin NOT NULL,
		  PRIMARY KEY (`id`)
		)';
		$this->db->query($sql);
	}

	public function uninstall() {
		$sql = 'DROP TABLE IF EXISTS `' . DB_PREFIX . 'journal_product_slider`';
		$this->db->query($sql);
	}

	public function addBanner($options, $products) {
		// foreach ($options as &$opt) {
		// 	$opt = htmlentities($opt);
		// }
		$options = $this->db->escape(serialize($options));
		$products = $this->db->escape(serialize($products));
		$this->db->query("INSERT INTO " . DB_PREFIX . "journal_product_slider
                          SET `options` = '{$options}', `products` = '{$products}'");
	}

	public function getBanners() {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_slider");
		return $filters->rows;
	}

	public function getBanner($id) {
		$filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_slider WHERE id = '" . (int)$id . "'");
		return $filters->row;
	}

	public function deleteBanner($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "journal_product_slider WHERE id = '" . (int)$id . "'");
	}

	public function editbanner($id, $options, $products) {
		// foreach ($options as &$opt) {
		// 	if (is_array($opt)) {
		// 		foreach ($)
		// 	}
		// 	$opt = htmlentities($opt);
		// }
		$options = $this->db->escape(serialize($options));
		$products = $this->db->escape(serialize($products));
		$this->db->query("UPDATE " . DB_PREFIX . "journal_product_slider
                          SET `options` = '{$options}', `products` = '{$products}' WHERE id = '" . (int)$id . "'");
	}

}
?>