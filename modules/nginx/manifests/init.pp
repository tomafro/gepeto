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

  ufw::allow {http:}
  ufw::allow {https:}

  define site($root) {
    include nginx

    file { "/etc/nginx/sites-available/$name":
      content => template("nginx/static.erb"),
      notify => Service[nginx]
    }

    file { "/etc/nginx/sites-enabled/$name":
      ensure => link,
      target => "/etc/nginx/sites-available/$name",
      notify => Service[nginx]
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