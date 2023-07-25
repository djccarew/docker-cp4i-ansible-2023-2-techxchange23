#!/bin/bash
DOCKER_COMMAND=$(command -v docker || command -v podman)

if [ $? -ne 0 ]
then
  echo "Fatal error: podman or docker must be available in your PATH" >&2
  exit 1
fi

$DOCKER_COMMAND build -t quay.io/clouddragons/cp4i-vad-workshop-mt-ansible:2023.2 .

