define elasticsearch::configline(
  $value,
  $target = '/etc/elasticsearch/elasticsearch.yml'
) {
  yaml_setting { "${target}/${key}/${value}":
    value  => $value,
    target => $target,
    key    => $title
  }
}
