# == Class jupyterhub::config
#
# This class is called from jupyterhub for service config.
#
class jupyterhub::config inherits jupyterhub {

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
      content => epp("${module_name}/jupyterhub_sudoers.epp"),
    }
  }

  file { "${::jupyterhub::jupyterhub_dir}/start_jupyterhub.sh":
    owner   => $::jupyterhub::jupyterhub_username,
    mode    => '0755',
    content => epp("${module_name}/start_jupyterhub.sh.epp"),
  }

  case $::initsystem {
    'sysvinit': {
      file { "/etc/init.d/${::jupyterhub::service_name}":
        owner   => 'root',
        mode    => '0755',
        content => epp("${module_name}/jupyterhub.init.epp"),
      }
    }
    'systemd': {
      file { "/etc/systemd/system/${::jupyterhub::service_name}.service":
        owner   => 'root',
        content => epp("${module_name}/jupyterhub.service.epp"),
      }
    }
    default: {
      fail("No supported initsystem found for module ${module_name}")
    }
  }
}
