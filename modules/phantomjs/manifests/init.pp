class phantomjs($version = "1.8.1" ) {
    $filename = "phantomjs-${version}-linux-x86_64.tar.bz2"
    $phantom_src_path = "/usr/local/src/phantomjs-${version}/"
    $phantom_bin_path = "/opt/phantomjs-${version}-linux-x86_64"

    file { $phantom_src_path : ensure => directory }

    exec { "download-${filename}" :
        command => "wget http://phantomjs.googlecode.com/files/${filename} -O ${filename}",
        cwd => $phantom_src_path,
        creates => "${phantom_src_path}${filename}",
        require => File[$phantom_src_path]
    }

    exec { "extract-${filename}" :
        command => "tar xjvf ${filename} -C /opt/",
        creates => "/opt/phantomjs-${version}-linux-x86_64/",
        cwd => $phantom_src_path,
        require => Exec["download-${filename}"],
    }

    file { "/usr/local/bin/phantomjs" :
        target => "${phantom_bin_path}/bin/phantomjs",
        ensure => link,
        require     => Exec["extract-${filename}"],
    }

    file { "/usr/bin/phantomjs" :
        target => "${phantom_bin_path}/bin/phantomjs",
        ensure => link,
        require     => Exec["extract-${filename}"],
    }
}