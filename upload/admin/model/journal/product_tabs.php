<?php
class ModelJournalProductTabs extends Model {

	public function install() {
		$sql = 'CREATE TABLE IF NOT EXISTS`' . DB_PREFIX . 'journal_product_tabs` (
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`product_id` int(11) NOT NULL,
			`data` text COLLATE utf8_bin NOT NULL,
			`title` text COLLATE utf8_bin NOT NULL,
			`content` text COLLATE utf8_bin NOT NULL,
			PRIMARY KEY (`id`),
			INDEX (`product_id`)
		)';
		$this->db->query($sql);
	}

	public function uninstall() {
		$sql = 'DROP TABLE IF EXISTS `' . DB_PREFIX . 'journal_product_tabs`';
		$this->db->query($sql);
	}

	public function getAll() {
		// SELECT  FROM `dev_journal_product_tabs` LEFT JOIN `dev_product_description` ON dev_journal_product_tabs.product_id = dev_product_description.product_id
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_tabs LEFT JOIN " . DB_PREFIX . "product_description ON " . DB_PREFIX . "journal_product_tabs.product_id = " . DB_PREFIX . "product_description.product_id WHERE " . DB_PREFIX . "product_description.language_id='" . (int)$this->config->get('config_language_id') . "' OR " . DB_PREFIX . "product_description.language_id IS NULL");
		$res = array();
		foreach ($query->rows as $row) {
			$res[] = array(
				'product_id'	=> $row['product_id'] ? $row['product_id'] : 0,
				'data'			=> unserialize($row['data']),
				'name'			=> $row['product_id'] ? $row['name'] : 'Global Tab'
				// 'title'			=> unserialize($row['title']),
				// 'content'		=> unserialize($row['content'])
			);
		}
		return $res;
	}

	public function get($product_id) {
		// $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_tabs WHERE product_id = '" . (int)$product_id . "'");
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_tabs LEFT JOIN " . DB_PREFIX . "product_description ON " . DB_PREFIX . "journal_product_tabs.product_id = " . DB_PREFIX . "product_description.product_id WHERE (" . DB_PREFIX . "product_description.language_id='" . (int)$this->config->get('config_language_id') . "' OR " . DB_PREFIX . "product_description.language_id IS NULL) AND (" . DB_PREFIX . "journal_product_tabs.product_id = '" . $product_id . "')");
		if ($query->num_rows) {
			return array(
				'product_id'	=> $query->row['product_id'],
				'data'			=> unserialize($query->row['data']),
				'name'			=> $query->row['name']
				// 'title'			=> unserialize($query->row['title']),
				// 'content'		=> unserialize($query->row['content'])
			);
		}
		return array();
	}

	public function save($product_id, $tabs) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "journal_product_tabs WHERE product_id = '" . (int)$product_id . "'");
		$data = $this->db->escape(serialize($tabs));
		$this->db->query("INSERT INTO " . DB_PREFIX . "journal_product_tabs SET `product_id` = '" . (int)$product_id . "', `data` = '{$data}'");
	}

	public function delete($product_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "journal_product_tabs WHERE product_id = '" . (int)$product_id . "'");
	}

	public function getProducts($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

		if (!empty($data['filter_category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
		}

		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (!empty($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}

		$sql .= " AND p.product_id NOT IN (SELECT product_id FROM " . DB_PREFIX . "journal_product_tabs)";

		$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.price',
			'p.quantity',
			'p.status',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY pd.name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

}
?>