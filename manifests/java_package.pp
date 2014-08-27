# == Class elasticsearch::java_package
#
# Manage elasticsearch java package
#
class elasticsearch::java_package (
  $java_package_name   = $::elasticsearch::params::java_package_name,
  $java_package_ensure = 'installed'
) inherits elasticsearch::params {

  package { 'java-1.7':
    ensure => $java_package_ensure,
    name   => $java_package_name,
  }
}
