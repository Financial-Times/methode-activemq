#!/usr/bin/env bash
#
# Jenkinsfile for methode-activemq workflow
#
# © jussi.heinonen@ft.com - 4.7.2017

DNS_TLD="cms.in.ft.com"
DNS_PROD="methode-activemq.prod.${DNS_TLD}"
DNS_TEST="methode-activemq.test.${DNS_TLD}"


echo "Project ${GIT_URL}, branch ${GIT_BRANCH} triggered a build"
REPO_LIST=( $(echo ${GIT_URL} | tr '/' ' ') )
REPO=$(echo ${REPO_LIST[-1]} | cut -d '.' -f 1)
BRANCHNAME=$(echo ${GIT_BRANCH} | cut -d '/' -f 2)

if [[ "${BRANCHNAME}" == "master" ]]; then
  echo "Deploying to ${DNS_PROD}"
elif [[ "${BRANCHNAME}" =~ "test_" ]]; then
  echo "Deploying to ${DNS_TEST}"
else
  echo "Deploying to ${REPO}.${BRANCHNAME}.${DNS_TLD}"
fi



#ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_id_rsa 10.170.37.239 "cd /opt/methode/methode-activemq && sudo git pull && sudo ./pipeline.sh"
