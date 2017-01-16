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
    python::requirements { "$nbviewer_path/requirements.txt":
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
    }# ~>
    #python::requirements { "$nbviewer_path/requirements-dev.txt":
    #  virtualenv => "$::jupyterhub::pyvenv",
    #  owner      => $::jupyterhub::jupyterhub_username,
    #} ~>
    #exec { 'nbviewer-npm-install':
    #  command     => 'npm install -g',
    #  timeout     => 900,  # 15 minutes
    #  path        => $nbviewer_path,
    #  refreshonly => true,
    #} ~>
    #exec { 'invoke bower':
    #  path        => $nbviewer_path,
    #  refreshonly => true,
    #} ~>
    #exec { 'invoke less':
    #  path        => $nbviewer_path,
    #  refreshonly => true,
    #}
}