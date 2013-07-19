class apt {
  exec { "apt-get update":}
  define ppa-repository($publisher, $repo) {
    exec { "add_repo_$name":
      command => "/usr/bin/add-apt-repository ppa:$publisher/$repo && /usr/bin/apt-get update",
      creates => "/etc/apt/sources.list.d/${publisher}-${repo}-${::lsbdistcodename}.list"
    }
  }
}
