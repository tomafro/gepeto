node default {
  include base

  #include ruby, app

  #app::rack { blanche:
  #  owners => tomw
  #}
}

node subscribely inherits default {
  include ruby

  postgresql::database {"subscribely":}
  app::rack {'subscribely':}

  ruby::version { "1.9.3-p286":
    global => true
  }

  user { chrisroos:
    membership => minimum,
    groups => [admin, sudo],
    shell => "/bin/bash",
    require => Group[admin]
  }

  file { '/home/chrisroos':
    ensure => directory,
    owner => chrisroos,
    group => chrisroos,
    require => User[chrisroos]
  }

  ssh_authorized_key { 'chrisroos':
    ensure => present,
    user => 'chrisroos',
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA50zO1QYSl2lHaKyCshz0ph+H2t1SkUXPnDwn3Dn6ldQ6j46o+idhhN5+b8OnrmFXCAYhMDvaQnE/G6TpHal4x8Fq3W2ELkgkNDLQ5J8izphKHjsM+WyTrjskFViH4cNgpYkWrdUz3Yhxlx0EGqZZi57T/3Gf4hS/NspwYxhOWk5J+TptWAJQCI4sJR+Jw3TdTBqvkly8VX2dQYddPABnyDb0Ih8JEcXjngtGLsRi3N2DIq6YWvb2a3gYxpgkW7mgUOBFbOb9LMDmM2ILhYv5E8jhYbjsonH8f0NMxlWSQMIy2hoagm/SiRifyob3hA0HBqRDOJstwJkoEMkyv9z9aQ==",
    name => 'chris.roos@gofreerange.com',
    type => 'ssh-rsa',
    require => File['/home/chrisroos']
  }

  user { jamesmead:
    membership => minimum,
    groups => [admin, sudo],
    shell => "/bin/bash",
    require => Group[admin]
  }

  file { '/home/jamesmead':
    ensure => directory,
    owner => jamesmead,
    group => jamesmead,
    require => User[jamesmead]
  }

  ssh_authorized_key { 'jamesmead':
    ensure => present,
    user => 'jamesmead',
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA2sgFVWa22MUpTC3d7rn04qhzLRc5CwwuBLGp3dm3Yg5mFpq2dQLMlWZN/uK4SK1DC8fEDCbnaq4iGUk1VAUt6tN8UxrR9P5yrxSWTLLwanpNb/G6I4sRbzJaowhEchPLvoTWpege6hX6xGzHJRspODxT+Dhhrx8RIT5ZU19IlMEzSpYXNtBk5P+poj3AwC4gBwGhtC/B/YltM6Cxpi6Tp1Jb7vilRW08GU8EkmiBhs45QF2wWV2+OMinW7QIww7c6NdrbIDWw9+FBGOUHRlyPpXMCuz8B1zgplzoFLlO13r2fPDx2pB8WodMkZie28s1tfLB4gKIHVWbf9YYyLQeTQ==",
    name => 'james.mead@gofreerange.com',
    type => 'ssh-rsa',
    require => File['/home/jamesmead']
  }

  user { james:
    membership => minimum,
    groups => [admin, sudo],
    shell => "/bin/bash",
    require => Group[admin]
  }

  file { '/home/james':
    ensure => directory,
    owner => james,
    group => james,
    require => User[james]
  }

  ssh_authorized_key { 'jamesadam':
    ensure => present,
    user => 'james',
    key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDEKAO4Jw2N4OtwkPVlBbblf9nsIk7wLYLGFtEzDIcAlqwTMA87a6aYChXLMscwcP1mRduvoYhPP+QyTdbHlorlZ/AczuxEbjXbSroqaYA+b18T+dksQ05DXD8cVAytr8uKUBoT4Z31/zF9eF4mDYrecJpvgSkAySba0f6Gv9A5LQRItKVTY8pytzLZYYVtvRdsmq0OSTALweN7X5dp+oEjRlyyhCs6WhIqmUeSA90tVTwMVbZ4XFhq7zRqDvRjWA5nwFOaFVx/II/G51ik3E5n1bLMPxpiwgnHzmaZcPEhZKylyKYuLi061SoNb2+Fwiz19Ifp1MVDfKpf/AROGx1V==",
    name => 'james.adam@gofreerange.com',
    type => 'ssh-rsa',
    require => File['/home/james']
  }


  ssh_authorized_key { 'mauricio':
    ensure => present,
    user => 'mauricio',
    key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCrbb4IoP48CWmOb8YdEjE6ESSfb+gVX0rTSmOtAR3DYMPEE8cDAQT8VnLEgpdXVBU8iDNedw3UHCf937rAExESfZ0pFNn0uVyZaO6j9N6OEx0vZ2Bsz2/R6fvX0STJELEBoYmwmF1VRnlpCeCdLxcvwgj00qpNuC2lAvpo9ikjaTBZs0EdfG9ED7IVfhOtvzChj8Q6hd8He/wxzIcTg1HO0bRzxjp4LpdjHFCEliTHc/i1CnCHE+9E1kW1PRDOM52J4Ydf7FsQdsJh4/E/qAQ68vgfcpltqGmVGybtpNlG7JJ6ewljLgQNnSvUh0qrGJ5GqAkC81A7iYI3EnbNy4IJ",
    name => 'GitHub@mauriciosalazar',
    type => 'ssh-rsa'
  }
}

node truffaut inherits default {
  app::site {'tomafro.net':}
  app::clojure {'tomaf.ro':}

  include ruby

  ruby::version { "1.9.3-p286":
    global => true
  }

  postgresql::database {"scurt":}
}

node chabrol inherits default {
  include fonts
  include phantomjs
}

node godard inherits default {
  ruby::version { "1.9.3-p194":
    global => true
  }

  include java
  include elastic-search
  include postgresql
  postgresql::database {"treeline":}
  package {"nodejs":
    ensure => present
  }
}

