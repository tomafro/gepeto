define server($host) {
  case $::macaddress {
    $name: {
      class {hostname:
        hostname => $host,
        ip => $::ipaddress
      }
    }
  }
}

class hostname($hostname, $ip) {
  host { $hostname:
    ip => $::ipaddress
  }

  exec {'/bin/hostname -F /etc/hostname':}

  file {'/etc/hostname':
    content => $hostname,
    notify => Exec['/bin/hostname -F /etc/hostname']
  }
}

server { ['00:0c:29:a5:07:94', 'f2:3c:91:ae:0f:1a']:
  host => 'truffaut'
}