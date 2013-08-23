#
# Remove motd content
#
class utils::emptymotd () {

  case $::operatingsystem {
    'Ubuntu': {
      file { '/etc/update-motd.d/*':
        ensure  => absent,
      }
    }
    default: {
      file { '/etc/motd':
        content => '',
      }
    }
  }
}
