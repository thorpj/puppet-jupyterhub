[![Build Status](https://travis-ci.org/yorickps/puppet-jupyterhub.svg?branch=master)](https://travis-ci.org/yorickps/puppet-jupyterhub)

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

## Setup

### Beginning with jupyterhub

`include ::jupyterhub` should be enough to get it up and running.


### Setup Requirements

The module needs Python and Nodejs, both modules are listed in the dependencies. On CentOS, EPEL is needed if the boolean is set to `true`, but EPEL comes as a dependency of the stankevich-python module.

## Usage

All parameters for the jupyterhub module are contained within the main ::jupyterhub class, so for any function of the module, set the options you want.


## Reference

### Classes

#### Public classes

jupyterhub: Main class, includes all other.

#### Private classes

- jupyterhub::install: Installs all packages (python pyvenv, nodejs,...) and dependencies
- jupyterhub::config: Sets the config and log file
- jupyterhub::service: Handles the systemd service

### Parameters

Following parameters are available, and are the defaults:

```yaml
jupyterhub::allowed_users: ~
jupyterhub::base_url: /
jupyterhub::cookie_secret_file: ~
jupyterhub::epel_enable: true
jupyterhub::jupyterhub_dir: /opt/jupyterhub
jupyterhub::jupyterhub_group: 'jupyter'
jupyterhub::jupyterhub_username: 'jupyter'
jupyterhub::manage_git: true
jupyterhub::oauth_callback_url: ~
jupyterhub::oauth_client_id: ~
jupyterhub::oauth_client_secret: ~
jupyterhub::oauth_create_system_users: false
jupyterhub::oauth_enable: false
jupyterhub::oauth_github_client_id: ~
jupyterhub::oauth_github_client_secret: ~
jupyterhub::oauth_github_enable: false
jupyterhub::port: 7000
jupyterhub::pyvenv: /opt/jupyterhub/pyvenv
jupyterhub::service_enable: true
jupyterhub::service_ensure: running
jupyterhub::service_manage: true
jupyterhub::service_name: jupyterhub
jupyterhub::ssl_enable: false
jupyterhub::sudospawner_allowed_users: []
jupyterhub::sudospawner_enable: true
jupyterhub::systemdspawner_cpu_limit: 'None'
jupyterhub::systemdspawner_default_shell: ~
jupyterhub::systemdspawner_enable: false
jupyterhub::systemdspawner_isolate_devices: false
jupyterhub::systemdspawner_isolate_tmp: false
jupyterhub::systemdspawner_mem_limit: 'None'
jupyterhub::systemdspawner_user_workingdir: /home/{USERNAME}
```

## Limitations

To enable the different spawners, set the right boolean to `true`. You can only enable one spawner at a time.
At the moment, only the sudospawner and systemdspawner are supported.

By default systemd is used for the service. You can disable the service management by setting

```yaml
jupyterhub::service_manage: false
```

The role has been tested on CentOS 7. It could be that the Debian OS family needs some work or debugging regarding the python pyvenv.
