class utils::coloredbash () {
  exec { 'update_bashrc':
    command => '/bin/echo force_color_prompt=yes >> /etc/bash.bashrc',
    unless  => '/bin/grep "^force_color_prompt=yes$" /etc/bash.bashrc',
  }
}
