#
# Update force_color_prompt and links bashrc for root
#
class utils::coloredbash () {
  exec { 'update_bashrc':
    command => '/bin/echo force_color_prompt=yes >> /etc/bash.bashrc',
    unless  => '/bin/grep "^force_color_prompt=yes$" /etc/bash.bashrc',
  }

  $dotlinks = ['bashrc', 'profile', 'bash_logout']
  each($dotlinks) |$x| {
    file { "/root/.${x}":
      ensure => link,
      target => "/etc/skel/.${x}",
    }
  }
}
