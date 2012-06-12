node default {
  include base, ssh

  #include ruby, app

  #app::rack { blanche:
  #  owners => tomw
  #}

  #ruby::version { "1.9.3-p0":
  #  global => true
  #}

  host { truffaut:
    ip => '109.74.205.178'
  }

  case $ipaddress {
    '109.74.205.178': {
      exec {'hostname -F /etc/hostname':}

      file {'/etc/hostname':
        content => 'truffaut',
        notify => Exec['hostname -F /etc/hostname']
      }

      nginx::site { 'tomafro.net':
        root => '/home/tomafro.net/apps/tomafro.net/public'
      }

      nginx::site { 'tom.tomafro.net':
        root => '/home/tom.tomafro.net/apps/tom.tomafro.net/public'
      }
    }
  }
}
