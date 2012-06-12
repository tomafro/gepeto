class ssh {
  package { "openssh-server":
    ensure => latest
  }

  service { ssh:
    ensure => running,
    require => Package["openssh-server"]
  }

  file {"/etc/ssh/ssh_known_hosts":
    content => template("ssh/ssh_known_hosts")
  }

  file {"/etc/ssh/sshd_config":
    content => template("ssh/sshd_config"),
    notify => Service[ssh]
  }

  ufw::allow {ssh:}
}