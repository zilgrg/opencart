<?php
class ModelJournalCp extends Model {

	private static $VERSION = '1.8.2';

	// PRIMARY METHODS
	public function getThemes() {
		$sql = "SELECT * FROM " . DB_PREFIX . "journal_cp_themes";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getSettings() {
		$sql = "SELECT name, category, subcategory, input, options, is_serialized, sort_order FROM " . DB_PREFIX . "journal_cp_settings ORDER BY COALESCE(sort_order, 999999) ASC";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getSettings_v2() {
		$sql = "SELECT name, category, subcategory, input, options, is_serialized, sort_order FROM " . DB_PREFIX . "journal_cp_settings ORDER BY COALESCE(sort_order, 999999) ASC";
		$query = $this->db->query($sql);
		$data = array();
		foreach ($query->rows as $row) {
			$data[$row['name']] = $row;
		}
		return $data;
	}

	public function getCategories() {
		$sql = "SELECT category_name FROM " . DB_PREFIX . "journal_cp_categories ORDER BY sort_order ASC";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getSubcategories($category_name) {
		$sql = "SELECT subcategory_name FROM " . DB_PREFIX . "journal_cp_subcategories WHERE category_name = '" . $category_name . "' ORDER BY COALESCE(sort_order, 999999) ASC";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getFonts() {
		$sql = "SELECT * FROM " . DB_PREFIX . "journal_cp_fonts ORDER BY font_name ASC";
		$query = $this->db->query($sql);
		$data = array();
		// ---- make sure system fonts are first
		$data['system'] = array();
		$data['google'] = array();
		// ----
		foreach ($query->rows as $row) {
			$data[$row['group']][] = $row;
		}
		return $data;
	}

	// THEME SETTINGS
	public function addTheme($theme_id, $theme_name) {
		$sql = "UPDATE " . DB_PREFIX . "journal_cp_themes SET active = 'no'";
		$this->db->query($sql);
		$sql = "INSERT INTO " . DB_PREFIX . "journal_cp_themes (theme_id, theme_name) VALUES ('" . $this->db->escape($theme_id) . "', '" . $this->db->escape($theme_name) . "')";
		$this->db->query($sql);
	}

	public function removeTheme($theme_id) {
		$active = $this->getActiveTheme() == $theme_id;
		$sql = "DELETE FROM " . DB_PREFIX . "journal_cp_themes WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		$this->db->query($sql);
		$sql = "DELETE FROM " . DB_PREFIX . "journal_cp_theme_settings WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		$this->db->query($sql);
		if ($active) {
			$sql = "SELECT theme_id FROM " . DB_PREFIX . "journal_cp_themes WHERE core = 1 LIMIT 0, 1";
			$id = $this->db->query($sql)->row['theme_id'];
			$this->setActiveTheme($id);
		}
	}

	public function getActiveTheme() {
		$sql = "SELECT theme_id FROM " . DB_PREFIX . "journal_cp_themes WHERE active = 'yes'";
		return $this->db->query($sql)->row['theme_id'];
	}

	public function isCoreTheme($theme_id) {
		$sql = "SELECT core FROM " . DB_PREFIX . "journal_cp_themes WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		return $this->db->query($sql)->row['core'] == 1;
	}

	public function setActiveTheme($theme_id) {
		$sql = "UPDATE " . DB_PREFIX . "journal_cp_themes SET active = 'yes' WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		$this->db->query($sql);
		$sql = "UPDATE " . DB_PREFIX . "journal_cp_themes SET active = 'no' WHERE theme_id <> '" . $this->db->escape($theme_id) . "'";
		$this->db->query($sql);
	}

	public function setThemeStatus($theme_id, $status) {
		$sql = "UPDATE " . DB_PREFIX . "journal_cp_themes SET status = '" . $status . "' WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		$this->db->query($sql);
	}

	public function getThemeStatus($theme_id) {
		$sql = "SELECT status FROM " . DB_PREFIX . "journal_cp_themes WHERE theme_id = '" . $this->db->escape($theme_id) . "'";
		return $this->db->query($sql)->row['status'];
	}

	public function getThemeSettings($theme_id) {
		$sql = "SELECT setting_name, value, default_value FROM " . DB_PREFIX . "journal_cp_theme_settings WHERE theme_id = '" . $theme_id . "'";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function saveThemeSettings($theme_id, $settings, $update_defaults) {
		foreach ($settings as $key => $value) {
			$sql = "INSERT INTO " . DB_PREFIX . "journal_cp_theme_settings (theme_id, setting_name, value) VALUES('" .
				$theme_id . "', '" . $key . "', '" . $this->db->escape($value) . "') ON DUPLICATE KEY UPDATE value = '" . $this->db->escape($value) . "'";
			$this->db->query($sql);
			if ($update_defaults) {
				$sql = "UPDATE " . DB_PREFIX . "journal_cp_theme_settings SET default_value = value WHERE theme_id= '" . $this->db->escape($theme_id)  . "'";
				$this->db->query($sql);
			}

		}
	}

	private function dump($sql_file) {
		$file = DIR_APPLICATION . 'model/journal/' . $sql_file;

		if (!file_exists($file)) {
			exit('Could not load sql file: ' . $file);
		}

		$lines = file($file);

		if ($lines) {
			$sql = '';

			foreach($lines as $line) {
				if ($line && (substr($line, 0, 2) != '--') && (substr($line, 0, 1) != '#')) {
					$sql .= $line;

					if (preg_match('/;\s*$/', $line)) {
						$sql = str_replace("`dev_", "`" . DB_PREFIX, $sql);

						$this->db->query($sql);

						$sql = '';
					}
				}
			}
		}
	}

	public function install() {
		$this->dump('journal_install.sql');
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('journal_version', array('journal_version' => self::$VERSION));
	}

	public function uninstall() {
		$this->dump('journal_uninstall.sql');
		/* journal old version fix */
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'setting WHERE `group`="journal" AND `key`="journal_version"');
	}

	public function update_journal() {
		$current_themes = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'journal_cp_themes')->rows;
		$current_theme_settings = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'journal_cp_theme_settings')->rows;
		$current_settings = array();

		foreach ($current_theme_settings as $setting) {
			$current_settings[$setting['theme_id'] . '-' . $setting['setting_name']] = $setting['value'];
		}
		if ($this->db->query('SHOW TABLES LIKE "' . DB_PREFIX . 'journal_cp_theme_to_store"')->num_rows > 0) {
			$store_themes = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'journal_cp_theme_to_store')->rows;
		} else {
			$store_themes = array();
		}


		$this->uninstall();
		$this->install();

		$new_theme_settings = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'journal_cp_theme_settings')->rows;
		$new_settings = array();
		$new_avaliable_settings = array();

		foreach ($new_theme_settings as $setting) {
			$new_settings[$setting['theme_id'] . '-' . $setting['setting_name']] = $setting['value'];
			$new_avaliable_settings[] = $setting['setting_name'];
		}

		foreach ($current_themes as $theme) {
			$this->db->query('INSERT INTO ' . DB_PREFIX . 'journal_cp_themes (theme_id, theme_name, status, active, core) VALUES ("' . $theme['theme_id'] . '", "' . $theme['theme_name'] . '", "' . $theme['status'] . '", "' . $theme['active'] . '", "' . $theme['core'] .
				'") ON DUPLICATE KEY UPDATE theme_name="' . $theme['theme_name'] . '", status="' . $theme['status'] . '", active="' . $theme['active'] . '", core="' . $theme['core'] . '"');
		}

		foreach($current_theme_settings as $setting) {
			if (!in_array($setting['setting_name'], $new_avaliable_settings)) continue;

			$key = $setting['theme_id'] . '-' . $setting['setting_name'];
			if (isset($current_settings[$key]) && !isset($new_settings[$key])) {
				$sql = "INSERT INTO " . DB_PREFIX . "journal_cp_theme_settings (theme_id, setting_name, value, default_value) VALUES('" .
				$setting['theme_id'] . "', '" . $setting['setting_name'] . "', '" . $this->db->escape($setting['value']) . "', '" . $this->db->escape($setting['default_value']) . "') ON DUPLICATE KEY UPDATE value = '" . $this->db->escape($setting['value']) . "', default_value = '" . $this->db->escape($setting['default_value']) . "'";
				$this->db->query($sql);
			}
			if (isset($current_settings[$key]) && isset($new_settings[$key]) && $current_settings[$key] != $new_settings[$key]) {
				$sql = 'UPDATE ' . DB_PREFIX . 'journal_cp_theme_settings SET value="' . $this->db->escape($setting['value']) . '" WHERE theme_id="' . $setting['theme_id'] . '" AND setting_name = "' . $setting['setting_name'] . '"';
				$this->db->query($sql);
			}
		}

		foreach ($store_themes as $theme) {
			$this->db->query('INSERT INTO ' . DB_PREFIX . 'journal_cp_theme_to_store (theme_id, store_id) VALUES ("' . $this->db->escape($theme['theme_id']) . '", ' . (int)$theme['store_id'] . ')');
		}

		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('journal_version', array('journal_version' => self::$VERSION));
	}

	public function update_avaliable() {
		return strcmp(self::$VERSION, $this->config->get('journal_version')) > 0;
	}

	public function getCurrentVersion() {
		return $this->config->get('journal_version') ? $this->config->get('journal_version') : '1.0.0';
	}

	/* get product categories v1551*/
	public function getProductCategories($data) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR ' &gt; ') AS name, c.parent_id, c.sort_order FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c ON (cp.path_id = c.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (c.category_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " GROUP BY cp.category_id ORDER BY name";

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

	public function getManufacturers($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "manufacturer";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE LCASE(name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
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

	public function saveThemeStores($theme_id, $store_ids) {
		$ids = explode(',', $store_ids);
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'journal_cp_theme_to_store WHERE theme_id="' . $this->db->escape($theme_id) . '"');
		foreach ($ids as $id) {
			$this->db->query('DELETE FROM ' . DB_PREFIX . 'journal_cp_theme_to_store WHERE store_id=' . (int)$id);
			$this->db->query('INSERT INTO ' . DB_PREFIX . 'journal_cp_theme_to_store (theme_id, store_id) VALUES ("' . $this->db->escape($theme_id) . '", ' . (int)$id . ')');
		}
	}

	public function getThemeStores($theme_id) {
		$check_query = $this->db->query('SHOW TABLES LIKE "' . DB_PREFIX . 'journal_cp_theme_to_store"');
		$res = array();
		if ($check_query->num_rows > 0) {
			$query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'journal_cp_theme_to_store WHERE theme_id="' . $this->db->escape($theme_id) . '"');
			foreach ($query->rows as $row) {
				$res[] = $row['store_id'];
			}
		}
		return $res;
	}

}
?>