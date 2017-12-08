# == Class jupyterhub::service
#
# This class is meant to be called from jupyterhub.
# It ensure the service is running.
#
class jupyterhub::service inherits jupyterhub {

  if $jupyterhub::service_manage == true {
    service { $jupyterhub::service_name:
      ensure     => $jupyterhub::service_ensure,
      enable     => $jupyterhub::service_enable,
      hasrestart => true,
    }
  }
}
