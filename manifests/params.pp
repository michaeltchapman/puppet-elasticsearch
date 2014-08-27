# == Class elasticsearch::params
#
# This class is meant to be called from elasticsearch
# It sets variables according to platform
#
class elasticsearch::params {

  case $::osfamily {
    'Debian': {
      $package_name = 'elasticsearch'
      $java_package_name = 'java-1.7.0-openjdk'
      $service_name = 'elasticsearch'
      $default_repo = {
                        'elasticsearch' => {
                          'location'  => 'http://packages.elasticsearch.org/elasticsearch/1.1/debian',
                          'key_source' => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
                          'release'    => 'stable',
                          'repos'      => 'main'
                        }
                      }
      $repo_defaults  = {}
    }
    'RedHat', 'Amazon': {
      $package_name = 'elasticsearch'
      $java_package_name = 'java-1.7.0-openjdk'
      $service_name = 'elasticsearch'
      $default_repo   = {
                          'elasticsearch' => {
                            'descr'    => 'Elasticsearch repository for 1.1.x packages',
                            'baseurl'  => 'http://packages.elasticsearch.org/elasticsearch/1.1/centos',
                            'gpgkey'   => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
                          }
                        }
      $repo_defaults  = {
                          'gpgcheck' => '1',
                          'enabled'  => '1'
                        }
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }
}
