class opensm::params {
  $enabled = true
  $packages = ['opensm']
  $priority = 0
  $options = {}

  case $::operatingsystem {
    debian,ubuntu: {
      $guids = 'ALL'
      $service = 'opensm'
      $configuration = '/etc/opensm/opensm.conf'
      $config_class = 'debian'
    }

    redhat,centos,scientific,oraclelinux,fedora,rocky,almalinux: {
      $guids = ''
      $service = 'opensm'
      $configuration = '/etc/rdma/opensm.conf'
      $config_class = 'redhat'
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
