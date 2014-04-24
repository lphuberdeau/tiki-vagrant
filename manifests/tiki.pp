group { "puppet":
	ensure => "present",
}

import 'modules/mysql/mysql.pp'

include mysql

define nginx_site ($script = $title, $source) {
	file { "/etc/nginx/sites-enabled/${script}":
		source => "/tmp/vagrant-puppet-1/manifests/modules/${source}",
		ensure => "present",
		require => [
			Package['nginx'],
			Package['php5-fpm'],
		],
		notify => Service['nginx'],
	}
}

define tiki ($version = $title) {
	nginx_site { "tiki_${version}":
		source => "nginx/tiki_${version}",
	}
	mysql::mysql_db { "tiki_${version}": }
}

exec { "apt-update":
	command => "/usr/bin/apt-get update",
}

$base_packages = ["php5-fpm", "php5-cli", "php5-xdebug", "php5-json", "php5-mysql", "php5-curl", "php5-mcrypt", "php5-gd", "php5-gmp",
				"vim", "vim-common", "htop", "subversion", "phpmyadmin", "nginx"]
package { $base_packages:
	ensure => "present",
	require => Exec['apt-update'],
}

file { "/home/vagrant/.vimrc":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/vimrc",
	ensure => "present",
	owner => "vagrant",
	group => "vagrant",
}

file { "/home/vagrant/.bash_profile":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/bashrc",
	ensure => "present",
	owner => "vagrant",
	group => "vagrant",
}

file { "/home/vagrant/activate":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/activate",
	ensure => "present",
	owner => "vagrant",
	group => "vagrant",
}

file { "/etc/php5/fpm/conf.d/99-php_settings.ini":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/99-php_settings.ini",
	ensure => "present",
	require => Package['php5-fpm'],
	notify => Service['php5-fpm'],
}

file { "/etc/tiki.ini":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/tiki.ini",
	ensure => "present",
	require => Package['php5-fpm'],
	notify => Service['php5-fpm'],
	mode => 0644,
}

file { "/etc/php5/fpm/pool.d/www.conf":
	source => "/tmp/vagrant-puppet-1/manifests/modules/nginx/www.conf",
	ensure => "present",
	require => Package['php5-fpm'],
	notify => Service['php5-fpm'],
}

file { "/etc/php5/cli/conf.d/99-php_settings.ini":
	source => "/tmp/vagrant-puppet-1/manifests/modules/tikisetup/99-php_settings.ini",
	ensure => "present",
	require => Package['php5-cli'],
}

file { "/etc/phpmyadmin/conf.d/99-local.php":
	source => "/tmp/vagrant-puppet-1/manifests/modules/phpmyadmin/99-local.php",
	ensure => "present",
	require => Package['phpmyadmin'],
}

file { "/etc/nginx/nginx.conf":
	source => "/tmp/vagrant-puppet-1/manifests/modules/nginx/nginx.conf",
	ensure => "present",
	notify => Service['nginx'],
	require => Package['nginx'],
}

service { "nginx":
	ensure => "running",
	require => Package['nginx'],
}

service { "php5-fpm":
	ensure => "running",
	require => Package['php5-fpm'],
}

nginx_site { "phpmyadmin":
	source => "phpmyadmin/phpmyadmin",
	require => Package['phpmyadmin'],
}

tiki { "12": }
tiki { "13": }
tiki { "14": }
tiki { "15": }

file { "/home/vagrant/cachegrind":
	ensure => "directory",
	owner => "vagrant",
	group => "vagrant",
	mode => 0755,
}

