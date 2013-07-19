class elastic-search {
  include java

  exec { "install-elastic-search":
    command => "wget https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.19.8.deb && dpkg -i elasticsearch-0.19.8.deb && rm elasticsearch-0.19.8.deb",
    unless => "dpkg --get-selections | grep '^elasticsearch\s*install'",
    require => Class[java]
  }
}