<?php
//==============================================================================
// Smart Search v156.4
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ModelCatalogSmartsearch extends Model {
	private $type = 'catalog';
	private $name = 'smartsearch';
	private $results;
	private $settings;
	
	public function smartsearch($data = array()) {
		// Uncomment the following line if you get errors about exceeding MAX_JOIN_SIZE rows
		//$this->db->query("SET SQL_BIG_SELECTS=1");
		
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		$this->settings = ($version < 151) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		$this->results = array();
		
		if (!empty($this->settings['testing_mode'])) {
			$this->session->data[$this->name . '_time'] = microtime(true);
			$this->session->data[$this->name . '_message'] = '';
		}
		
		$customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getCustomerGroupId() : (int)$this->config->get('config_customer_group_id');
		$language_id = (int)$this->config->get('config_language_id');
		$store_id = (int)$this->config->get('config_store_id');
		
		$table_query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . $this->name . "'");
		$this->settings['record_search'] = ($table_query->num_rows && empty($data['ajax']) && !empty($data['filter_name']) && (empty($data['sort']) || $data['sort'] == 'p.sort_order') && empty($data['start'])) ? $data['filter_name'] : '';
		
		// Perform pre-search replacements
		if (!empty($this->settings['replace_array'])) {
			if (!empty($data['filter_name'])) {
				$data['filter_name'] = trim(str_replace($this->settings['replace_array'], $this->settings['with_array'], ' ' . $data['filter_name'] . ' '));
			}
			if (!empty($data['filter_tag'])) {
				$data['filter_tag'] = trim(str_replace($this->settings['replace_array'], $this->settings['with_array'], ' ' . $data['filter_tag'] . ' '));
			}
		}
		if (!empty($data['filter_name'])) $data['filter_name'] = strtolower($data['filter_name']);
		if (!empty($data['filter_tag'])) $data['filter_tag'] = strtolower($data['filter_tag']);
		
		// Check if search is cached
		unset($data['ajax']);
		unset($data['order']);
		unset($data['start']);
		unset($data['limit']);
		$this->settings['search_hash'] = md5(http_build_query($data));
		
		$cache_files = glob(DIR_CACHE . $this->name . '_hash.' . $this->settings['search_hash'] . '.' . $store_id . '.' . $language_id . '.*');
		if ($cache_files && file_exists($cache_files[0])) {
			if (substr(strrchr($cache_files[0], '.'), 1) < time()) {
				unlink($cache_files[0]);
			} else {
				$cache = unserialize(file_get_contents($cache_files[0]));
				if ($this->settings['testing_mode'] == 1) {
					$this->session->data[$this->name . '_message'] .= 'Smart Search found this search phrase cached in ' . round(microtime(true) - $this->session->data[$this->name . '_time'], 4) . ' seconds';
					unset($this->session->data[$this->name . '_time']);
				}
				if ($this->settings['testing_mode'] == 2) {
					$this->session->data[$this->name . '_message'] .= 'Smart Search found this search phrase cached in ' . round(microtime(true) - $this->session->data[$this->name . '_time'], 4) . ' seconds';
					$this->session->data[$this->name . '_message'] .= ', and would normally finish at that point<br />Assuming no cached search is found . . . ';
					$this->settings['already_cached'] = true;
				} else {
					if ($this->settings['record_search'] != '') {
						$this->db->query("INSERT INTO " . DB_PREFIX . $this->name . " SET date_added = NOW(), search = '" . $this->db->escape($this->settings['record_search']) . "', phase = 0, results = " . (int)count($cache) . ", customer_id = " . (int)$this->customer->getId() . ", ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");
					}
					return $cache;
				}
			}
		}
		
		// Determine search fields
		$meta_keyword = ($version < 150) ? 'meta_keywords' : 'meta_keyword';
		$this->load->model('catalog/product');
		if (method_exists($this->model_catalog_product, 'getProductTags')) {
			$product_tag_table = ($version < 150) ? 'product_tags' : 'product_tag';
		} else {
			$product_tag_table = '';
		}
		
		$search_tags = (!empty($this->settings['tag']) || (!empty($data['filter_tag']) && $data['filter_tag'] != $data['filter_name']));
		
		$fields = array();
		if (!empty($this->settings['name']))												$fields['pd.name'] = 'name';
		if (!empty($this->settings['description']) || !empty($data['filter_description']))	$fields['pd.description'] = 'description';
		if (!empty($this->settings['meta_description']))									$fields['pd.meta_description'] = 'meta_description';
		if (!empty($this->settings[$meta_keyword]))											$fields['pd.' . $meta_keyword] = $meta_keyword;
		if ($search_tags && $product_tag_table)												$fields['pt.tag'] = 'tag';
		if ($search_tags && !$product_tag_table)											$fields['pd.tag'] = 'tag';
		if (!empty($this->settings['model']) || !empty($data['filter_model']))				$fields['p.model'] = 'model';
		if (!empty($this->settings['sku']))													$fields['p.sku'] = 'sku';
		if (!empty($this->settings['upc']) && $version > 149)								$fields['p.upc'] = 'upc';
		if (!empty($this->settings['ean']) && $version > 153)								$fields['p.ean'] = 'ean';
		if (!empty($this->settings['jan']) && $version > 153)								$fields['p.jan'] = 'jan';
		if (!empty($this->settings['isbn']) && $version > 153)								$fields['p.isbn'] = 'isbn';
		if (!empty($this->settings['mpn']) && $version > 153)								$fields['p.mpn'] = 'mpn';
		if (!empty($this->settings['location']))											$fields['p.location'] = 'location';
		if (!empty($this->settings['manufacturer']))										$fields['m.name'] = 'manufacturer';
		if (!empty($this->settings['attribute_group']) && $version > 149)					$fields['agd.name'] = 'attribute_group';
		if (!empty($this->settings['attribute_name']) && $version > 149)					$fields['ad.name'] = 'attribute_name';
		if (!empty($this->settings['attribute_value']) && $version > 149)					$fields['pa.text'] = 'attribute_value';
		if (!empty($this->settings['option_name']))											$fields[($version < 150) ? 'pod.name' : 'od.name'] = 'option_name';
		if (!empty($this->settings['option_value']))										$fields[($version < 150) ? 'povd.name' : 'ovd.name'] = 'option_value';
		//if (!empty($this->settings['option_value']) && $version > 149)					$fields['po.option_value'] = 'product_option_value';
		
		$search_attributes = in_array('attribute_group', $fields) || in_array('attribute_name', $fields) || in_array('attribute_value', $fields);
		$search_options = in_array('option_name', $fields) || in_array('option_value', $fields);
		
		// Determine relevance rankings
		$relevance_rankings = array();
		foreach ($fields as $column => $alias) {
			if ($alias == 'product_option_value') $alias = 'option_value';
			if ((int)$this->settings['relevance'][$alias] >= 0) $relevance_rankings[] = (int)$this->settings['relevance'][$alias];
		}
		$relevance_rankings = array_unique($relevance_rankings);
		sort($relevance_rankings);
		
		// Determine sorting
		if (isset($data['sort']) && in_array($data['sort'], array('pd.name', 'p.price', 'rating', 'p.model'))) {
			$sort = $data['sort'];
			$order = "ASC";
		} else {
			if ($this->settings['default_sort'] == 'date_added')		$sort = 'p.date_added';
			if ($this->settings['default_sort'] == 'date_available')	$sort = 'p.date_available';
			if ($this->settings['default_sort'] == 'date_modified')		$sort = 'p.date_modified';
			if ($this->settings['default_sort'] == 'model')				$sort = 'p.model';
			if ($this->settings['default_sort'] == 'name')				$sort = 'pd.name';
			if ($this->settings['default_sort'] == 'price')				$sort = 'p.price';
			if ($this->settings['default_sort'] == 'quantity')			$sort = 'p.quantity';
			if ($this->settings['default_sort'] == 'rating')			$sort = 'rating';
			if ($this->settings['default_sort'] == 'times_purchased')	$sort = 'times_purchased';
			if ($this->settings['default_sort'] == 'times_viewed')		$sort = 'p.viewed';
			if ($this->settings['default_sort'] == 'sort_order')		$sort = 'p.sort_order';
			$order = $this->settings['default_order'];
		}
		
		// Select SQL
		$select_sql = "SELECT p.product_id, ";
		
		if ($sort == 'p.price') {
			$select_sql .= "p.price, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = " . $customer_group_id . " AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";
		} elseif ($sort == 'rating') {
			$select_sql .= "(SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r WHERE r.product_id = p.product_id AND r.status = 1 GROUP BY r.product_id) AS rating";
		} elseif ($sort == 'times_purchased') {
			$select_sql .= "SUM(op.quantity) AS times_purchased";
		} else {
			$select_sql .= $sort;
		}
		
		$join_sql = " FROM " . DB_PREFIX . "product p";
		$join_sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id AND pd.language_id = " . $language_id . ")";
		$join_sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";
		$join_sql .= (in_array('manufacturer', $fields)) ? " LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)" : "";
		if ($search_attributes) {
			$join_sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute pa ON (p.product_id = pa.product_id)";
			$join_sql .= " LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id)";
			$join_sql .= " LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (a.attribute_group_id = agd.attribute_group_id)";
			$join_sql .= " LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (pa.attribute_id = ad.attribute_id)";
		}
		if ($search_options) {
			$join_sql .= ($version < 150) ? "" : " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (p.product_id = pov.product_id)";
			$join_sql .= ($version < 150) ? " LEFT JOIN " . DB_PREFIX . "product_option_description pod ON (p.product_id = pod.product_id)" : " LEFT JOIN " . DB_PREFIX . "option_description od ON (pov.option_id = od.option_id)";
			$join_sql .= ($version < 150) ? " LEFT JOIN " . DB_PREFIX . "product_option_value_description povd ON (p.product_id = povd.product_id)" : " LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (pov.option_value_id = ovd.option_value_id)";
		}
		if ($search_tags && $product_tag_table) {
			$join_sql .= " LEFT JOIN " . DB_PREFIX . $product_tag_table . " pt ON (p.product_id = pt.product_id AND pt.language_id = " . $language_id . ")";
		}
		if ($sort == 'times_purchased') {
			$join_sql .= " LEFT JOIN " . DB_PREFIX . "order_product op ON (op.product_id = p.product_id)";
		}
		$join_sql .= " WHERE p.date_available <= NOW() AND p.status = 1 AND p.sort_order >= 0 AND p2s.store_id = " . $store_id;
		
		$select_sql .= $join_sql;
		
		// Tag SQL
		if (!empty($data['filter_tag']) && $data['filter_tag'] != $data['filter_name']) {
			$select_sql .= " AND " . $this->likeRegexp($product_tag_table ? 'pt.tag' : 'pd.tag', $data['filter_tag']);
		}
		
		// Category SQL
		if (!empty($data['filter_category_id'])) {
			$select_sql .= " AND p.product_id IN (SELECT p2c.product_id FROM " . DB_PREFIX . "product_to_category p2c WHERE";
			if (!empty($this->settings['subcategories']) || !empty($data['filter_sub_category'])) {
				$implode_data = array();
				$categories = $this->getCategoriesByParentId($data['filter_category_id']);
				foreach ($categories as $category_id) {
					$implode_data[] = "p2c.category_id = " . (int)$category_id;
				}
				$select_sql .= " " . implode(' OR ', $implode_data) . ")";			
			} else {
				$select_sql .= " p2c.category_id = " . (int)$data['filter_category_id'] . ")";
			}
		}
		
		// Group By and Order By SQL
		$order_sql = " GROUP BY p.product_id ORDER BY ";
		
		if ($sort == 'pd.name' || $sort == 'p.model') {
			$order_sql .= "LCASE(" . $sort . ")";
		} elseif ($sort == 'p.price') {
			$order_sql .= "IFNULL(special, p.price)";
		} elseif ($sort == 'times_purchased') {
			$order_sql .= "times_purchased";
		} else {
			$order_sql .= $sort;
		}
		
		$order_sql .= " " . $order;
		
		// Phase 1: keywords as exact phrase
		if (!empty($data['filter_name'])) {
			$keyword = $data['filter_name'];
			foreach ($relevance_rankings as $ranking) {
				$sql_array = array();
				foreach ($fields as $column => $alias) {
					$relevance = ($alias == 'product_option_value') ? $this->settings['relevance']['option_value'] : $this->settings['relevance'][$alias];
					if ($relevance == $ranking) {
						$sql_array[] = $this->likeRegexp($column, $keyword);
						if ($alias == 'name' && !empty($this->settings['plurals'])) {
							if (substr($keyword, -1) == 's') $sql_array[] = $this->likeRegexp($column, substr($keyword, 0, -1));
							if (substr($keyword, -2) == 'es') $sql_array[] = $this->likeRegexp($column, substr($keyword, 0, -2));
						}
					}
				}
				$this->runQuery($select_sql . " AND (" . implode(" OR ", $sql_array) . ")" . $order_sql);
			}
			if ($this->isFinished(1)) return $this->results;
		} elseif ($search_tags) {
			$this->runQuery($select_sql . $order_sql);
			if ($this->isFinished(1)) return $this->results;
		}
		
		// Phase 2: all keywords, properly spelled
		$keywords = (!empty($data['filter_name'])) ? explode(' ', $data['filter_name']) : array();
		if (count($keywords > 1)) {
			foreach ($relevance_rankings as $ranking) {
				$phase_sql = "";
				foreach ($keywords as $keyword) {
					$sql_array = array();
					foreach ($fields as $column => $alias) {
						$relevance = ($alias == 'product_option_value') ? $this->settings['relevance']['option_value'] : $this->settings['relevance'][$alias];
						if ($relevance == $ranking) {
							$sql_array[] = $this->likeRegexp($column, $keyword);
							if ($alias == 'name' && !empty($this->settings['plurals'])) {
								if (substr($keyword, -1) == 's') $sql_array[] = $this->likeRegexp($column, substr($keyword, 0, -1));
								if (substr($keyword, -2) == 'es') $sql_array[] = $this->likeRegexp($column, substr($keyword, 0, -2));
							}
						}
					}
					$phase_sql .= " AND (" . implode(" OR ", $sql_array) . ")";
				}
				$this->runQuery($select_sql . $phase_sql . $order_sql);
			}
			if ($this->isFinished(2)) return $this->results;
		}
		
		// Determine whether caching is enabled
		if (empty($this->settings['cache_misspelling'])) {
			
			// Caching is disabled
			$phase_sql = array();
			
			if (!empty($data['filter_name'])) {
				foreach (explode(' ', $data['filter_name']) as $kw) {
					$underscored = $this->generateVariations($kw, 'underscore');
					$removed = $this->generateVariations($kw, 'remove');
					$transposed = $this->generateVariations($kw, 'transpose');
					$keywords = array_merge($underscored, $removed, $transposed);
					
					if (empty($keywords)) continue;
					$keywords = array_map('mysql_real_escape_string', $keywords);
					
					$variation_sql = array();
					foreach ($keywords as $keyword) {
						foreach ($fields as $column => $alias) {
							$variation_sql[] = $this->likeRegexp($column, $keyword);
						}
					}
					
					$phase_sql[] = implode(" OR ", $variation_sql);
				}
			}
			
			if (empty($phase_sql)) {
				$phase_sql = array("FALSE");
			}
			
			// Phase 3: all keywords, misspelled
			$this->runQuery($select_sql . " AND ((" . implode(") AND (", $phase_sql) . "))" . $order_sql);
			if ($this->isFinished(3)) return $this->results;
			
			// Phase 4: any keywords, misspelled
			$this->runQuery($select_sql . " AND ((" . implode(") OR (", $phase_sql) . "))" . $order_sql);
			if ($this->isFinished(4)) return $this->results;
			
		} else {
			
			// Caching is enabled, check for cache files
			$cache_files = glob(DIR_CACHE . $this->name . '*.' . $store_id . '.' . $language_id . '.*');
			if ($cache_files) {
				foreach ($cache_files as $cache_file) {
					if (substr(strrchr($cache_file, '.'), 1) < time() && file_exists($cache_file)) {
						unlink($cache_file);
					}
				}
			}
			if (!$cache_files || !file_exists($cache_files[0])) {
				
				// Cache files don't exist
				$loop_interval = max(5000, (int)ini_get('memory_limit') * 400);
				$time = time() + (int)$this->settings['cache_misspelling'];
				
				// Cache SQL
				$cache_sql = "SELECT ";
				foreach ($fields as $column => $alias) {
					$cache_sql .= " " . $column . " AS " . $alias . ",";
				}
				$cache_sql .= " p.product_id";
				
				for ($loop = 0; true; $loop += $loop_interval) {
					$cache = array();
					
					$product_query = $this->db->query($cache_sql . $join_sql . " GROUP BY p.product_id LIMIT " . $loop . "," . $loop_interval);
					if (!$product_query->num_rows) break;
					
					foreach ($product_query->rows as $result) {
						$words = array();
						if (!empty($this->settings['description_misspelled'])) {
							$sanitized_description = preg_replace('/[\x00-\x1F]*/u', '', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')));
							$words = array_merge($words, explode(' ', strtolower($sanitized_description)));
						}
						foreach ($fields as $column => $alias) {
							if ($alias == 'description') continue;
							if ($alias == 'tag') {
								if ($product_tag_table) {
									$tags = array();
									$tag_query = $this->db->query("SELECT tag FROM " . DB_PREFIX . $product_tag_table . " WHERE product_id = " . (int)$result['product_id'] . " AND language_id = " . (int)$language_id);
									foreach ($tag_query->rows as $tag) {
										$tags[] = trim(strtolower(html_entity_decode($tag['tag'], ENT_QUOTES, 'UTF-8')));
									}
									$words = array_merge($words, $tags);
								} else {
									$words = array_merge($words, array_map('trim', explode(',', strtolower(html_entity_decode($result[$alias], ENT_QUOTES, 'UTF-8')))));
								}
							} else {
								$words = array_merge($words, explode(' ', strtolower(html_entity_decode($result[$alias], ENT_QUOTES, 'UTF-8'))));
							}
						}
						foreach ($words as $word) {
							if (strlen($word) >= (int)$this->settings['word_length'] && (!isset($cache[$word]) || !in_array($result['product_id'], $cache[$word]))) {
								$cache[$word][] = $result['product_id'];
							}
						}
					}
					
					file_put_contents(DIR_CACHE . $this->name . '.' . ($loop/$loop_interval) . '.' . $store_id . '.' . $language_id . '.' . $time, serialize($cache));
				}
			}
			
			// Phases 3 and 4
			$matches = array();
			$cache_files = glob(DIR_CACHE . $this->name . '.*.' . $store_id . '.' . $language_id . '.*');
			foreach ($cache_files as $cache_file) {
				if (!file_exists($cache_file)) continue;
				$cache = unserialize(file_get_contents($cache_file));
				foreach (array_merge(array($data['filter_name']), explode(' ', $data['filter_name'])) as $keyword) {
					if (!isset($matches[$keyword])) $matches[$keyword] = array();
					foreach ($cache as $word => $product_ids) {
						similar_text($word, $keyword, $percentage);
						if ($percentage >= $this->settings['tolerance']) {
							$matches[$keyword] = array_merge($matches[$keyword], $product_ids);
						}
					}
				}
			}
			
			$matches_sql = array();
			foreach ($matches as $match_list) {
				$matches_sql[] = (empty($match_list)) ? "FALSE" : "(p.product_id = " . implode(" OR p.product_id = ", $match_list) . ")";
			}
			if (empty($matches_sql)) {
				$matches_sql = array("FALSE");
			}
			
			// Phase 3: all keywords, misspelled
			$this->runQuery($select_sql . " AND (" . implode(" AND ", $matches_sql) . ")" . $order_sql);
			if ($this->isFinished(3)) return $this->results;
			
			// Phase 4: any keywords, misspelled
			$this->runQuery($select_sql . " AND (" . implode(" OR ", $matches_sql) . ")" . $order_sql);
			if ($this->isFinished(4)) return $this->results;
		}
	}
	
	private function likeRegexp($column, $keyword) {
		$like_sql = "LCASE(" . $column . ") LIKE '%" . $this->db->escape($keyword) . "%'";
		$like_sql .= ($this->settings['partials']) ? "" : " AND LCASE(" . $column . ") REGEXP '[[:<:]]" . $this->db->escape($keyword) . "[[:>:]]'";
		return "(" . $like_sql . ")";
	}
	
	private function runQuery($sql) {
		if (!empty($this->settings['testing_mode'])) {
			$this->log->write('SMART SEARCH RUNNING QUERY: ' . $sql);
		}
		$query = $this->db->query($sql);
		foreach ($query->rows as $product) {
			$this->results[] = $product['product_id'];
		}
		$this->results = array_unique($this->results);
	}
	
	private function isFinished($phase) {
		if (count($this->results) > (int)$this->settings['min_results'] || $phase == 4 || ((int)$this->settings['tolerance'] == 100 && $phase == 2)) {
			if ($this->settings['record_search'] != '') {
				$this->db->query("INSERT INTO " . DB_PREFIX . $this->name . " SET date_added = NOW(), search = '" . $this->db->escape($this->settings['record_search']) . "', phase = " . (int)$phase . ", results = " . (int)count($this->results) . ", customer_id = " . (int)$this->customer->getId() . ", ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");
			}
			if (!empty($this->settings['cache_individual']) && empty($this->settings['already_cached'])) {
				file_put_contents(DIR_CACHE . $this->name . '_hash.' . $this->settings['search_hash'] . '.' . (int)$this->config->get('config_store_id') . '.' . (int)$this->config->get('config_language_id') . '.' . (time() + (int)$this->settings['cache_individual']), serialize($this->results));
			}
			return true;
		} else {
			return false;
		}
	}
	
	private function getCategoriesByParentId($category_id) {
		$category_data = array($category_id);
		$category_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id = " . (int)$category_id);
		foreach ($category_query->rows as $category) {
			$children = $this->getCategoriesByParentId($category['category_id']);
			if ($children) $category_data = array_merge($children, $category_data);
		}
		return $category_data;
	}
	
	private function generateVariations($word, $type, $level = 1) {
		$words = array();
		$length = strlen($word);
		if (!$length) return array();
		if ((1 - $level / $length) >= ($this->settings['tolerance'] / 100)) {
			for ($j = 0; $j < $length; $j++) {
				if ($type == 'underscore') {
					$new_word = substr_replace($word, '_', $j, 1);
				} elseif ($type == 'remove') {
					$new_word = substr_replace($word, '', $j, 1);
				} elseif ($type == 'transpose') {
					if ($j == $length - 1) continue;
					$new_word = $word;
					$new_word[$j] = $word[$j+1];
					$new_word[$j+1] = $word[$j];
				}
				$words[] = $new_word;
				$words = array_merge($words, $this->generateVariations($new_word, $type, $level + 1));
			}
		}
		return array_unique($words);
	}
	
	public function getProducts($smartsearch_results, $data) {
		if ($data['order'] == 'DESC') $smartsearch_results = array_reverse($smartsearch_results);
		$results = array_slice($smartsearch_results, $data['start'], $data['limit']);
		
		$this->load->model('catalog/product');
		$products = array();
		foreach ($results as $result) {
			$products[$result] = $this->model_catalog_product->getProduct($result);
		}
		
		if (!empty($this->session->data[$this->name . '_time'])) {
			$this->session->data[$this->name . '_message'] .= 'Smart Search took ' . round(microtime(true) - $this->session->data[$this->name . '_time'], 4) . ' seconds to retrieve the products';
			unset($this->session->data[$this->name . '_time']);
		}
		
		return $products;
	}
}
?>