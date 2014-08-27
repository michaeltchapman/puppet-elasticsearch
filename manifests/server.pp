# == Class: elasticsearch::server
#
# Full description of class elasticsearch here.
#
# === Parameters
#
# [*manage_package*]
#   Whether to manage the elasticsearch package
#
# [*manage_java_package*]
#   Whether to manage the elasticsearch package
#
# [*manage_service*]
#   Whether to manage the elasticsearch service
#
# [*manage_repo*]
#   Whether to manage the elasticsearch repo
#
# [*config_hash*]
#   A hash of config files and their contents. See examples folder
#   for the format.
#
class elasticsearch::server (
  $manage_package       = true,
  $manage_java_package  = true,
  $manage_service       = true,
  $manage_repo          = true,
  $config_hash          = {} 
) inherits elasticsearch::params {

  validate_bool($manage_repo)
  validate_bool($manage_package)
  validate_bool($manage_java_package)
  validate_bool($manage_service)

  if $manage_repo {
    include elasticsearch::repo
    if $manage_package {
      Class['elasticsearch::repo'] -> Class['elasticsearch::package']
    }
  }

  if $manage_package {
    include elasticsearch::package
    if $manage_service {
      Class['elasticsearch::package'] ~> Class['elasticsearch::service']
    }
  }

  if $manage_java_package {
    include elasticsearch::java_package
    if $manage_service {
      Class['elasticsearch::java_package'] ~> Class['elasticsearch::service']
    }
    if $manage_package {
      Class['elasticsearch::java_package'] -> Class['elasticsearch::package']
    }
  }

  if $config_hash {
    class { 'elasticsearch::config':
      config_hash     => $config_hash,
    }
    if $manage_service {
      Class['elasticsearch::config'] ~> Class['elasticsearch::service']
    }
  } else {
    notice('Not setting elasticsearch config: no hash provided')
  }

  if $manage_service {
    include elasticsearch::service
  }
}
