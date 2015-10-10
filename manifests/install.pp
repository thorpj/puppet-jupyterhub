# == Class jupyterhub::install
#
# This class is called from jupyterhub for install.
#
class jupyterhub::install {

  package { 'python3-venv': }
  ->
  python::pyvenv { "$::jupyterhub::jupyterhub_dir/pyvenv":
    ensure  => present,
    version => 'system',
    owner   => $::jupyterhub::jupyterhub_username,
  }

  python::pip { 'jupyter':
    pkgname    => 'jupyter',
    virtualenv => "$::jupyterhub::jupyterhub_dir/pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::jupyterhub_dir ],
  }

  python::pip { 'jupyterhub':
    pkgname    => 'jupyterhub',
    virtualenv => "$::jupyterhub::jupyterhub_dir/pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::jupyterhub_dir ],
  }

  python::pip { 'sudospawner':
    pkgname    => 'git+https://github.com/jupyter/sudospawner',
    virtualenv => "$::jupyterhub::jupyterhub_dir/pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::jupyterhub_dir ],
  }

  package { ['npm', 'nodejs-legacy']: }
  ->
  exec { '/usr/bin/npm install -g configurable-http-proxy':
    unless => '/usr/bin/npm list -g configurable-http-proxy',
  }
}
