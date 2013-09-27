# http://michael.gorven.za.net/raspberrypi/xbmc
class utils::raspian_xbmc ($ensure = present) {

  require 'utils::users'

  apt::source { 'raspian_xbmc':
    location          => 'http://archive.mene.za.net/raspbian/',
    release           => 'wheezy',
    repos             => 'contrib',
    key               => '5243CDED',
    key_server        => 'keyserver.ubuntu.com',
    pin               => '-10',
    include_src       => true
  }

  package { 'xbmc':
    ensure  => $ensure,
    require => [
      Apt::Source['raspian_xbmc'],
      User['xbmc'],
    ],
  }

}
