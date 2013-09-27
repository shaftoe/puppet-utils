class utils::commons () {
  include 'ntp'
  include 'postfix'
  include 'ssh::server'
  include 'syslog_ng'
  include 'utils::emptymotd'
  include 'utils::coloredbash'
  include 'utils::users'
  include 'utils::packages'
  include 'utils::disablerootaccess'
  include 'utils::skel'
  include 'utils::puppetagent'
}
