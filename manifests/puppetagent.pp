# Enable/disable agentless puppet agent
class utils::puppetagent (
  $ensure    = present,
  $frequency = '*/15'
  ) {

  cron { 'puppet-agent':
    ensure      => $ensure,
    environment => 'PATH=/bin:/usr/sbin:/usr/bin:/usr/local/bin',
    user        => 'root',
    command     => 'puppet agent --no-daemonize --onetime',
    minute      => $frequency,
  }

}
