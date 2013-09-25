class utils::redmine (
  $mounts = false,  # hash, source and dest
  $repository = false
  ) {

  file { '/etc/rc.local':
    ensure  => present,
    owner   => 'root',
    mode    => '0700',
    content => template('utils/redmine_rc.local.erb'),
  }

}
