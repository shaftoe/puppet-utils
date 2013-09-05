#
class utils::packages () {

  $packages = hiera_array('packages')
  $packages.foreach {|$x|
    package {$x: ensure => present}
  }

}
