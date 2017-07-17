class methode_activemq::install {
  exec { 'install-package':
    command => "curl -s -S https://archive.apache.org/dist/activemq/${methode_activemq::activemq_version}/${methode_activemq::activemq}-bin.tar.gz | tar -xvz -C /opt",
    unless  => "test -d /opt/${methode_activemq::activemq}",
  }
  ->
  file { "${methode_activemq::activemq_home}":
    ensure  => 'link',
    target  => "/opt/${methode_activemq::activemq}"
  }
  ->
  exec { 'change-file-ownership':
    command => "chown -R activemq: /opt/${methode_activemq::activemq}/",
    unless  => "ls -l /opt/${methode_activemq::activemq}/README.txt | grep -o 'activemq activemq'",
  }

  case $::operatingsystem {
    'Alpine': {
      #package { 'openjdk8-jre-base': ensure => 'installed' }
      exec { 'install-java-alpine':
        command => 'apk add openjdk8-jre-base',
        unless  => 'test -L /usr/bin/java'
      }
    }
  }
}
