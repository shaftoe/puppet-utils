# manage puppet.conf
class utils::puppetconf ($puppetmaster = '') {

  $master = $puppetmaster ? {
    ''      => "puppet.${::domain}",
    default => $puppetmaster
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => present,
    mode    => '0444',
    owner   => 'root',
    content => template('utils/puppet.conf.erb'),
  }

}
