define opensm::fileconf (
  Stdlib::Absolutepath $filename = $title,
  Hash $options  = {},
  Hash $override = {},
) {
  if $filename in $options {
    $_options = merge($options[$filename], $override)
  } else {
    $_options = merge($options, $override)
  }

  $_keys = $_options.keys
  $_vals = $_options.values

  exec { "opensm-create-${filename}":
    command => "/usr/sbin/opensm -c ${filename}",
    creates => $filename,
    require => Class['opensm::install'],
  }

  if size($_keys)>0 {
    # lame transform of the options hash to Augeas commands
    $_aug_keys  = prefix($_keys, 'set ')
    $_aug_vals1 = regsubst($_vals, '"', '\'', 'G') #TODO
    $_aug_vals2 = regsubst($_aug_vals1, '^\s*$', '(null)')
    $_aug_vals3 = regsubst($_aug_vals2, '^(.*)$', '"\1"')
    $_changes   = join_keys_to_values(flatten(zip($_aug_keys, $_aug_vals3)), ' ')

    augeas { $filename:
      lens    => 'OpenSM.lns',
      incl    => $filename,
      context => "/files${filename}",
      changes => $_changes,
      require => Exec["opensm-create-${filename}"],
      notify  => Class['opensm::service'],
    }
  }
}
