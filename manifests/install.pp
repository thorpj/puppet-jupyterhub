# == Class jupyterhub::install
#
# This class is called from jupyterhub for install.
#
class jupyterhub::install {

  ensure_packages(['python3-venv', 'npm', 'nodejs-legacy'])

  user { "${::jupyterhub::jupyterhub_username}":
    ensure => present,
  }
  ~>
  file { $::jupyterhub::jupyterhub_dir:
    ensure => directory,
    owner   => $::jupyterhub::jupyterhub_username,
  }
  ->
  python::pyvenv { $::jupyterhub::pyvenv:
    ensure  => present,
    version => 'system',
    owner   => $::jupyterhub::jupyterhub_username,
    group   => $::jupyterhub::jupyterhub_group,
    require => Package['python3-venv'],
  }

  python::pip { 'jupyter':
    pkgname    => 'jupyter',
    virtualenv => "$::jupyterhub::pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
  }

  python::pip { 'jupyterhub':
    pkgname    => 'jupyterhub',
    virtualenv => "$::jupyterhub::pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
  }

  python::pip { 'oauthenticator':
    pkgname    => 'oauthenticator',
    virtualenv => "$::jupyterhub::pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
  }

  python::pip { 'sudospawner':
    pkgname    => 'git+https://github.com/jupyter/sudospawner',
    virtualenv => "$::jupyterhub::pyvenv",
    owner      => $::jupyterhub::jupyterhub_username,
    require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
  }

  exec { '/usr/bin/npm install -g configurable-http-proxy':
    unless => '/usr/bin/npm list -g configurable-http-proxy',
    require => [Package['npm'], Package['nodejs-legacy']],
  }

  if $::jupyterhub::nbviewer_files {
    class { '::jupyterhub::nbviewer': }
  }
}
