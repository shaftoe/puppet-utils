#
# Install latest docker binary
#
class utils::docker () {

  $pkgs = [
    'aufs-tools',
    'cgroup-bin',
    'libcgroup1',
    'lxc',
  ]
  packages {$pkgs: ensure => present}

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

  file {'/etc/init.d/docker':
    ensure => present,
    owner  => 'root',
    mode   => '0554',
    source => 'puppet:///modules/utils/docker-init',
  }

  service {'docker':
    ensure  => running,
    enable  => true,
    require => [
      File['/etc/init.d/docker'],
      File[$bin],
    ],
  }

}
