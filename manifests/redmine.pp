class utils::redmine () {

  $mounts = hiera('redmine_mounts')  # hash, source and dest
  $repository = hiera('redmine_docker_repository')

  file { '/etc/rc.local':
    ensure  => present,
    owner   => 'root',
    mode    => '0700',
    content => template('utils/redmine_rc.local.erb'),
  }

}
