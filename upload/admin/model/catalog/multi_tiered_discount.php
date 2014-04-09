<?php 

class ModelCatalogMultiTieredDiscount extends Model {

	public function getDiscounts() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_tiered_discount");
		return $query->rows;
	}

	public function getDiscountCodes() {
		$query = $this->db->query("SELECT DISTINCT discount_code FROM " . DB_PREFIX. "multi_tiered_discount");
		return $query->rows;
	}

	public function saveDiscount($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "multi_tiered_discount SET discount_code = '" . $this->db->escape($data['discount_code']) . "', discount_amount = '" . (int)$data['discount_amount'] . "', discount_type = '" . $this->db->escape($data['discount_type']) . "', override_special = '" . (isset($data['override_special']) ? (int)$data['override_special'] : 0) . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', status = '" . (int)$data['status'] . "'");
		return;
	}

	public function deleteDiscount($multi_tier_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "multi_tiered_discount WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		return;
	}

	public function updateOverrideSpecial($multi_tier_id, $override_special) {
		$this->db->query("UPDATE " . DB_PREFIX . "multi_tiered_discount SET override_special = '" . (int)$override_special . "' WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		return;
	}

	public function updateDiscountAmount($multi_tier_id, $amount) {
		$this->db->query("UPDATE " . DB_PREFIX . "multi_tiered_discount SET discount_amount = '" . (float)$amount . "' WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		$query = $this->db->query("SELECT discount_type FROM " . DB_PREFIX . "multi_tiered_discount WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		return $query->row['discount_type'];
	}

	public function updateDiscountType($multi_tier_id, $type) {
		$this->db->query("UPDATE " . DB_PREFIX . "multi_tiered_discount SET discount_type = '" . $this->db->escape($type) . "' WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		$query = $this->db->query("SELECT discount_amount FROM " . DB_PREFIX . "multi_tiered_discount WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		return $query->row['discount_amount'];
	}

	public function updateStatus($multi_tier_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "multi_tiered_discount SET status = '" . (int)$status . "' WHERE multi_tier_id = '" . (int)$multi_tier_id . "'");
		return;
	}

	public function verify($data) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_tiered_discount WHERE discount_code = '" . $this->db->escape($data['discount_code']) . "' AND customer_group_id = '" . (int)$data['customer_group_id'] . "'");
		if ($query->num_rows) {
			return true;
		} else {
			return false;
		}
	}

	public function setupDb() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "multi_tiered_discount` (
			multi_tier_id int(11) NOT NULL auto_increment,
			discount_code varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
			discount_amount decimal(15,2) NOT NULL DEFAULT 0.00,
			discount_type varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
			override_special tinyint(1) NOT NULL DEFAULT 0,
			customer_group_id int(11) NOT NULL DEFAULT 0,
			status tinyint(1) NOT NULL DEFAULT 0,
			PRIMARY KEY (multi_tier_id));");
		$results = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product` LIKE 'discount_code'");
		if ($results->num_rows < 1) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "product` ADD COLUMN discount_code varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT ''");
		}
		$results = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "multi_tiered_discount` LIKE 'discount_type'");
		if ($results->num_rows < 1) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "multi_tiered_discount` ADD COLUMN discount_type varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT ''");
		}
		return;
	}

}

?>