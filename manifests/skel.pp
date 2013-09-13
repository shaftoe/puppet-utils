#
# Setup skel dotfiles
#
class utils::skel() {
  file { '/etc/skel/.bashrc':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => 'puppet:///modules/utils/bashrc',
  }

}
