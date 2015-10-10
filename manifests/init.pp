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
  $jupyterhub_dir         = $::jupyterhub::params::jupyterhub_dir,
  $allowed_users          = $::jupyterhub::params::allowed_users,
) inherits ::jupyterhub::params {

  # validate parameters here

  class { '::jupyterhub::install': } ->
  class { '::jupyterhub::config': } ~>
  class { '::jupyterhub::service': } ->
  Class['::jupyterhub']
}
