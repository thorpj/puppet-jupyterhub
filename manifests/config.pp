# == Class jupyterhub::config
#
# This class is called from jupyterhub for service config.
#
class jupyterhub::config {

  file { '/var/log/jupyterhub.log':
    ensure => present,
    owner  => $::jupyterhub::jupyterhub_username,
  }

  file { "${::jupyterhub::jupyterhub_dir}/jupyterhub_config.py":
    owner   => $::jupyterhub::jupyterhub_username,
    content => epp("${module_name}/jupyterhub_config.py.epp"),
  }

  if $::jupyterhub::sudospawner_enable {

    file { '/etc/sudoers.d/sudospawner':
      owner   => root,
      content => template("${module_name}/jupyterhub_sudoers.erb"),
    }
  }

  file { "${::jupyterhub::jupyterhub_dir}/start_jupyterhub.sh":
    owner   => $::jupyterhub::jupyterhub_username,
    mode    => '0755',
    content => template("${module_name}/start_jupyterhub.sh.erb"),
  }

  file { "/etc/systemd/system/${::jupyterhub::service_name}.service":
    owner   => 'root',
    content => template("${module_name}/jupyterhub.service.erb"),
  }
  #~>
  #Exec[ systemctl_daemon-reload ]
  }
