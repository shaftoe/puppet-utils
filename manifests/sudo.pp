# Basic sudoers rules
class utils::sudo ($ensure = present) {

  group { 'sudo': ensure => $ensure }

  package {'sudo':
    ensure  => $ensure,
    require => Group['sudo'],
  }

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    require => Package['sudo'],
  }

  file { '/etc/sudoers':
    ensure  => $ensure,
    source  => 'puppet:///modules/utils/sudo.default',
  }

  $users = hiera('users')
  each($users) |$user, $value| {
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
