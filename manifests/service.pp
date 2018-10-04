# == Class jupyterhub::service
#
# This class is meant to be called from jupyterhub.
# It ensure the service is running.
#
class jupyterhub::service {

  if $jupyterhub::service_manage == true {
    service { 'jupyterhub':
      ensure     => $jupyterhub::service_ensure,
      enable     => $jupyterhub::service_enable,
      name       => $jupyterhub::service_name,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
