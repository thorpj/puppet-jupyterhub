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
# @param Optional[Httpurl] $oauth_callback_url,
# @param Optional[Boolean] $oauth_github_enable,
# @param Optional[String] $oauth_github_client_id,
# @param Optional[String] $oauth_github_client_secret,
# @param String $base_url,
# @param Optional[Boolean] $sudospawner_enable,
# @param Optional[Boolean] $systemdspawner_enable,
# @param Optional[Stdlib::Absolutepath] $systemdspawner_user_workingdir,
# @param Optional[Stdlib::Absolutepath] $systemdspawner_default_shell,
# @param Optional[String] $systemdspawner_mem_limit,
# @param Optional[String] $systemdspawner_cpu_limit,
# @param Optional[Boolean] $systemdspawner_isolate_tmp,
# @param Optional[Boolean] $systemdspawner_isolate_devices,
#
class jupyterhub (
  # Default values are in jupyterhub/data
  Optional[Stdlib::Absolutepath] $cookie_secret_file,
  String $service_name,
  Boolean $service_enable,
  Variant[Enum['running', 'stopped'], Boolean] $service_ensure,
  Boolean $service_manage,
  String $jupyterhub_username,
  String $jupyterhub_group,
  Stdlib::Absolutepath $jupyterhub_dir,
  Stdlib::Absolutepath $pyvenv,
  $ip,
  Integer $port,
  Optional[Integer] $hub_port,
  Optional[Stdlib::Httpurl] $oauth_callback_url,
  Optional[Boolean] $epel_enable,
  Optional[Boolean] $debug_enable,
  Optional[Boolean] $manage_git,
  Optional[Boolean] $oauth_enable,
  Optional[Boolean] $oauth_custom_enable,
  Optional[String] $oauth_full_name,
  Optional[String] $oauth_name,
  Optional[String] $oauth_client_id,
  Optional[String] $oauth_client_secret,
  Optional[Boolean] $oauth_create_system_users,
  Optional[Boolean] $oauth_github_enable,
  Optional[String] $oauth_github_client_id,
  Optional[String] $oauth_github_client_secret,
  String $base_url,
  Optional[Boolean] $ssl_enable,
  Optional[Integer] $proxy_api_port,
  Optional[Stdlib::Absolutepath] $ssl_cert,
  Optional[Stdlib::Absolutepath] $ssl_key,
  Optional[Boolean] $sudospawner_enable,
  Optional[Boolean] $sudospawner_debug_enable,
  Optional[Array[String]] $sudospawner_allowed_users,
  Optional[Boolean] $systemdspawner_enable,
  Optional[Stdlib::Absolutepath] $systemdspawner_user_workingdir,
  Optional[Stdlib::Absolutepath] $systemdspawner_default_shell,
  Optional[String] $systemdspawner_mem_limit,
  Optional[String] $systemdspawner_cpu_limit,
  Optional[Boolean] $systemdspawner_isolate_tmp,
  Optional[Boolean] $systemdspawner_isolate_devices,
  Optional[Boolean] $batchspawner_torque_enable,
  Optional[Integer] $batchspawner_nprocs,
  Optional[String] $batchspawner_queue,
  Optional[String] $batchspawner_host,
  Optional[String] $batchspawner_runtime,
  Optional[String] $batchspawner_memory,

) {

  Class { '::jupyterhub::install': }
  -> Class { '::jupyterhub::config': }
  ~> Class { '::jupyterhub::service': }
}
