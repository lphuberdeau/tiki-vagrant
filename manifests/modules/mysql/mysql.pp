class mysql {
 
	package { [ "mysql-server", "mysql-client" ]:
		ensure => present
	}
 
	service { "mysql":
		ensure => running,
		require => Package["mysql-server"]
	}

	define mysql_db($script = $title) {
		exec { "schema-and-user-${script}":
			command => "/usr/bin/mysql -u root -e \"drop database if exists ${script}; create database ${script}; create user ${script}@'localhost' identified by '${script}'; grant all on ${script}.* to ${script}@'localhost'; flush privileges;\"",
			require => Service["mysql"],
			creates => "/var/lib/mysql/${script}",
		}
	}
}

