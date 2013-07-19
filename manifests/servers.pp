define server($host) {
  case $::ipaddress {
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

server { ['172.16.220.145', '176.58.114.53']:
  host => 'truffaut'
}

server { ['172.16.220.141']:
  host => 'godard'
}

server { ['172.16.220.148']:
  host => 'chabrol'
}

server { ['178.79.154.142']:
  host => 'subscribely'
}