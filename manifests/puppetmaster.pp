# Setup sync cronjobs for puppetmaster
class utils::puppetmaster (
  $puppetpath        = '/etc/puppet',
  $manifestsbasepath = '/etc/puppet',
  $hierabasepath     = '/var/lib/hiera'
  ) {

  include 'utils::puppetagent'

  $m = '/usr/local/puppet-bitbucket'
  cron { 'puppet-repo-update':
    user    => 'root',
    command => "cd ${manifestsbasepath} && git pull &> /dev/null",
    minute  => '*/5'
  }

  cron { 'hiera-repo-update':
    user    => 'root',
    command => "cd ${hierabasepath} && git pull > /dev/null 2> /dev/null",
    minute  => '*/5',
  }

  cron { 'librarian-update':
    environment => 'PATH=/bin:/usr/bin:/usr/sbin:/usr/local/bin',
    user        => 'root',
    command     => "cd ${puppetpath} && librarian-puppet install",
    minute      => '*/5',
  }

}
