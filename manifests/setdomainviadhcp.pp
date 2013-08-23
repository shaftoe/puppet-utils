#
# Edit dhclient config to use provided domainname
#
class utils::setdomainviadhcp ($domainname = 'mydomain') {
  $string = "supersede domain-name \"${domainname}\";"
  exec { 'update_dhcpclient':
    command => "/bin/echo '${string}' >> /etc/dhcp/dhclient.conf",
    unless  => "/bin/grep '${string}' /etc/dhcp/dhclient.conf",
    notify  => Service['networking'],
  }

  service {'networking':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }

}
