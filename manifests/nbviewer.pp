class jupyterhub::nbviewer {
    ensure_packages(['libmemcached-dev', 'libcurl4-openssl-dev', 'pandoc',
                     'libevent-dev'])

    $nbviewer_path = "${::jupyterhub::dir}/nbviewer"

    vcsrepo { $nbviewer_path:
      ensure   => latest,
      revision => master,
      provider => git,
      source   => 'https://github.com/jupyter/nbviewer.git',
    }

    python::requirements { "$nbviewer_path/requirements.txt":
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    }

    python::requirements { "$nbviewer_path/requirements-dev.txt":
      virtualenv => "$::jupyterhub::pyvenv",
      owner      => $::jupyterhub::jupyterhub_username,
      require    => Python::Pyvenv[ $::jupyterhub::pyvenv ],
    } ~>
    exec { 'nbviewer-npm-install':
      command     => 'npm install -g',
      timeout     => 900,  # 15 minutes
      path        => $nbviewer_path,
      refreshonly => true,
      subscribe   => Vcsrepo[$nbviewer_path],
    } ~>
    exec { 'invoke bower':
      path        => $nbviewer_path,
      refreshonly => true,
    } ~>
    exec { 'invoke less':
      path        => $nbviewer_path,
      refreshonly => true,
    }
}