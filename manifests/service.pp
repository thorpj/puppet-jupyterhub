# == Class jupyterhub::service
#
# This class is meant to be called from jupyterhub.
# It ensure the service is running.
#
class jupyterhub::service {

  service { $::jupyterhub::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
