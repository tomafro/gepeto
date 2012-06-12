class app {
  group { app:
    ensure => present
  }

  define base($owners = []) {
    app::owner {$owners:
      app => $name
    }

    user {$name:
      groups => [app],
      membership => minimum,
      require => [Group[app]],
      home => "/home/$name",
      shell => "/usr/bin/zsh"
    }

    file{ "/etc/sudoers.d/$name":
      content => template("app/sudoers.erb"),
      mode => 440
    }
  }

  define site($owners = []) {
    include nginx

    base { $name:
      owners => $owners
    }

    nginx::site { $name:
      root => "/home/$name/site"
    }
  }

  define rack($owners = []) {
    include nginx

    base { $name:
      owners => $owners
    }

    nginx::rack { $name:
      root => "/home/$name/apps/$name"
    }
  }

  define owner($app) {
    user {"$app-$name":
      name => $name,
      groups => $app,
      membership => minimum,
      require => [User[$name], User[$app]]
    }
  }
}
