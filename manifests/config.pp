# == Class elasticsearch::config
#
# Set elasticsearch configuration
#
# Hiera example (these are the defaults):
#
# elasticsearch::config::config_hash:
#   script.disable_dynamic:
#     value: true
#   discovery.zen.ping.multicast.enabled:
#     value: true
#   network.host:
#     value: localhost
#
class elasticsearch::config(
  $config_hash = {},
  $network_host = 'localhost'
) {

  $default_config = {
    'discovery.zen.ping.multicast.enabled' => { 'value' => false },
    'script.disable_dynamic' => { 'value' => true },
    'network.host' => { 'value' => $network_host }
  }

  $conf = merge($default_config, $config_hash)

  file { '/etc/elasticsearch/':
    ensure => 'directory'
  } -> Yaml_setting<| target == '/etc/elasticsearch/elasticsearch.yml' |>

  create_resources('elasticsearch::configline', $conf, { 'target' => '/etc/elasticsearch/elasticsearch.yml'})

  Yaml_setting<||> ->
  file { '/etc/elasticsearch/elasticsearch.yml':
    mode => '0644'
  }
}
