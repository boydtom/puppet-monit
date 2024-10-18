# @summary
#   This is a container class with default parameters for monit classes.
#
# @api private
class monit::params {
  $check_interval            = 120
  $config_dir_purge          = false
  $httpd                     = false
  $httpd_port                = 2812
  $httpd_address             = 'localhost'
  $httpd_allow               = '0.0.0.0/0.0.0.0'
  $httpd_user                = 'admin'
  $httpd_password            = 'monit'
  $manage_firewall           = false
  $package_ensure            = 'present'
  $package_name              = 'monit'
  $service_enable            = true
  $service_ensure            = 'running'
  $service_manage            = true
  $service_name              = 'monit'
  $logfile                   = '/var/log/monit.log'
  $mailserver                = undef
  $mailformat                = undef
  $alert_emails              = []
  $start_delay               = undef
  $mmonit_address            = undef
  $mmonit_https              = true
  $mmonit_port               = 8443
  $mmonit_user               = 'monit'
  $mmonit_password           = 'monit'
  $mmonit_without_credential = false
  $osfamily = $facts['os']['family']

  # <OS family handling>
  case $osfamily {
    'Debian': {
      $config_file   = '/etc/monit/monitrc'
      $config_dir    = '/etc/monit/conf.d'
      $monit_version = '5'
      $lsbdistcodename = $facts['os']['distro']['codename']

      case $lsbdistcodename {
        'buster', 'bullseye', 'bookworm', 'bionic', 'focal', 'jammy': {
          $default_file_content = 'START=yes'
          $service_hasstatus    = true
        }
        default: {
          fail("monit supports Debian 10 (buster), 11 (bullseye) and 12 (bookworm) and Ubuntu 18.04 (bionic), 20.04 (focal) and 22.04 (jammy). Detected lsbdistcodename is <${lsbdistcodename}>.")
        }
      }
    }
    'RedHat': {
      $config_dir        = '/etc/monit.d'
      $service_hasstatus = true
      $operatingsystemmajrelease = $facts['os']['release']['major']

      case $operatingsystemmajrelease {
        '7', '8', '9': {
          $monit_version = '5'
          $config_file   = '/etc/monitrc'
        }
        default: {
          fail("monit supports EL 7, 8 and 9. Detected operatingsystemmajrelease is <${operatingsystemmajrelease}>.")
        }
      }
    }
    default: {
      fail("monit supports osfamilies Debian and RedHat. Detected osfamily is <${osfamily}>.")
    }
  }
}
