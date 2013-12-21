#
class utils::packages () {

  $packages = hiera_array('packages_present', [])
  each($packages) |$x| {
    package {$x: ensure => present}
  }

  $toremove = hiera_array('packages_absent', [])
  each($toremove) |$x| {
    package {$x: ensure => absent}
  }

}
