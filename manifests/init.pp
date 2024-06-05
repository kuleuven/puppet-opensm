class opensm (
  Boolean $enabled      = $opensm::params::enabled,
  $priority             = $opensm::params::priority,
  $guids                = $opensm::params::guids,
  Hash $options         = $opensm::params::options,
  Array $packages       = $opensm::params::packages,
  $configuration        = $opensm::params::configuration,
  String $config_class  = $opensm::params::config_class,
  String $service       = $opensm::params::service
) inherits opensm::params {


  class { 'opensm::install':
    enabled  => $enabled,
    packages => $packages,
  }

  class { 'opensm::service':
    enabled => $enabled,
    service => $service,
  }

  if $enabled {
    class { "opensm::config::${config_class}":
      priority      => $priority,
      guids         => $guids,
      configuration => $configuration,
      options       => $options,
    }

    anchor { 'opensm::begin': ; }
      -> Class['opensm::install']
      -> Class["opensm::config::${config_class}"]
      ~> Class['opensm::service']
      -> anchor { 'opensm::end': ; }
  } else {
    anchor { 'opensm::begin': ; }
      -> Class['opensm::service']
      -> Class['opensm::install']
      -> anchor { 'opensm::end': ; }
  }
}
