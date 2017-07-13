class methode_activemq {
  # VARIABLE
  $activemq_version="5.14.4"
  $activemq="apache-activemq-${activemq_version}"
  $activemq_home="/opt/activemq"

  # RESOURCE DEFAULTS
  Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin' }

  # RESOURCES
  class { 'methode_activemq::install': }
  ->
  class { 'methode_activemq::configure': }
  ->
  class { 'methode_activemq::service': }
}
