#
# Install latest docker binary
#
class utils::docker () {

  $url = 'https://get.docker.io/builds/Linux/x86_64/docker-latest'
  $bin = '/usr/local/bin/docker'

  exec { 'deploy_latest_docker':
    command => "/usr/bin/wget -O ${bin} ${url}",
    creates => $bin,
  }

  file { $bin:
    mode    => '0750',
    require => Exec['deploy_latest_docker'],
  }

}
