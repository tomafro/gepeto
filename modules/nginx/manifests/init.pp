class nginx {
  package { nginx:
    ensure => present
  }

  service { nginx:
    ensure => running,
    require => Package[nginx]
  }

  file { "/etc/nginx/sites-available/default":
    ensure => absent
  }

  file { "/etc/nginx/sites-enabled/default":
    ensure => absent
  }

  ufw::allow-port {80:}
  ufw::allow-port {443:}

  define site($root) {
    include nginx

    host { "$name.localhost":
      ip => "127.0.0.1"
    }

    file { "/etc/nginx/sites-available/$name":
      content => template("nginx/static.erb"),
      notify => Service[nginx],
      require => Package[nginx]
    }

    file { "/etc/nginx/sites-enabled/$name":
      ensure => link,
      target => "/etc/nginx/sites-available/$name",
      notify => Service[nginx],
      require => Package[nginx]
    }
  }

  define rack($root) {
    include nginx

    file { "/etc/nginx/sites-available/$name":
      content => template("nginx/rack.erb"),
      notify => Service[nginx]
    }

    file { "/etc/nginx/sites-enabled/$name":
      ensure => link,
      target => "/etc/nginx/sites-available/$name",
      notify => Service[nginx]
    }
  }
}