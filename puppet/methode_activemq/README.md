# methode_activemq

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Project](#project)

## Description

Installs Apache ActiveMQ message broker on Redhat Linux


## Usage

To install default ActiveMQ v5.14.4 simply add the following statement into Puppet manifest

`include methode_activemq`

To install different version of ActiveMQ pass in parameter `activemq_version` in following way

`class { 'methode_activemq': version => '5.13.0' }`


## Project

Module is built by (Build ft-methode_activemq)[http://ftjen04481-lvpr-uk-p/job/Build%20ft-methode_activemq/]

Currently Jussi's project but if you want to get involved drop me a message on jussi.heinonen@ft.com.
