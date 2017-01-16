class jupyterhub::nbviewer {
    ensure_packages(['libmemcached-dev', 'libcurl4-openssl-dev', 'pandoc',
                     'libevent-dev'])
    $python_version = hiera('python::version')
    $nbviewer_src = "${$::jupyterhub::pyvenv}/src/nbviewer"
    $nbviewer_lib = "${$::jupyterhub::pyvenv}/lib/python$python_version/site-packages/nbviewer"

    python::pip { 'nbviewer':
      pkgname    => 'git+https://github.com/jupyter/nbviewer',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    } ~>
    exec { 'nbviewer-npm-install':
      command     => '/usr/bin/npm install',
      timeout     => 900,  # 15 minutes
      cwd         => $nbviewer_src,
      refreshonly => true,
      require     => [Package['npm'], Package['nodejs-legacy']],
    } ~>
    # we need to provide a dummy stdin so that invoke doesn't choke badly
    exec { 'echo "bower" | invoke -p bower':
      path        => "${$::jupyterhub::pyvenv}/bin:/usr/bin",
      cwd         => $nbviewer_src,
      refreshonly => true,
      provider    => shell,
      require     => Python::Pip['invoke'],
    } ~>
    exec { 'echo "less" | invoke -p less':
      path        => "${$::jupyterhub::pyvenv}/bin:/usr/bin",
      cwd         => $nbviewer_src,
      refreshonly => true,
      provider    => shell,
      require     => Python::Pip['pip-9.0.1'],
    } ~>
    file { "$nbviewer_lib/static/build":
      ensure => directory,
      source => "$nbviewer_src/nbviewer/static/build",
    } ~>
    file { "$nbviewer_lib/static/components":
      ensure => directory,
      source => "$nbviewer_src/nbviewer/static/components",
    }

    python::pip { 'markdown':
      pkgname    => 'markdown',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    }

    python::pip { 'statsd':
      pkgname    => 'statsd',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    }

    python::pip { 'invoke':
      pkgname    => 'invoke',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    }

    python::pip { 'pip-9.0.1':
      pkgname    => 'pip',
      ensure     => '9.0.1',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    }
}