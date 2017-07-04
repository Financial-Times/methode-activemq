#!/usr/bin/env bash
#
# Jenkinsfile for methode-activemq workflow
#
# © jussi.heinonen@ft.com - 4.7.2017

#  move into root of the script directory
cd $(dirname $0)
#  Source the sh/functions.sh
. functions.sh

DNS_TLD="cms.in.ft.com"
DNS_PROD="methode-activemq.prod.${DNS_TLD}"
DNS_TEST="methode-activemq.test.${DNS_TLD}"


echo "Project ${GIT_URL}, branch ${GIT_BRANCH} triggered a build"
REPO_LIST=( $(echo ${GIT_URL} | tr '/' ' ') )
REPO=$(echo ${REPO_LIST[-1]} | cut -d '.' -f 1)
BRANCHNAME=$(echo ${GIT_BRANCH} | cut -d '/' -f 2)

if [[ "${BRANCHNAME}" == "master" ]]; then
  DNS_NAME="${DNS_PROD}"
elif [[ "${BRANCHNAME}" =~ "test_" ]]; then
  DNS_NAME="${DNS_TEST}"
else
  DNS_NAME="${REPO}.${BRANCHNAME}.${DNS_TLD}"
fi
echo "Deploying to ${DNS_NAME}"
validateDnsName ${DNS_NAME}

ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_id_rsa ${DNS_NAME} "cd /opt/methode/methode-activemq && sudo git pull && sudo ./pipeline.sh"
