define utils::user () {

  $user = hiera_hash('users')[$name]

  group { $name:
    ensure => $user['ensure'],
    gid    => $user['gid'],
  }

  user { $name:
    ensure   => $user['ensure'],
    gid      => $user['gid'],
    uid      => $user['uid'],
    home     => "/home/${name}",
    shell    => '/bin/bash',
    password => $user['password'],
    groups   => $user['groups'],
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
    $dotlinks = ['bashrc', 'profile', 'bash_logout']
    $dotlinks.foreach { |$x|
      file { "/home/${name}/.${x}":
        ensure => link,
        target => "/etc/skel/.${x}",
      }
    }
    if $user['sshpubkey'] {
      file { "/home/${name}/.ssh":
        ensure => directory,
        mode   => '0700',
      }
      ssh_authorized_key { $name:
        ensure  => $user['ensure'],
        key     => $user['sshpubkey'],
        type    => 'rsa',
        user    => $name,
        require => File["/home/${name}/.ssh"],
      }
    }
  } else {
    file { "/home/${name}":
      ensure => absent,
      force  => true,
    }
  }

}
