class fonts {
  exec { "accept-msttcorefonts-license":
    command => "/bin/sh -c \"echo ttf-mscorefonts-installer msttcorefonts/accepted-     mscorefonts-eula select true | debconf-set-selections\""
  }

  package { "msttcorefonts":
    ensure => installed,
    require => Exec['accept-msttcorefonts-license']
  }

  package { ["libfreetype6", "libfreetype6-dev", "fontconfig", "imagemagick"]:
    ensure => installed
  }
}