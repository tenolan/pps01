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

	 file { "/etc/yum.repos.d/local.repo":
                owner => "root",
                group => "root",
                mode => 0440,
                source => "puppet://$puppetserver/modules/reqfiles/etc/yum.repos.d/local.repo",
        }


}

