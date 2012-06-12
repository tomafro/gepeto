class ssh {
  package { "open-ssh":
    ensure => latest
  }

  service { ssh:
    ensure => running,
    require => Package["open-ssh"]
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