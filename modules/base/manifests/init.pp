class base {
  include ssh

  package { [unattended-upgrades, zsh, build-essential, git-core, curl, libc6-dev, libssl-dev, libreadline6-dev, zlib1g-dev, python-software-properties]:
    ensure => present
  }

  group { admin:
    ensure => present
  }

  user { tomw:
    membership => minimum,
    groups => [admin, sudo],
    shell => "/usr/bin/zsh",
    require => Group[admin]
  }

  file { '/home/tomw':
    ensure => directory,
    owner => tomw,
    group => tomw,
    require => User[tomw]
  }

  file { '/srv/puppet':
    group => admin,
    mode => 770,
    recurse => true,
    require => Group[admin]
  }

  file { '/home/tomw/.zshrc':
    ensure => present,
    require => File['/home/tomw']
  }

  ssh_authorized_key { $name:
    ensure => present,
    user => 'tomw',
    key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA7wy/hGcJZ1PFRCjs0UKIrALs+zm0d2+fVtHJqCdWTOOOaP3NRUEsi5Eb60vzuTkgEilcOhIT9jMUMCUzKHbqlG6EMhXFOsyaNDV30oyj9pHYeqUDCY52vb9GXTejFEFAy4bnlG+5N//B8nXiGuOjTWJdXuDhhvFSO1Cqp9doDQLfgnfP8pUmquVHYVN7aOIjIMlmnhXedLOAWhmfNaaA6IrbsqEqRAqe+YqRtB25Kqh4UCd8Fjd7dh98W32TrLtlh8qtb8e7U3W+lskpnbDubcptQKAdzbKDFpdpPQKGMtrCnPx3rnddZWH2dV36smm+IwwUbrjH3U/1F2ci8aCgFQ==",
    name => 'tom@popdog.net',
    type => 'ssh-rsa',
    require => File['/home/tomw']
  }

  file { '/etc/timezone':
    ensure => link,
    target => '/usr/share/zoneinfo/UTC',
  }

  file { '/etc/sudoers.d/tomw-no-password':,
    ensure => present,
    content => "tomw ALL=(ALL) NOPASSWD: ALL",
    mode => 440
  }
}