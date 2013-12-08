class utils::users () {
  $users = hiera_hash('users')
  $users.foreach { |$x| utils::user{ $x[0]: }}

  if $::osfamily == 'RedHat' {
    file {'/etc/skel/.profile':
      ensure  => present,
      owner   => 'root',
      mode    => '0444',
      content => 'puppet:///modules/utils/profile',
    }
  }

}
