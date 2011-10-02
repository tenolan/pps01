class reqfiles {
	 package { [ "nagios-plugins", "nagios-plugins-all", "nagios-plugins-nrpe" , "nrpe" ]: ensure => installed }
	 file { "/etc/puppet/puppet.conf":
                owner => "root",
                group => "root",
                mode => 0644,
                source => "puppet://$puppetserver/modules/reqfiles/etc/puppet/puppet.conf",
        }


	file { "/etc/hosts":
		owner => "root",
		group => "root",
		mode => 0440,
		source => "puppet://$puppetserver/modules/reqfiles/etc/hosts",
	}

	file { "/etc/sudoers":
                owner => "root",
                group => "root",
                mode => 0440,
                source => "puppet://$puppetserver/modules/reqfiles/etc/sudoers",
        }

	 file { "/etc/yum.repos.d/local.repo":
                owner => "root",
                group => "root",
                mode => 0440,
                source => "puppet://$puppetserver/modules/reqfiles/etc/yum.repos.d/local.repo",
        }
       service { "nrpe":
                ensure => running,
                hasstatus => true,
                enable => true,
                subscribe => [ Package["nrpe"]],
        }


}
