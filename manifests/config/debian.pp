class opensm::config::debian (
  $priority,
  $guids,
  $configuration,
  $options
) {
  augeas { '/etc/default/opensm':
    lens    => 'Shellvars.lns',
    incl    => '/etc/default/opensm',
    context => '/files/etc/default/opensm/',
    changes => [
      "set PORTS '\"${guids}\"'"
    ],
  }
  
  opensm::fileconf { $configuration:
    options  => $options,
    override => {
      'sm_priority' => $priority,
    },
  }
}
