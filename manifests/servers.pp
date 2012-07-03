define server($ip) {
  host { $name:
    ip => $ip
  }

  case $::ipaddress {
    $ip: {
      class {hostname:
        hostname => $name,
        ip => $ip
      }
    }
  }
}

class hostname($hostname, $ip) {
  exec {'/bin/hostname -F /etc/hostname':}

  file {'/etc/hostname':
    content => $hostname,
    notify => Exec['/bin/hostname -F /etc/hostname']
  }
}

server { truffaut:
  ip => '172.16.220.145'
}