# == Class jupyterhub::install
#
# This class is called from jupyterhub for install.
#
class jupyterhub::install {

  package { $::jupyterhub::package_name:
    ensure => present,
  }

  package { 'python3-venv': }
  ->
  python::pyvenv { $jupyterhub_dir:
    ensure  => present,
    version => 'system',
    owner   => $jupyterhub_username,
  }


  python::pip { 'jupyter':
    pkgname    => 'jupyter',
    virtualenv => $jupyterhub_dir,
    owner      => $jupyterhub_username,
    require    => python::pyvenv[ $jupyterhub_dir ],
  }

  python::pip { 'jupyterhub':
    pkgname    => 'jupyterhub',
    virtualenv => $jupyterhub_dir,
    owner      => $jupyterhub_username,
    require    => python::pyvenv[ $jupyterhub_dir ],
  }


    python::pip { 'sudospawner':
      pkgname    => 'git+https://github.com/jupyter/sudospawner',
      virtualenv => $jupyterhub_dir,
      owner      => $jupyterhub_username,
      require    => python::pyvenv[ $jupyterhub_dir ],
    }

    package { ['npm', 'nodejs-legacy']: }
    ->
    exec { '/usr/bin/npm install -g configurable-http-proxy':
      unless => '/usr/bin/npm list -g configurable-http-proxy',
    }

}
