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
    }
    'RedHat', 'Amazon': {
      $package_name = 'jupyterhub'
      $service_name = 'jupyterhub'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
