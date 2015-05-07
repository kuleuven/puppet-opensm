class opensm::config::redhat (
  $priority,
  $guids,
  $configuration,
  $options
) {
  augeas { '/etc/sysconfig/opensm':
    lens    => 'Shellvars.lns',
    incl    => '/etc/sysconfig/opensm',
    context => '/files/etc/sysconfig/opensm/',
    changes => [
      "set PRIORITY ${priority}",
      "set GUIDS '\"${guids}\"'"
    ],
  }

  opensm::fileconf { $configuration:
    options  => $options,
  }
}
