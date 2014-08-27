# == Class elasticsearch::service
#
#
class elasticsearch::service(
  $ensure = 'running',
  $enable = true
)
{
  service { 'elasticsearch':
    ensure     => $ensure,
    name       => $elasticsearch::params::service_name,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true
  }
}
