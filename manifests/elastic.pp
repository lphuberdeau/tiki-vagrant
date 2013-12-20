group { "puppet":
	ensure => "present",
}

exec { "apt-update":
	command => "/usr/bin/apt-get update",
}

$base_packages = ["curl", "openjdk-7-jre-headless", "wget"]
package { $base_packages:
	ensure => "present",
	require => Exec['apt-update'],
}

install_elastic { "0.90.7": }

define install_elastic($version = $title) {
	exec { "get-elasticsearch":
		command => "/usr/bin/wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb",
		cwd => "/root",
		creates => "/root/elasticsearch-${version}.deb",
		require => Package["wget"],
	}
	package { "elasticsearch":
		provider => "dpkg",
		ensure => "installed",
		source => "/root/elasticsearch-${version}.deb",
		require => [
			Exec['get-elasticsearch'],
			Package['openjdk-7-jre-headless'],
		]
	}
}
