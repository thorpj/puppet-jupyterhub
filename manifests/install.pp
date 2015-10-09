# == Class jupyterhub::install
#
# This class is called from jupyterhub for install.
#
class jupyterhub::install {

  package { $::jupyterhub::package_name:
    ensure => present,
  }
}
