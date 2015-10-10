# == Class jupyterhub::params
#
# This class is meant to be called from jupyterhub.
# It sets variables according to platform.
#
class jupyterhub::params {
  case $::osfamily {
    'Debian': {
      $service_name           = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub'
      $allowed_users          = undef
    }
    'RedHat', 'Amazon': {
      $service_name           = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub'
      $allowed_users          = undef
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
