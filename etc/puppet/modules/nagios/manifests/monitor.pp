class nagios::monitor {
	package { [ "nagios", "nagios-plugins" ]: ensure => installed }

	service { "nagios":
		ensure => running,
		hasstatus => true,
		enable => true,
		subscribe => [ Package["nagios"], Package["nagios-plugins"] ],
	}

	Nagios_host <<||>> { notify => Service["nagios"] }
	Nagios_service <<||>> { notify => Service["nagios"] }
}
