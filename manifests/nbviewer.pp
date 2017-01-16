class jupyterhub::nbviewer {
    ensure_packages(['libmemcached-dev', 'libcurl4-openssl-dev', 'pandoc',
                     'libevent-dev'])
    $python_version = hiera('python::version')
    $nbviewer_path = "${$::jupyterhub::pyvenv}/src/nbviewer"

    python::pip { 'nbviewer':
      pkgname    => 'git+https://github.com/jupyter/nbviewer',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    } ~>
    exec { 'nbviewer-npm-install':
      command     => '/usr/bin/npm install',
      timeout     => 900,  # 15 minutes
      cwd         => $nbviewer_path,
      refreshonly => true,
      require     => [Package['npm'], Package['nodejs-legacy']],
    } ~>
    exec { 'invoke bower':
      path        => "${$::jupyterhub::pyvenv}/bin:/usr/bin",
      cwd         => $nbviewer_path,
      refreshonly => true,
      require     => Python::Pip['invoke'],
    } ~>
    exec { 'invoke less':
      path        => "${$::jupyterhub::pyvenv}/bin:/usr/bin",
      cwd         => $nbviewer_path,
      refreshonly => true,
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
}