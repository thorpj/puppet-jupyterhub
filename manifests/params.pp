# == Class jupyterhub::params
#
# This class is meant to be called from jupyterhub.
# It sets variables according to platform.
#
class jupyterhub::params {
  case $::osfamily {
    'Debian': {
      $service_name                    = 'jupyterhub'
      $jupyterhub_username             = '_jupyter'
      $jupyterhub_group                = 'jupyter'
      $jupyterhub_dir                  = '/opt/jupyterhub'
      $pyvenv                          = '/opt/jupyterhub/pyvenv'
      $allowed_users                   = undef
      $port                            = 7000
      $oauth_callback_url              = undef
      $oauth_client_id                 = undef
      $oauth_client_secret             = undef
      $oauth_create_system_users       = false
      $oauth_github_enable             = false
      $oauth::github_client_id         = undef
      $oauth::github_client_secret     = undef
      $base_url                        = '/'
      $sudospawner_enable              = true
      $systemdspawner_enable           = false
      $systemdspawner::user_workingdir = '/home/{USERNAME}'
      $systemdspawner::default_shell   = undef
      $systemdspawner::mem_limit       = 'None'
      $systemdspawner::cpu_limit       = 'None'
      $systemdspawner::isolate_tmp     = false
      $systemdspawner::isolate_devices = false
    }
    'RedHat', 'Amazon': {
      $service_name                    = 'jupyterhub'
      $jupyterhub_username             = '_jupyter'
      $jupyterhub_group                = 'jupyter'
      $jupyterhub_dir                  = '/opt/jupyterhub'
      $pyvenv                          = '/opt/jupyterhub/pyvenv'
      $allowed_users                   = undef
      $port                            = 7000
      $oauth_callback_url              = undef
      $oauth_client_id                 = undef
      $oauth_client_secret             = undef
      $oauth_create_system_users       = false
      $oauth_github_enable             = false
      $oauth::github_client_id         = undef
      $oauth::github_client_secret     = undef
      $base_url                        = '/'
      $sudospawner_enable              = true
      $systemdspawner_enable           = false
      $systemdspawner::user_workingdir = '/home/{USERNAME}'
      $systemdspawner::default_shell   = undef
      $systemdspawner::mem_limit       = 'None'
      $systemdspawner::cpu_limit       = 'None'
      $systemdspawner::isolate_tmp     = false
      $systemdspawner::isolate_devices = false
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
