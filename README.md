[![Build Status](https://travis-ci.org/kuleuven/puppet-jupyterhub.svg?branch=master)](https://travis-ci.org/kuleuven/puppet-jupyterhub)

#### Table of Contents

1. [Module Description](#module-description)
1. [Setup](#setup)
    * [Beginning with jupyterhub](#beginning-with-jupyterhub)
    * [Setup requirements](#setup-requirements)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)


## Module Description

This module installs, configures and managed [Jupyterhub](https://github.com/jupyterhub/jupyterhub). The module has support for the [sudospawner](https://github.com/jupyterhub/sudospawner) and [systemdspawner](https://github.com/jupyterhub/systemdspawner). This module is a fork and has been rewritten to support hiera 5.

For different OAuthenticator setups, have a look at the [jupyterhub oauthenticator](https://github.com/jupyterhub/oauthenticator) page.

## Setup

### Beginning with jupyterhub

`include ::jupyterhub` should be enough to get it up and running.

### Setup Requirements

The module needs Python and Nodejs, both modules are listed in the dependencies. On CentOS, EPEL is needed and comes as a dependency of the stankevich-python module. If you already have a local mirror or EPEL on the system, you can set the boolean to `false`. If there is no EPEL repo available, install will **fail**.


## Usage

All parameters for the jupyterhub module are contained within the main ::jupyterhub class, so for any function of the module, set the options you want.


## Reference

### Classes

#### Public classes

jupyterhub: Main class, includes all other.

#### Private classes

- jupyterhub::install: Installs all packages (python pyvenv, nodejs,...) and dependencies
- jupyterhub::config: Sets the config and log file
- jupyterhub::service: Handles the sysvinit / systemd service

### Parameters

Following parameters are available, and are the defaults:

```yaml
jupyterhub::allowed_users: ~
jupyterhub::base_url: /
jupyterhub::base_url: /
jupyterhub::batchspawner_command: ~
jupyterhub::batchspawner_commands:
  - '/usr/bin/qdel'
  - '/usr/bin/qstat'
  - '/usr/bin/qsub'
jupyterhub::batchspawner_commands_enable: false
jupyterhub::batchspawner_enable: false
jupyterhub::batchspawner_host: ~
jupyterhub::batchspawner_memory: ~
jupyterhub::batchspawner_module_path: ~
jupyterhub::batchspawner_module_python: ~
jupyterhub::batchspawner_node: '1'
jupyterhub::batchspawner_nprocs: ~
jupyterhub::batchspawner_qos: '{qos}'
jupyterhub::batchspawner_queue: ~
jupyterhub::batchspawner_runtime: ~
jupyterhub::batchspawner_torque_enable: false
jupyterhub::config_dir: /etc/jupyter
jupyterhub::cookie_secret_file: ~
jupyterhub::custom_packages:
  - matplotlib
  - numpy
  - scipy
jupyterhub::custom_packages_enable: false
jupyterhub::debug_enable: false
jupyterhub::epel_enable: true
jupyterhub::hub_ip: "%{facts.networking.ip}"
jupyterhub::hub_port: 7001
jupyterhub::ip: "%{facts.networking.ip}"
jupyterhub::jupyterhub_dir: /opt/jupyterhub
jupyterhub::jupyterhub_group: 'jupyter'
jupyterhub::jupyterhub_username: 'jupyter'
jupyterhub::manage_git: true
jupyterhub::oauth_callback_url: ~
jupyterhub::oauth_client_id: ~
jupyterhub::oauth_client_secret: ~
jupyterhub::oauth_create_system_users: false
jupyterhub::oauth_custom_enable: false
jupyterhub::oauth_enable: false
jupyterhub::oauth_full_name: 'oauthenticator.MyOAuthenticator'
jupyterhub::oauth_github_client_id: ~
jupyterhub::oauth_github_client_secret: ~
jupyterhub::oauth_github_enable: false
jupyterhub::oauth_name: 'MyOAuthenticator'
jupyterhub::port: 7000
jupyterhub::proxy_api_port: ~
jupyterhub::python_version: 'system'
jupyterhub::pyvenv: /opt/jupyterhub/pyvenv
jupyterhub::reverse_proxy_enable: false
jupyterhub::reverse_proxy_origin: []
jupyterhub::service_enable: true
jupyterhub::service_ensure: running
jupyterhub::service_manage: true
jupyterhub::service_name: jupyterhub
jupyterhub::ssl_cert: ~
jupyterhub::ssl_enable: false
jupyterhub::ssl_key: ~
jupyterhub::sudospawner_allowed_users: []
jupyterhub::sudospawner_debug_enable: false
jupyterhub::sudospawner_enable: true
jupyterhub::systemdspawner_cpu_limit: 'None'
jupyterhub::systemdspawner_default_shell: ~
jupyterhub::systemdspawner_enable: false
jupyterhub::systemdspawner_isolate_devices: false
jupyterhub::systemdspawner_isolate_tmp: false
jupyterhub::systemdspawner_mem_limit: 'None'
jupyterhub::systemdspawner_user_workingdir: /home/{USERNAME}
jupyterhub::wrapspawner_enable: false
```

## Limitations

To enable the different spawners, set the right boolean to `true`.
At the moment, only the sudospawner and systemdspawner are supported.

There is a lib for facter to detect the initsystem. Only systemd and sysvinit are supported. To disable the management of the service set following parameter in hiera. The module still copies the bash script to start up Jupyterhub, so you can start it throught the script.

```yaml
jupyterhub::service_manage: false
```

The role has been tested on CentOS 7. It could be that the Debian OS family needs some work or debugging regarding the python pyvenv.



---
