class methode_activemq::service {
  service { 'activemq':
    enable      => true,
    ensure      => running,
    hasrestart  => true,
  }
}
