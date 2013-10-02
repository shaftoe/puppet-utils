class utils::hosts () {
  $users = hiera_hash('hosts')
  $users.foreach { |$x| utils::host{ $x[0]: }}
}
