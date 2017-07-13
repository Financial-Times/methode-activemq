#!/usr/bin/env bash
puppet apply --modulepath=. -e 'include methode_activemq'
