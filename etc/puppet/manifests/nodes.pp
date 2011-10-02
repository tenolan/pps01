node "s01.n4.local" {
	include reqfiles
	include activemq
        }

node "s03.n4.local" {
        include reqfiles
        include activemq
	include nagios::target
        }
node "s04.n4.local" {
        include nagios
	include nagios::target
        }
