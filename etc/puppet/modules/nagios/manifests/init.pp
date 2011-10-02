class nagios::install {
	package { [ "nagios", "nagios-plugins", "nagios-plugins-all", "nagios-plugins-nrpe", "nrpe", "httpd" ]: ensure => installed }
}

class nagios::config{

	file { "/etc/nagios/cgi.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/nagios/cgi.cfg",
               require => Package["nagios"],
        }
	file { "/etc/nagios/nagios.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/nagios/nagios.cfg",
               require => Package["nagios"],
        }
	 file { "/etc/nagios/localhost.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/nagios/localhost.cfg",
               require => Package["nagios"],
        }
	 file { "/etc/nagios/commands.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/nagios/commands.cfg",
               require => Package["nagios"],
        }

	file { "/etc/nagios/nagios_host.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
               require => Package["nagios"],
        }
	 file { "/etc/nagios/nagios_service.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
               require => Package["nagios"],
        }

        file { "/etc/nagios/nrpe.cfg":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/nagios/nrpe.cfg",
               require => Package["nrpe"],
        }

        file { "/etc/httpd/conf.d/nagios.conf":
                owner => "root",
                group => "root",
                mode => 0777,
                source => "puppet://$puppetserver/modules/nagios/etc/httpd/conf.d/nagios.conf",
              require => Package["httpd"],
        }


}

class nagios::service {
	service { "nagios":
                ensure => running,
                hasstatus => true,
                enable => true,
                subscribe => Package["nagios"],
        }

        service { "nrpe":
                ensure => running,
                hasstatus => true,
                enable => true,
                subscribe => Package["nrpe"],
        }
        service { "httpd":
                ensure => running,
                hasstatus => true,
                enable => true,
                subscribe => Package["httpd"],
        }

}


class nagios {

include nagios::install, nagios::config, nagios::service

	resources { [ "nagios_service", "nagios_servicegroup", "nagios_host" ]:
		    purge => true;
	}


Nagios_host <<||>> { notify => Service["nagios"] }
Nagios_service <<||>> { notify => Service["nagios"] }


class target {
	@@nagios_host { "$fqdn":
		ensure => present,
		alias => $hostname,
		address => $ipaddress,
		use => "generic-host",
	}

	@@nagios_service { "check_ping_${hostname}":
		check_command => "check_ping!100.0,20%!500.0,60%",
		use => "generic-service",
		host_name => "$fqdn",
		notification_period => "24x7",
		service_description => "${hostname}_check_ping"
	}
	@@nagios_service { "check_tcp_ActiveMQ${hostname}":
                check_command => "check_tcp!61613!",
                use => "generic-service",
                host_name => "$fqdn",
                notification_period => "24x7",
                service_description => "${hostname}_check_tcp_ActiveMQ"
        }

	
 
   } 

}
