#!/usr/bin/env bash
#
# Jenkinsfile for methode-activemq workflow
#
# © jussi.heinonen@ft.com - 4.7.2017

ENV_PROD="methode-activemq.prod.cms.in.ft.com"
ENV_TEST="methode-activemq.test.cms.in.ft.com"

echo "Project ${GIT_URL}, branch ${GIT_BRANCH} triggered a build"
REPO_LIST=( $(echo ${GIT_URL} | tr '/' ' ') )
REPO=$(echo ${REPO_LIST[-1]} | cut -d '.' -f 1)
BRANCHNAME=$(echo ${GIT_BRANCH} | cut -d '/' -f 2)
echo "Creating stack ${REPO}-${BRANCHNAME}"

#ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_id_rsa 10.170.37.239 "cd /opt/methode/methode-activemq && sudo git pull && sudo ./pipeline.sh"
