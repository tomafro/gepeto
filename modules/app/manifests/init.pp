class app {
  group { app:
    ensure => present
  }

  define base($owners = []) {
    include app

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

    file { '/home/$name':
      ensure => directory,
      owner => $name,
      group => $name,
      require => User[$name]
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
      root => "/home/$name/app/public"
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

  define clojure($owners = []) {
    include nginx, java, clojure
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
