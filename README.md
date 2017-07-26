#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with jupyterhub](#setup)
    * [What jupyterhub affects](#what-jupyterhub-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with jupyterhub](#beginning-with-jupyterhub)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Module Description

This module installs, configures and managed [Jupyterhub](https://github.com/jupyterhub/jupyterhub). The module has support for the [sudospawner](https://github.com/jupyterhub/sudospawner) and [systemdspawner](https://github.com/jupyterhub/systemdspawner). This module is a fork and has been rewritten to support hiera 5.

## Setup

`include ::jupyterhub` should be enough to get it up and running.
To enable the different spawners, set the right boolean to `true`.

Following parameters are available, and are the defaults:

```yaml
---
jupyterhub::service_name: 'jupyterhub'
jupyterhub::jupyterhub_username: 'jupyter'
jupyterhub::jupyterhub_group: 'jupyter'
jupyterhub::jupyterhub_dir: /opt/jupyterhub
jupyterhub::pyvenv: /opt/jupyterhub/pyvenv
jupyterhub::allowed_users: ~
jupyterhub::port: 7000
jupyterhub::oauth_callback_url: ~
jupyterhub::oauth_client_id: ~
jupyterhub::oauth_client_secret: ~
jupyterhub::oauth_create_system_users: false
jupyterhub::oauth_github_enable: false
jupyterhub::oauth_github_client_id: ~
jupyterhub::oauth_github_client_secret: ~
jupyterhub::base_url: /
jupyterhub::sudospawner_enable: true
jupyterhub::systemdspawner_enable: false
jupyterhub::systemdspawner_user_workingdir: /home/{USERNAME}
jupyterhub::systemdspawner_default_shell: ~
jupyterhub::systemdspawner_mem_limit: 'None'
jupyterhub::systemdspawner_cpu_limit: 'None'
jupyterhub::systemdspawner_isolate_tmp: false
jupyterhub::systemdspawner_isolate_devices: false
```

### Setup Requirements **OPTIONAL**

The module needs Python and Nodejs, both modules are listed in the dependencies

### Beginning with jupyterhub

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
