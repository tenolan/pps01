class activemq::install {
#	package { 'jdk.x86_64': ensure => installed }
	package { 'tanukiwrapper.x86_64': ensure => installed }
	package { 'activemq.noarch': ensure => installed }

}

class activemq::config {
	file { '/etc/activemq/activemq.xml':
		mode => 644,
		owner => "root",
		group => "root",
		source => "puppet://$puppetserver/modules/activemq/etc/activemq/activemq.xml",
		require => Package["activemq.noarch"],
	}
}

class activemq::service {
	service { "activemq":
		ensure => running,
		enable => true,
		pattern => 'activemq',
		subscribe => [Package["activemq.noarch"], File["/etc/activemq/activemq.xml"]],
	}
}

class activemq {
	include activemq::install, activemq::config, activemq::service
}

