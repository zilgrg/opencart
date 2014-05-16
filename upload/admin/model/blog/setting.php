<?php
class ModelBlogSetting extends Model {
   public function updateSetting($data) {
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting");

      foreach ($data as $key => $value) {
         $this->db->query("INSERT INTO " . DB_PREFIX . "blog_setting SET `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
      }
   }
   
   public function updateSettingKey($key, $value) {
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = '" . $this->db->escape($key) . "'");

      $this->db->query("INSERT INTO " . DB_PREFIX . "blog_setting SET `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
   }
   
   public function getSettings() {
      $data = array();
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_setting");
      
      foreach ($query->rows as $result) {
         $data[$result['key']] = $result['value'];
      }
   
      return $data;
   }
   
   public function checkDbTable($table) {
      // return TRUE if exist, FALSE if table is not exist
      $result = $this->db->query("SHOW TABLES LIKE '". DB_PREFIX . $table . "'");
      return ($result->num_rows != '1') ? FALSE : TRUE;
   }
   
   public function checkDbColumn($table, $column) {
      // return TRUE if exist, FALSE if column is not exist at table
		$result = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . $table ."` LIKE '" . $column . "'");
      return ($result->num_rows) ? TRUE : FALSE;
	}
}
?>