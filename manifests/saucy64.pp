group { "puppet":
	ensure => "present",
}

exec { "apt-update":
	command => "/usr/bin/apt-get update",
}

$base_packages = ["php5-fpm", "php5-cli", "vim", "vim-common", "htop", "php5-xdebug", "subversion", "php5-json", "php5-mysql", "php5-curl"]
package { $base_packages:
	ensure => "present",
	require => Exec['apt-update'],
}

define upstart($script = $title, $start = false) {
	file { "/etc/init/${script}.conf":
		source => "/tmp/vagrant-puppet/manifests/modules/upstart/${script}.conf",
		ensure => "present",
		owner => "root",
		group => "root",
	}

	if $start {
		service { $script:
			ensure => "running",
			provider => "upstart",
			require => File["/etc/init/${script}.conf"],
		}
	}
}

import 'modules/mysql/mysql.pp'

include mysql

