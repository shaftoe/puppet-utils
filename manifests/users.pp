class utils::users () {
  $users = hiera_hash('users')
  each($users) |$x| { utils::user{ $x[0]: }}

  if $::osfamily == 'RedHat' {
    file {'/etc/skel/.profile':
      ensure => present,
      owner  => 'root',
      mode   => '0444',
      source => 'puppet:///modules/utils/profile',
    }
  }

}
