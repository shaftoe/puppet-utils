#
class utils::packages () {

  $packages = hiera_array('packages_present')
  $packages.foreach {|$x|
    package {$x: ensure => present}
  }

  $toremove = hiera_array('packages_absent')
  $toremove.foreach {|$x|
    package {$x: ensure => absent}
  }

}
