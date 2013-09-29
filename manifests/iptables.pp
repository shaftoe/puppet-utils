class utils::iptables (
  $ensure = present,
  $rules  = ''
  ) {

  package {'iptables-persistent': ensure => $ensure }

  file { '/etc/iptables/rules.v4':
    ensure  => $ensure,
    content => $rules,
    require => Package['iptables-persistent'],
    notify  => Service['iptables-persistent'],
  }

  $enable = $ensure ? {
    present => true,
    default => false,
  }
  $ensure_service = $ensure ? {
    present => running,
    default => stopped,
  }
  service {'iptables-persistent':
    ensure     => $ensure_service,
    enable     => $enable,
    hasrestart => false,
    status     => '/bin/true',
    stop       => '/etc/init.d/iptables-persistent flush',
    require    => Package['iptables-persistent'],
  }

}
