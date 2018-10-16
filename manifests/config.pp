# == Class jupyterhub::config
#
# This class is called from jupyterhub for service config.
#
class jupyterhub::config {

  file { '/var/log/jupyterhub.log':
    ensure => file,
    owner  => $jupyterhub::jupyterhub_username,
  }

  file { "${jupyterhub::config_dir}/jupyterhub_config.py":
    ensure  => file,
    owner   => $jupyterhub::jupyterhub_username,
    content => epp("${module_name}/jupyterhub_config.py.epp"),
    require => File[$jupyterhub::config_dir],
  }

  if $jupyterhub::sudospawner_enable {

    file { '/etc/sudoers.d/jupyterhub_sudospawner':
      ensure  => file,
      owner   => root,
      content => epp("${module_name}/jupyterhub_sudoers.epp"),
    }
  }

  file { "${jupyterhub::jupyterhub_dir}/start_jupyterhub.sh":
    ensure  => file,
    owner   => $jupyterhub::jupyterhub_username,
    mode    => '0755',
    content => epp("${module_name}/start_jupyterhub.sh.epp"),
  }

  case $::initsystem {
    'sysvinit': {
      file { "/etc/init.d/${jupyterhub::service_name}":
        ensure  => file,
        owner   => 'root',
        mode    => '0755',
        content => epp("${module_name}/jupyterhub.init.epp"),
      }
    }
    'systemd': {
      file { "/etc/systemd/system/${jupyterhub::service_name}.service":
        ensure  => file,
        owner   => 'root',
        content => epp("${module_name}/jupyterhub.service.epp"),
      }
    }
    default: {
      fail("No supported initsystem found for module ${module_name}")
    }
  }
}
