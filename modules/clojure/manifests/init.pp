class clojure {
  include java

  exec { "download-leiningen":
    command => "/usr/bin/wget -O /usr/local/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein && chmod +x /usr/local/bin/lein",
    creates => "/usr/local/bin/lein"
  }
}
