class utils::fabric ($ensure = present) {

  $pkgs = [
    'python-pip',
    'python-dev',
    'python-yaml',
  ]
  package { $pkgs: ensure => $ensure } 

  package { 'Fabric':
    ensure   => $ensure,
    provider => pip,
    require  => Package[$pkgs],
  }

}
