class mysql {
 
	package { [ "mysql-server", "mysql-client" ]:
		ensure => present
	}
 
	service { "mysql":
		ensure => running,
		require => Package["mysql-server"]
	}

	define myinstance($script = $title) {
		exec { "schema-and-user-${script}":
			command => "/usr/bin/mysql -u root -e \"drop database if exists ${script}; create database ${script}; create user ${script}@'localhost' identified by '${script}'; grant all on ${script}.* to ${script}@'localhost'; flush privileges;\"",
			require => Service["mysql"],
			creates => "/var/lib/mysql/${script}",
		}
	}

	myinstance { "tiki_9": }
	myinstance { "tiki_10": }
	myinstance { "tiki_11": }
	myinstance { "tiki_12": }
	myinstance { "tiki_13": }
	myinstance { "tiki_14": }
	myinstance { "tiki_15": }
}

