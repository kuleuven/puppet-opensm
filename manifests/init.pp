class opensm (
  $enabled       = $opensm::params::enabled,
  $priority      = $opensm::params::priority,
  $guids         = $opensm::params::guids,
  $options       = $opensm::params::options,
  $packages      = $opensm::params::packages,
  $configuration = $opensm::params::configuration,
  $config_class  = $opensm::params::config_class,
  $service       = $opensm::params::service
) inherits opensm::params {

  validate_bool($enabled)
  #validate_integer($priority)
  validate_hash($options)
  validate_array($packages)
  validate_string($config_class, $service)

  if is_array($configuration) or is_string($configuration) {
    #validate_absolute_path($configuration)
  } else {
    fail('configuration must be string or array of strings')
  }

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
