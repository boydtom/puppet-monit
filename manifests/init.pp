# @summary
#   Main class, includes all other classes.
#
# @example
#   class { 'monit': }
#
# @param alert_emails
#   Specifies one or more email addresses to send global alerts to. Default value: []
#
# @param check_interval
#   Specifies the interval between two checks of Monit. Default value: 120
#
# @param config_file
#   Specifies a path to the main config file. Default value: varies with operating system
#
# @param config_dir
#   Specifies a path to the config directory. Default value: varies with operating system
#
# @param config_dir_purge
#   Specifies if unmanaged files in the config directory should be purged. Default value: 'false'
#
# @param httpd
#   Specifies whether to enable the Monit Dashboard. Default value: 'false'
#
# @param httpd_port
#   Specifies the port of the Monit Dashboard. Default value: 2812
#
# @param httpd_address
#   Specifies the IP address of the Monit Dashboard. Default value: 'locahost'
#
# @param httpd_allow
#   Specifies the allow option of the Monit Dashboard. Default value: '0.0.0.0/0.0.0.0'
#
# @param httpd_user
#   Specifies the user to access the Monit Dashboard. Default value: 'admin'
#
# @param httpd_password
#   Specifies the password to access the Monit Dashboard. Default value: 'monit'
#
# @param logfile
#   Specifies the logfile directive value. Default value: '/var/log/monit.log'
#   It is possible to use syslog instead of direct file logging. (e.g. 'syslog facility log\_daemon')
#
# @param mailserver
#   If set to a string, alerts will be sent by email to this mailserver. Default value: undef
#   For more details, see: https://mmonit.com/monit/documentation/monit.html#Setting-a-mail-server-for-alert-delivery
#
# @param mailformat
#   Specifies the alert message format. Default value: undef
#   For more details, see: https://mmonit.com/monit/documentation/monit.html#Message-format
#
# @param manage_firewall
#   If true and if puppetlabs-firewall module is present, Puppet manages firewall to allow HTTP access for Monit Dashboard.
#   Default value: 'false'
#
# @param mmonit_address
#   *Requires at least Monit 5.0*<br />
#   Specifies the remote address of an M/Monit server to be used by Monit agent for report. If set to undef, M/Monit connection is disabled.
#   Default value: undef
#
# @param mmonit_https
#   *Requires at least Monit 5.0*<br />
#   Specifies wheither the protocol of the M/Monit server is HTTPs. Default value: 'true'
#
# @param mmonit_port
#   *Requires at least Monit 5.0*<br />
#   Specifies the remote port of the M/Monit server. Default value: 8443
#
# @param mmonit_user
#   *Requires at least Monit 5.0*<br />
#   Specifies the user to connect to the remote M/Monit server. Default value: 'monit'
#   If you set both user and password to an empty string, authentication is disabled.
#
# @param mmonit_password
#   *Requires at least Monit 5.0*<br />
#   Specifies the password of the account used to connect to the remote M/Monit server. Default value: 'monit'
#   If you set both user and password to an empty string, authentication is disabled.
#
# @param mmonit_without_credential
#   *Requires at least Monit 5.0*<br />
#   By default Monit registers credentials with M/Monit so M/Monit can smoothly communicate back to Monit and you don't have to register
#   Monit credentials manually in M/Monit. It is possible to disable credential registration setting this option to 'true'.
#   Default value: 'false'
#
# @param package_ensure
#   Tells Puppet whether the Monit package should be installed, and what version.
#   Valid options: 'present', 'latest', or a specific version number.
#   Default value: 'present'
#
# @param package_name
#   Tells Puppet what Monit package to manage. Default value: 'monit'
#
# @param service_ensure
#   Tells Puppet whether the Monit service should be running. Default value: 'running'
#
# @param service_manage
#   Tells Puppet whether to manage the Monit service. Default value: 'true'
#
# @param service_name
#   Tells Puppet what Monit service to manage. Default value: 'monit'
#
# @param start_delay *Requires at least Monit 5.0*
#   If set, Monit will wait the specified time in seconds before it starts checking services. Default value: undef
#
class monit (
  Array[String]                           $alert_emails              = $monit::params::alert_emails,
  Integer[1]                              $check_interval            = $monit::params::check_interval,
  Stdlib::Absolutepath                    $config_file               = $monit::params::config_file,
  Stdlib::Absolutepath                    $config_dir                = $monit::params::config_dir,
  Variant[Boolean, Enum['true', 'false']] $config_dir_purge          = $monit::params::config_dir_purge,
  Variant[Boolean, Enum['true', 'false']] $httpd                     = $monit::params::httpd,
  Integer[1, 65535]                       $httpd_port                = $monit::params::httpd_port,
  String                                  $httpd_address             = $monit::params::httpd_address,
  String                                  $httpd_allow               = $monit::params::httpd_allow,
  String                                  $httpd_user                = $monit::params::httpd_user,
  String                                  $httpd_password            = $monit::params::httpd_password,
  Optional[String]                        $logfile                   = $monit::params::logfile,
  Optional[String]                        $mailserver                = $monit::params::mailserver,
  Optional[Hash]                          $mailformat                = $monit::params::mailformat,
  Boolean                                 $manage_firewall           = $monit::params::manage_firewall,
  Optional[String]                        $mmonit_address            = $monit::params::mmonit_address,
  Boolean                                 $mmonit_https              = $monit::params::mmonit_https,
  Integer[1, 65535]                       $mmonit_port               = $monit::params::mmonit_port,
  String                                  $mmonit_user               = $monit::params::mmonit_user,
  String                                  $mmonit_password           = $monit::params::mmonit_password,
  Boolean                                 $mmonit_without_credential = $monit::params::mmonit_without_credential,
  String                                  $package_ensure            = $monit::params::package_ensure,
  String                                  $package_name              = $monit::params::package_name,
  Boolean                                 $service_enable            = $monit::params::service_enable,
  Enum['running', 'stopped']              $service_ensure            = $monit::params::service_ensure,
  Boolean                                 $service_manage            = $monit::params::service_manage,
  String                                  $service_name              = $monit::params::service_name,
  Optional[Integer[1]]                    $start_delay               = $monit::params::start_delay,
) inherits monit::params {
  if $logfile and !($logfile =~ /^syslog(\s+facility\s+log_(local[0-7]|daemon))?/) {
    assert_type(Stdlib::Absolutepath, $logfile)
  }

  # Use the monit_version fact if available, else use the default for the
  # platform.
  $monit_version_real = pick($facts['monit_version'], $monit::params::monit_version)

  if($start_delay and $start_delay > 0 and versioncmp($monit_version_real,'5') < 0) {
    fail("start_delay requires at least Monit 5.0. Detected version is <${monit_version_real}>.")
  }

  contain "${module_name}::install"
  contain "${module_name}::config"
  contain "${module_name}::service"
  contain "${module_name}::firewall"

  Class["${module_name}::install"] -> Class["${module_name}::config"] ~> Class["${module_name}::service"] -> Class["${module_name}::firewall"]
}
