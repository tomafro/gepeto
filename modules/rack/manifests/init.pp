class rack {
  include app
  include nginx

  define app($owners = []) {
    include nginx

    app::base { $name:
      owners => $owners
    }

    nginx::rack { $name:
      root => "/home/$name/apps/$name"
    }

    unicorn::rails { $name:
      root => "/home/$name/apps/$name" 
    }
  }
}
