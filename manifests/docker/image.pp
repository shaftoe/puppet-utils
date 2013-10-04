# Pull image from public index
define utils::docker::image () {

  require 'utils::docker'

  exec {"pull_${title}":
    command => "${::utils::docker::bin} pull ${title}",
    unless  => "${::utils::docker::bin} images | /bin/grep ${name}",
  }

}
