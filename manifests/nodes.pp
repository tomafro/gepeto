node default {
  include base

  #include ruby, app

  #app::rack { blanche:
  #  owners => tomw
  #}

  #ruby::version { "1.9.3-p0":
  #  global => true
  #}
}

node truffaut inherits default {
  app::site {'tomafro.net':}
}
