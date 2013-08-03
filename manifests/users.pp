class utils::users () {
  $users = hiera_hash('users')
  $users.foreach { |$x| utils::user{ $x[0]: }}
}
