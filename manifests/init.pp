# Class: jupyterhub
# ===========================
#
# Full description of class jupyterhub here.
#
# Parameters
# ----------
#
# @param service_name [String] Set name of the Jupyterhub service.
# @param jupyterhub_username [String] Set username
# @param jupyterhub_group [String] Set group
# @param Stdlib::Absolutepath $jupyterhub_dir,
# @param Stdlib::Absolutepath $pyvenv,
# @param Optional[String] $allowed_users,
# @param Integer $port,
# @param Optional[String] $oauth_callback_url,
# @param Optional[Boolean] $oauth_github_enable,
# @param Optional[Integer] $oauth_github_client_id,
# @param Optional[Integer] $oauth_github_client_secret,
# @param Stdlid::Absolutepath $base_url,
# @param Optional[Boolean] $sudospawner_enable,
# @param Optional[Boolean] $systemdspawner_enable,
# @param Optional[Stdlib::Absolutepath] $systemdspawner_user_workingdir,
# @param Optional[Stdlib::Absolutepath] $systemdspawner_default_shell,
# @param Optional[Integer] $systemdspawner_mem_limit,
# @param Optional[Integer] $systemdspawner_cpu_limit,
# @param Optional[Boolean] $systemdspawner_isolate_tmp,
# @param Optional[Boolean] $systemdspawner_isolate_devices,
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class jupyterhub (
  # Default values are in jupyterhub/data
  String $service_name,
  String $jupyterhub_username,
  String $jupyterhub_group,
  Stdlib::Absolutepath $jupyterhub_dir,
  Stdlib::Absolutepath $pyvenv,
  Optional[String] $allowed_users,
  Integer $port,
  Optional[String] $oauth_callback_url,
  Optional[Boolean] $oauth_github_enable,
  Optional[Integer] $oauth_github_client_id,
  Optional[Integer] $oauth_github_client_secret,
  Stdlib::Absolutepath $base_url,
  Optional[Boolean] $sudospawner_enable,
  Optional[Boolean] $systemdspawner_enable,
  Optional[Stdlib::Absolutepath] $systemdspawner_user_workingdir,
  Optional[Stdlib::Absolutepath] $systemdspawner_default_shell,
  Optional[Integer] $systemdspawner_mem_limit,
  Optional[Integer] $systemdspawner_cpu_limit,
  Optional[Boolean] $systemdspawner_isolate_tmp,
  Optional[Boolean] $systemdspawner_isolate_devices,

) {

  # validate parameters here
  contain jupyterhub::install
  contain jupyterhub::config
  contain jupyterhub::service

  Class { '::jupyterhub::install': }
  -> Class { '::jupyterhub::config': }
  ~> Class { '::jupyterhub::service': }
}
