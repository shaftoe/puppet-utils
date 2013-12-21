class utils::hosts () {
  $users = hiera_hash('hosts')
  each($users) |$x| { utils::host{ $x[0]: }}
}
