define utils::user () {

  $user = hiera_hash('users')[$name]

  group { $name:
    ensure => $user['ensure'],
    gid    => $user['gid'],
  }
    
  user { $name:
    ensure => $user['ensure'],
    gid    => $user['gid'],
    uid    => $user['uid'],
    home   => "/home/${name}",
    shell  => '/bin/bash',
  }

  File {
    owner  => $name,
    group  => $name,
  }

  if $user['ensure'] == 'present' {
    file { "/home/${name}":
      ensure => directory,
      mode   => '0750',
    }
    if $user['sshpubkey'] {
      file { "/home/${name}/.ssh":
        ensure => directory,
        mode   => '0700',
      }
      ssh_authorized_key { $name:
        ensure => $user['ensure'],
        key    => $user['sshpubkey'],
        type   => 'rsa',
        user   => $name,
      }
    }
  } else {
    file { "/home/${name}":
      ensure => absent,
      force  => true,
    }
  }

}
