# == Class jupyterhub::install
#
# This class is called from jupyterhub for install.
#
class jupyterhub::install inherits jupyterhub {
  class { '::nodejs':
    repo_url_suffix => '6.x',
  }
  case $facts['os']['family'] {
    'Debian': { ensure_packages(['git','python3-venv'], { before =>  Python::Pyvenv[$::jupyterhub::pyvenv]}) }
    'RedHat': { ensure_packages(['git','python34'],  {
      require => Class['::epel'],
      before  => Python::Pyvenv[$::jupyterhub::pyvenv]})
    }
    default: { ensure_packages(['python34'],  { before =>  Python::Pyvenv[$::jupyterhub::pyvenv]}) }
  }

  user { $::jupyterhub::jupyterhub_username:
    ensure => present,
  }

  ~> file { $::jupyterhub::jupyterhub_dir:
    ensure => directory,
    owner  => $::jupyterhub::jupyterhub_username,
  }

  -> python::pyvenv { $::jupyterhub::pyvenv:
    ensure  => present,
    version => 'system',
    owner   => $::jupyterhub::jupyterhub_username,
    group   => $::jupyterhub::jupyterhub_group,
    #require => Package['python3-venv'],
    }

    python::pip { 'jupyter':
      pkgname    => 'jupyter',
      virtualenv => $::jupyterhub::pyvenv,
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[$::jupyterhub::pyvenv],
    }

    python::pip { 'jupyterhub':
      pkgname    => 'jupyterhub',
      virtualenv => $::jupyterhub::pyvenv,
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[$::jupyterhub::pyvenv],
    }

    python::pip { 'oauthenticator':
      pkgname    => 'oauthenticator',
      virtualenv => $::jupyterhub::pyvenv,
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[$::jupyterhub::pyvenv],
    }

    if $::jupyterhub::sudospawner_enable {

      python::pip { 'sudospawner':
        pkgname    => 'git+https://github.com/jupyterhub/sudospawner',
        virtualenv => $::jupyterhub::pyvenv,
        owner      => $::jupyterhub::jupyterhub_username,
        require    => Python::Pyvenv[$::jupyterhub::pyvenv],
      }
    }

    if $::jupyterhub::systemdspawner_enable {

      python::pip { 'systemdspawner':
        pkgname    => 'git+https://github.com/jupyterhub/systemdspawner',
        virtualenv => $::jupyterhub::pyvenv,
        owner      => $::jupyterhub::jupyterhub_username,
        require    => Python::Pyvenv[$::jupyterhub::pyvenv],
      }
    }

    package { 'configurable-http-proxy':
      ensure   => 'present',
      provider => 'npm',
      require  =>  Class['::nodejs'],
    }
}
