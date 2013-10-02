define utils::host () {

  $hosts = hiera_hash('hosts')[$name]

  host {$hosts[0]:
    ip           => $name,
    host_aliases => $hosts,
    comment      => 'managed by puppet',
  }

}
