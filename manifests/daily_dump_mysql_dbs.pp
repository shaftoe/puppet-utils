class utils::daily_dump_mysql_dbs (
  $ensure = 'present',
  $dbuser = 'backup',
  $dbpass = 'secret',
  $storedirectory = "/var/backups/${::hostname}/mysql-dumps",
  $retentiondays = '30'
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail 'ensure must be "present" or "absent"'
  }

  $ensure_dir = $ensure ? {
    'present' => 'directory',
    default   => absent
  }

  file { ["/var/backups/${::hostname}", $storedirectory]:
    ensure  => $ensure_dir,
    recurse => true,
    force   => true,
    mode    => '0750',
    owner   => 'root',
    group   => 'staff',
  }

  file { '/usr/local/sbin/mysql-dumps.sh':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'staff',
    mode    => '0740',
    content => template('utils/mysql-dumps.sh.erb'),
  }

  cron { 'daily_dump_mysql_databases':
    ensure  => $ensure,
    command => '/usr/local/sbin/mysql-dumps.sh',
    user    => 'root',
    minute  => '0',
    hour    => '0',
    require => [
      File['/usr/local/sbin/mysql-dumps.sh'],
      File[$storedirectory],
    ],
  }

}
