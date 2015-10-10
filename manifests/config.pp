# == Class jupyterhub::config
#
# This class is called from jupyterhub for service config.
#
class jupyterhub::config {

  file { "${::jupyterhub::jupyterhub_dir}/jupyterhub_config.py":
    owner   => $::jupyterhub::jupyterhub_username,
    content => template('jupyterhub_config.py.erb'),
  }

  file { '/etc/sudoers.d/sudospawner':
    owner   => $::jupyterhub::jupyterhub_username,
    content => template('jupyterhub_sudoers.erb'),
    require => Class[ profile::sudo ],
  }

  file { "${::jupyterhub::jupyterhub_dir}/start_jupyterhub.sh":
    owner   => $::jupyterhub::jupyterhub_username,
    mode    => '0755',
    content => template('start_jupyterhub.sh.erb'),
  }

  file { "/etc/systemd/system/${::jupyterhub::service_name}.service":
    owner   => 'root',
    content => template('jupyterhub.service.erb'),
  }
  ~>
  Exec[ systemctl_daemon-reload ]
}
