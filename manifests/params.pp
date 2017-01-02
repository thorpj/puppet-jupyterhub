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
      $pyvenv                 = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef
      $port                   = 7000
      $oauth_callback_url     = undef
      $github_client_id       = undef
      $github_client_secret   = undef
      $base_url               = '/'
    }
    'RedHat', 'Amazon': {
      $service_name           = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub'
      $pyvenv                 = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef
      $port                   = 7000
      $oauth_callback_url     = undef
      $github_client_id       = undef
      $github_client_secret   = undef
      $base_url               = '/'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
