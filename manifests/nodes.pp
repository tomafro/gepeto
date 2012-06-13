node default {
  include base, ssh

  #include ruby, app

  #app::rack { blanche:
  #  owners => tomw
  #}

  #ruby::version { "1.9.3-p0":
  #  global => true
  #}
}

node truffaut inherits default {
  nginx::site { 'tomafro.net':
    root => '/home/tomafro.net/apps/tomafro.net/public'
  }
}
