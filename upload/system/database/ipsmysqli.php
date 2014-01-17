<?php
final class IPSMySQLi {
	private $link;
	private $expires = 900;
	private $cachename;
	private $filename;
	private $cachedir;


	public function __construct($hostname, $username, $password, $database) {
		$this->link = new mysqli($hostname, $username, $password, $database);

		if (mysqli_connect_error()) {
			throw new ErrorException('Error: Could not make a database link (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
		}

		$this->link->set_charset("utf8");
	}

	public function query($sql) {
		$query = $this->link->query($sql);

		if (!$this->link->errno){
			if (isset($query->num_rows)) {
				$data = array();

				while ($row = $query->fetch_assoc()) {
					$data[] = $row;
				}

				$result = new stdClass();
				$result->num_rows = $query->num_rows;
				$result->row = isset($data[0]) ? $data[0] : array();
				$result->rows = $data;

				unset($data);

				$query->close();

				return $result;
			} else{
				return true;
			}
		} else {
			throw new ErrorException('Error: ' . $this->link->error . '<br />Error No: ' . $this->link->errno . '<br />' . $sql);
			exit();
		}
	}

  	public function cachedQuery($sql, $cachedir) {
		$this->cachedir = DIR_CACHE . $cachedir . '/';
		$this->cachename = md5($sql);
		$this->filename = $this->cachedir . $cachedir . '.' . $this->cachename;

		if (!$this->cacheExists()) {
			$query = $this->link->query($sql);
			if (!$this->link->errno){
				if (isset($query->num_rows)) {
				
					$data = array();

					while ($row = $query->fetch_assoc()) {
						$data[] = $row;
					}

					$result = new stdClass();
					$result->num_rows = $query->num_rows;
					$result->row = isset($data[0]) ? $data[0] : array();
					$result->rows = $data;

					unset($data);

					$query->close();
					$this->saveCache($result);

					return $result;
				} else{
					return true;
				}
			} else {
				throw new ErrorException('Error: ' . $this->link->error . '<br />Error No: ' . $this->link->errno . '<br />' . $sql);
				exit();
			}
		} else {
			$cache = $this->getCache();
			$query = new stdClass();
			$query->row  = !isset($cache['row']) ? array() : $cache['row'];
			$query->rows = !isset($cache['rows']) ? array() : $cache['rows'];
			$query->num_rows = !isset($cache['num_rows']) ? 0 : $cache['num_rows'];
			return $query;		
		}
  	}
	
	protected function cacheExists() {
		if (!file_exists($this->filename)) {
			return false;
		} else {
			return true;
		}
	}
	
	protected function getCache() {
		//$data = apc_fetch($this->filename);
		if (!$data = json_decode(file_get_contents($this->filename), true)) {
			return false;
		}
		return $data;
	}

	protected function saveCache($data) {
		//apc_store($this->filename,$data, $this->expires);
		if (!file_put_contents($this->filename, json_encode($data))) {
			return false;
		}
		return true;
	}
	
	public function deleteCache($filename, $wildcard = false) {
		$filename = $this->dir . $filename;
		// If wildcard is set, delete anything file with a prefix of $filename
		if ($wildcard) {
			foreach (glob($filename.'*') as $file) {
				unlink($file);
			}
		} else { // Just deletes file with filename
			if (file_exists($filename)) {
				unlink($filename);
			}
		}
	}
	
	public function escape($value) {
		return $this->link->real_escape_string($value);
	}

	public function countAffected() {
		return $this->link->affected_rows;
	}

	public function getLastId() {
		return $this->link->insert_id;
	}

	public function __destruct() {
		$this->link->close();
	}
}
?>
<?php
final class IPSMySQL {
	private $link;
	private $expires = 900;
	private $cachename;
	private $filename;
	private $cachedir;
	
	public function __construct($hostname, $username, $password, $database) {
		if (!$this->link = mysql_connect($hostname, $username, $password)) {
      		trigger_error('Error: Could not make a database link using ' . $username . '@' . $hostname);
		}

    	if (!mysql_select_db($database, $this->link)) {
      		trigger_error('Error: Could not connect to database ' . $database);
    	}
		
		mysql_query("SET NAMES 'utf8'", $this->link);
		mysql_query("SET CHARACTER SET utf8", $this->link);
		mysql_query("SET CHARACTER_SET_CONNECTION=utf8", $this->link);
		mysql_query("SET SQL_MODE = ''", $this->link);
	}
		
  	public function query($sql) {
		$resource = mysql_query($sql, $this->link);

		if ($resource) {
			if (is_resource($resource)) {
				$i = 0;
    	
				$data = array();
		
				while ($result = mysql_fetch_assoc($resource)) {
					$data[$i] = $result;
    	
					$i++;
				}
				
				mysql_free_result($resource);
				
				$query = new stdClass();
				$query->row = isset($data[0]) ? $data[0] : array();
				$query->rows = $data;
				$query->num_rows = $i;
				
				unset($data);

				return $query;	
    		} else {
				return true;
			}
		} else {
			trigger_error('Error: ' . mysql_error($this->link) . '<br />Error No: ' . mysql_errno($this->link) . '<br />' . $sql);
			exit();
    	}
  	}

  	public function cachedQuery($sql, $cachedir) {
		$this->cachedir = DIR_CACHE . $cachedir . '/';
		$this->cachename = md5($sql);
		$this->filename = $this->cachedir . $cachedir . '.' . $this->cachename;

		if (!$this->cacheExists()) {
			$resource = mysql_query($sql, $this->link);
			if ($resource) {
				if (is_resource($resource)) {
					$i = 0;
			
					$data = array();
			
					while ($result = mysql_fetch_assoc($resource)) {
						$data[$i] = $result;
						$i++;
					}
					
					mysql_free_result($resource);
					
					$query = new stdClass();
					$query->row = isset($data[0]) ? $data[0] : array();
					$query->rows = $data;
					$query->num_rows = $i;
					
					unset($data);
					
					$this->saveCache($query);
					
					return $query;	
				} else {
					return true;
				}
			} else {
				trigger_error('Error: ' . mysql_error($this->link) . '<br />Error No: ' . mysql_errno($this->link) . '<br />' . $sql);
				exit();
			}
		} else {
			$cache = $this->getCache();
			$query = new stdClass();
			$query->row  = !isset($cache['row']) ? array() : $cache['row'];
			$query->rows = !isset($cache['rows']) ? array() : $cache['rows'];
			$query->num_rows = !isset($cache['num_rows']) ? 0 : $cache['num_rows'];
			return $query;		
		}
  	}
	
	protected function cacheExists() {
		if (!file_exists($this->filename)) {
			return false;
		} else {
			return true;
		}
	}
	
	protected function getCache() {
		//$data = apc_fetch($this->filename);
		if (!$data = json_decode(file_get_contents($this->filename), true)) {
			return false;
		}
		return $data;
	}

	protected function saveCache($data) {
		//apc_store($this->filename,$data, $this->expires);
		if (!file_put_contents($this->filename, json_encode($data))) {
			return false;
		}
		return true;
	}
	
	public function deleteCache($filename, $wildcard = false) {
		$filename = $this->dir . $filename;
		// If wildcard is set, delete anything file with a prefix of $filename
		if ($wildcard) {
			foreach (glob($filename.'*') as $file) {
				unlink($file);
			}
		} else { // Just deletes file with filename
			if (file_exists($filename)) {
				unlink($filename);
			}
		}
	}
		
	public function escape($value) {
		return mysql_real_escape_string($value, $this->link);
	}
	
  	public function countAffected() {
    	return mysql_affected_rows($this->link);
  	}

  	public function getLastId() {
    	return mysql_insert_id($this->link);
  	}	
	
	public function __destruct() {
		mysql_close($this->link);
	}
}
?>