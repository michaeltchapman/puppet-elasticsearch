# == Class elasticsearch::repo
#
# Manages elasticsearch repository
#
class elasticsearch::repo(
  $repo_hash     = undef,
  $repo_defaults = {}
) {
    include elasticsearch::params

    if $repo_hash {
      $_repo_hash = $repo_hash
    } else {
      $_repo_hash = $elasticsearch::params::default_repo
    }

    $_repo_defaults = merge($elasticsearch::params::repo_defaults, $repo_defaults)

    case $::osfamily {
      'RedHat', 'Amazon': {
        create_resources('yumrepo', $_repo_hash, $_repo_defaults)
      }
      'Debian': {
        create_resources('apt::source', $_repo_hash, $_repo_defaults)
      }
      default: {
        warning("Repository has not been set as ${::osfamily} is not supported.")
      }
    }
}
