# == Class jupyterhub::config
#
# This class is called from jupyterhub for service config.
#
class jupyterhub::config {


  file { "${::jupyterhub::jupyterhub_dir}/jupyterhub_config.py":
    owner   => $jupyterhub_username,
    content => "
c.JupyterHub.spawner_class='sudospawner.SudoSpawner'
c.SudoSpawner.sudospawner_path = '/opt/jupyterhub/pyvenv/bin/sudospawner'
",
  }


    file { '/etc/sudoers.d/sudospawner':
      content => template('jupyterhub_sudoers.erb'),
      require => Class[ profile::sudo ],
    }

    file { "${::jupyterhub::jupyterhub_dir}/start_jupyterhub.sh":
      owner   => '_jupyter',
      mode    => '0755',
      content => "#!/bin/bash
  . ${::jupyterhub::jupyterhub_dir}/pyvenv/bin/activate
  ${::jupyterhub::jupyterhub_dir}/pyvenv/bin/jupyterhub --config jupyterhub_config.py
  ",
    }


    file { "/etc/systemd/system/${::jupyterhub::service_name}.service":
      owner   => 'root',
      content => "
  [Unit]
  Description=Jupyterhub

  [Service]
  ExecStart=${::jupyterhub::jupyterhub_dir}/start_jupyterhub.sh
  WorkingDirectory=${::jupyterhub::jupyterhub_dir}/
  User=_jupyter

  [Install]
  WantedBy=multi-user.target
  ",
    } ~> Exec[ systemctl_daemon-reload ]

}
