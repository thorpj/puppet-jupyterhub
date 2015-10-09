# == Class jupyterhub::params
#
# This class is meant to be called from jupyterhub.
# It sets variables according to platform.
#
class jupyterhub::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'jupyterhub'
      $service_name = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef,
    }
    'RedHat', 'Amazon': {
      $package_name = 'jupyterhub'
      $service_name = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef,
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
