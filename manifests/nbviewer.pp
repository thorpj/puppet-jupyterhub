class jupyterhub::nbviewer {
    ensure_packages(['libmemcached-dev', 'libcurl4-openssl-dev', 'pandoc',
                     'libevent-dev'])
    $python_version = hiera('python::version')
    $nbviewer_path = "${$::jupyterhub::pyvenv}/lib/python$python_version/site-packages/nbviewer"

    python::pip { 'nbviewer':
      pkgname    => 'git+https://github.com/jupyter/nbviewer',
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    } ~>
    exec { 'nbviewer-npm-install':
      command     => 'npm install -g',
      timeout     => 900,  # 15 minutes
      path        => $nbviewer_path,
      refreshonly => true,
    } ~>
    exec { 'invoke bower':
      path        => $nbviewer_path,
      refreshonly => true,
      require     => Python::Pip['invoke'],
    } ~>
    exec { 'invoke less':
      path        => $nbviewer_path,
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