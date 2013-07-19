class postgresql {
  package { ["postgresql-9.1", "postgresql-client-9.1", "postgresql-server-dev-9.1"]:
    ensure => present
  }

  define database {
    include postgresql

    exec { "create-owner-$name":
      require => Class[postgresql],
      command => "psql -c \"CREATE ROLE $name WITH LOGIN CREATEDB PASSWORD '$name'\"",
      unless => "psql -c '\\du' | grep '^ $name'",
      user => postgres
    }
  }
}