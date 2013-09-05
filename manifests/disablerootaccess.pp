class utils::disablerootaccess () {
  file {'/etc/securetty':
    ensure  => present,
    owner   => 'root',
    mode    => '0400',
    content => '',
  }
}
