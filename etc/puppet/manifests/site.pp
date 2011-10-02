# site.pp
import 'nodes.pp'
$puppetserver = 'pps01.n4.local'
filebucket { main: server => "pps01.n4.local" }
# defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }
