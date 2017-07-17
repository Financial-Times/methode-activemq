class methode_activemq::configure {
  user { 'activemq':
    ensure      => present,
    managehome  => true,
  }
  ->
  exec { 'change-file-ownership':
    command => "chown -R activemq: /opt/${methode_activemq::activemq}/",
    unless  => "ls -l /opt/${methode_activemq::activemq}/README.txt | grep -o 'activemq activemq'",
  }
  ->
  file { "/opt/${methode_activemq::activemq}/conf/activemq.xml":
    require => Exec['install-package'],
    notify => Service['activemq'],
    owner  => 'activemq',
    group  => 'activemq',
    source => "puppet:///modules/${module_name}/activemq.xml";
  }
  ->
  file { "/opt/${methode_activemq::activemq}/conf/jetty.xml":
    require => Exec['install-package'],
    notify => Service['activemq'],
    owner  => 'activemq',
    group  => 'activemq',
    source => "puppet:///modules/${module_name}/jetty.xml";
  }
  ->
  file { "/etc/init.d/activemq":
    mode    => "755",
    source => "puppet:///modules/${module_name}/activemq";
  }
}
