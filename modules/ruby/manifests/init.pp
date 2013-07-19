class ruby {
  include base

  line { rbenv-root:
    file => '/etc/environment',
    line => 'RBENV_ROOT=/usr/local/rbenv'
  }

  line { zsh-rbenv-path:
    require => Package[zsh],
    file => '/etc/zsh/zshenv',
    line => 'export PATH="/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"'
  }

  file { "/etc/profile.d/rbenv-path.sh":
    ensure => present,
    content => 'export PATH="/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"'
  }

  exec { install-ruby-build:
    command => 'git clone git://github.com/sstephenson/ruby-build.git /tmp/ruby-build && cd /tmp/ruby-build && sudo ./install.sh && rm -rf /tmp/ruby-build',
    creates => '/usr/local/bin/ruby-build',
  }

  exec { install-rbenv:
    command => 'sudo git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv',
    creates => '/usr/local/rbenv',
  }

  define version($global = false, $bundler = '1.2.3') {
    include ruby

    exec { "install-ruby-$name":
      environment => "RBENV_ROOT=/usr/local/rbenv",
      command => "/usr/local/rbenv/bin/rbenv install $name",
      creates => "/usr/local/rbenv/versions/$name",
      timeout => 0,
      require => Class[ruby]
    }

    exec { "install-bundler-for-$name":
      environment => ["RBENV_ROOT=/usr/local/rbenv", "RBENV_VERSION=$name"],
      path => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/rbenv/bin:/usr/local/rbenv/shims",
      command => "/usr/local/rbenv/shims/gem install bundler --no-ri --no-rdoc --version $bundler && /usr/local/rbenv/bin/rbenv rehash",
      unless => "/usr/local/rbenv/shims/gem list | grep 'bundler' | grep '$bundler'",
      require => Exec["install-ruby-$name"]
    }

    if $global {
      line { rbenv-global-env:
        file => "/etc/environment",
        line => "RBENV_VERSION=$name"
      }
    }
  }
}