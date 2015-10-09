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
  $package_name = $::jupyterhub::params::package_name,
  $service_name = $::jupyterhub::params::service_name,
) inherits ::jupyterhub::params {

  # validate parameters here

  class { '::jupyterhub::install': } ->
  class { '::jupyterhub::config': } ~>
  class { '::jupyterhub::service': } ->
  Class['::jupyterhub']
}
