if $facts['os']['family'] == 'RedHat' {
  package {'epel-release':
    ensure => installed
  }
}
