#!/usr/bin/env bash

#  pipeline.sh contains the build and deployment logic.
#
#
#  copyright jussi.heinonen@ft.com, 27.06.2017

#  git pull
#  pipeline.sh --checkout=[branch or tag]

declare -A ARGS #  Initialise associative array for command line arguments
DEFAULT_TAG="dev"
IMAGE_NAME="methode-activemq"
SERVICE_NAME="activemq"

#  move into root of the repository
cd $(dirname $0)

#  Source the sh/functions.sh
. sh/functions.sh

gitPull() {
  info "Pull latest changes from git repository $(git config --local --get remote.origin.url)"
  git pull || errorAndExit "Failed to pull from Git. Exit 1." 1

}

usage() {
  echo "USAGE: $0 [--checkout=branch or tag] [--tag=dev"]
  exit 0
}

processCliArgs $*

test -z "${ARGS[--help]}" || usage

#  Ensure we have the latest code base
gitPull

#  Checkout Git branch or tag if specified, -n option stands for non-zero
test -n "${ARGS[--checkout]}" || git checkout ${ARGS[--checkout]}

#  Set Docker image:tag name default unless --image parameter was provided
test -z "${ARGS[--tag]}" || ARGS[--image]=${DEFAULT_TAG}

#  Build docker image
docker build -t ${IMAGE_NAME}:${ARGS[--tag]} .

# Restart running activemq process
service ${SERVICE_NAME} restart