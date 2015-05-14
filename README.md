# Puppet OpenSM module

This module installs, configures and starts Inifiniband OpenSM.

### Requirements

Module has been tested on:

* Puppet 3.7
* Debian 7, 8 and RHEL/CentOS 6, 7

Required modules:

* stdlib (https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Setup

```puppet
include opensm
```

Full configuration options:

```puppet
class { 'opensm':
  enabled       => true|false,  # enable state
  priority      => ...,         # subnet manager priority <0,15>
  guids         => ...,         # list port GUIDs to start on
  options       => {},          # hash of options for opensm.conf
  packages      => [...],       # override list of packages to install
  configuration => '...',       # override absolute path and name to opensm.conf
  config_class  => '...',       # override internal configuration class
  service       => '...',       # override service name
}
```

***

CERIT Scientific Cloud, <support@cerit-sc.cz>
