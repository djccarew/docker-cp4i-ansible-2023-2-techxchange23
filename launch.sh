#!/bin/bash
DOCKER_COMMAND=$(command -v docker || command -v podman)

if [ $? -ne 0 ]
then
  echo "Fatal error: podman or docker must be available in your PATH" >&2
  exit 1
fi

# $DOCKER_COMMAND run -it --rm --pull=always --platform=linux/amd64 -v $(pwd)/params:/ansible/group_vars quay.io/clouddragons/cp4i-vad-workshop-ansible:2022.4 /bin/bash
$DOCKER_COMMAND run -it --rm --platform=linux/amd64 -v $(pwd)/params:/ansible/group_vars quay.io/clouddragons/cp4i-vad-workshop-mt-ansible:2023.2 /bin/bash
