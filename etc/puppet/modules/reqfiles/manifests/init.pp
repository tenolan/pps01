class reqfiles {
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

}

