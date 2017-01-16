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
  $service_name           = $::jupyterhub::params::service_name,
  $jupyterhub_username    = $::jupyterhub::params::jupyterhub_username,
  $jupyterhub_group       = $::jupyterhub::params::jupyterhub_group,
  $jupyterhub_dir         = $::jupyterhub::params::jupyterhub_dir,
  $pyvenv                 = $::jupyterhub::params::pyvenv,
  $allowed_users          = $::jupyterhub::params::allowed_users,
  $port                   = $::jupyterhub::params::port,
  $oauth_callback_url     = $::jupyterhub::params::oauth_callback_url,
  $github_client_id       = $::jupyterhub::params::github_client_id,
  $github_client_secret   = $::jupyterhub::params::github_client_secret,
  $base_url               = $::jupyterhub::params::base_url,
  $has_nbviewer           = $::jupyterhub::params::has_nbviewer,
) inherits ::jupyterhub::params {

  # validate parameters here

  class { '::jupyterhub::install': } ->
  class { '::jupyterhub::config': } ~>
  class { '::jupyterhub::service': } ->
  Class['::jupyterhub']
}
