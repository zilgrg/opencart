<?php
//==============================================================================
// Smart Search v156.4
//
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ModelReportSmartsearch extends Model {
	private $type = 'report';
	private $name = 'smartsearch';
	
	public function createTableIfNotExists() {
		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . $this->name . "` (
			`" . $this->name . "_id` int(11) NOT NULL AUTO_INCREMENT,
			`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
			`search` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
			`phase` int(1) NOT NULL,
			`results` int(11) NOT NULL,
			`customer_id` int(11) NOT NULL,
			`ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '0',
			PRIMARY KEY (`" . $this->name . "_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin
		");
	}
	
	public function resetTable() {
		$this->db->query("TRUNCATE TABLE `" . DB_PREFIX . $this->name . "`");
	}
	
	public function getColumns($data = array()) {
		if (empty($data['combine_searches'])) {
			$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . $this->name);
			array_shift($query->rows);
			return $query->rows;
		} else {
			return array(
				array('Field' => 'first_time'),
				array('Field' => 'last_time'),
				array('Field' => 'search'),
				array('Field' => 'average_results'),
				array('Field' => 'times_searched')
			);
		}
	}
	
	public function getResults($data = array(), $return_total = false) {
		if (empty($data['combine_searches'])) {
			$sql = "SELECT * FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
		} else {
			$sql = "SELECT MIN(date_added) AS first_time, MAX(date_added) AS last_time, LCASE(search) AS search, ROUND(AVG(results),1) AS average_results, COUNT(*) AS times_searched FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
		}
		$sql .= (!empty($data['date_start'])) ? " AND DATE(date_added) >= '" . $this->db->escape($data['date_start']) . "'" : "";
		$sql .= (!empty($data['date_end'])) ? " AND DATE(date_added) <= '" . $this->db->escape($data['date_end']) . "'" : "";
		$sql .= (!empty($data['combine_searches'])) ? " GROUP BY search ORDER BY times_searched DESC" : " ORDER BY date_added DESC";
		$sql .= (!$return_total) ? " LIMIT " . (int)(($data['page'] - 1) * $this->config->get('config_admin_limit')) . "," . (int)$this->config->get('config_admin_limit') : "";
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
}
?>