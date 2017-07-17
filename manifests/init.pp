# Class: jupyterhub
# ===========================
#
# Full description of class jupyterhub here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class jupyterhub (
  $service_name                    = $::jupyterhub::params::service_name,
  $jupyterhub_username             = $::jupyterhub::params::jupyterhub_username,
  $jupyterhub_group                = $::jupyterhub::params::jupyterhub_group,
  $jupyterhub_dir                  = $::jupyterhub::params::jupyterhub_dir,
  $pyvenv                          = $::jupyterhub::params::pyvenv,
  $allowed_users                   = $::jupyterhub::params::allowed_users,
  $port                            = $::jupyterhub::params::port,
  $oauth_callback_url              = $::jupyterhub::params::oauth_callback_url,
  $oauth_github_enable             = $::jupyterhub::params::oauth_github_enable,
  $oauth_github_client_id          = $::jupyterhub::params::oauth_github_client_id,
  $oauth_github_client_secret      = $::jupyterhub::params::oauth_github_client_secret,
  $base_url                        = $::jupyterhub::params::base_url,
  $sudospawner_enable              = $::jupyterhub::params::sudospawner_enable,
  $systemdspawner_enable           = $::jupyterhub::params::systemdpawner_enable,
  $systemdspawner_user_workingdir  = $::jupyterhub::params::systemdspawner_user_workingdir,
  $systemdspawner_default_shell    = $::jupyterhub::params::systemdspawner_default_shell,
  $systemdspawner_mem_limit        = $::jupyterhub::params::systemdspawner_mem_limit,
  $systemdspawner_cpu_limit        = $::jupyterhub::params::systemdspawner_cpu_limit,
  $systemdspawner_isolate_tmp      = $::jupyterhub::params::systemdspawner_isolate_tmp,
  $systemdspawner_isolate_devices  = $::jupyterhub::params::systemdspawner_isolate_devices,

) inherits ::jupyterhub::params {

  # validate parameters here

  class { '::jupyterhub::install': }
  -> class { '::jupyterhub::config': }
  ~> class { '::jupyterhub::service': }
  -> Class['::jupyterhub']
}
