# Setup sync cronjobs for puppetmaster
class utils::puppetmaster (
  $ensure            = present,
  $puppetpath        = '/etc/puppet',
  $manifestsbasepath = '/etc/puppet',
  $hierabasepath     = '/var/lib/hiera'
  ) {

  include 'utils::puppetagent'

  if $ensure == present {

    tidy { '/var/lib/puppet/reports':
      recurse => true,
      age     => '1w',
    }

  }

  cron { 'puppet-repo-update':
    ensure  => $ensure,
    user    => 'root',
    command => "cd ${manifestsbasepath} && git pull &> /dev/null",
    minute  => '*/5'
  }

  cron { 'hiera-repo-update':
    ensure  => $ensure,
    user    => 'root',
    command => "cd ${hierabasepath} && git pull > /dev/null 2> /dev/null",
    minute  => '*/5',
  }

  cron { 'librarian-update':
    ensure      => $ensure,
    environment => 'PATH=/bin:/usr/bin:/usr/sbin:/usr/local/bin',
    user        => 'root',
    command     => "cd ${puppetpath} && librarian-puppet install",
    minute      => '*/5',
  }

}
