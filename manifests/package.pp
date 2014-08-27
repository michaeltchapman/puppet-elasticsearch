# == Class elasticsearch::package
#
# Manage elasticsearch packages
#
class elasticsearch::package (
  $package_name        = $::elasticsearch::params::package_name,
  $package_ensure      = 'installed',
) inherits elasticsearch::params {
  package { 'elasticsearch':
    ensure => $package_ensure,
    name   => $package_name,
  }
}
