# Basic sudoers rules
class utils::sudo ($ensure = present) {

  package {'sudo': ensure => $ensure}

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
  }

  file { '/etc/sudoers':
    ensure  => $ensure,
    require => Package['sudo'],
    source  => 'puppet:///modules/utils/sudo.default',
  }

  $users = hiera('users')
  $users.foreach { |$user, $value|
    if 'sudo' in $value['groups'] {

      $rule = $value['noasksudopass'] ? {
        true    => 'ALL=NOPASSWD:ALL',
        default => 'ALL=(ALL:ALL) ALL'
      }

      file {"/etc/sudoers.d/${user}":
        ensure  => $ensure,
        content => "${user} ${rule}\n",
      }

    } else {

      file {"/etc/sudoers.d/${user}":
        ensure  => absent,
      }

    }
  }
}
