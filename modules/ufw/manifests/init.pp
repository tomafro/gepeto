class ufw {
  package { ["ufw"]:
    ensure => latest
  }

  exec { "enable-firewall":
    command => "/usr/sbin/ufw --force enable",
    unless => "/usr/sbin/ufw status | grep \"Status: active\"",
    require => [Package["ufw"]]
  }

  define allow-port {
    include ufw

    exec { "allow-port-$name":
      command => "/usr/sbin/ufw allow ${name}",
      unless => "/usr/sbin/ufw status | grep \"${name}.*ALLOW.*Anywhere\"",
      require => [Class["ufw"]]
    }
  }
}