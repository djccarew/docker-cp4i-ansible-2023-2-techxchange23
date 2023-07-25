# Cloud Pak for Integration v2022.4 Workshop Docker Container for the Student Lab Environment

This repo contains the source code for the Ansible playbooks to build the Docker container that installs the student environment for the [Enterprise-grade integration with Cloud Pak for Integration v2022.4 workshop](https://ibm.github.io/cloudpakforintegration-workshop/).


## Prerequisites

i. **podman** or **docker** installed on your local machine.

ii. **git** command line client.

iii. Clone this repo by running the following commands

```
   git clone git@github.ibm.com:carew/docker-cp4i-ansible.git
   cd docker-cp4i-ansible
```
iv. Download the API Connect toolkit utility **apic-slim** following [these instructions](https://www.ibm.com/docs/en/api-connect/10.0.5.x_lts?topic=configuration-installing-toolkit).

>*Note*: Make sure you download the  *Linux x86_84* version of the toolkit regardless of your computer's OS and architecture.

v. Extract the *apic-slim* executable from the downloaded zip file and copy it to the root folder of your local copy of this GitHub repo.


## Building the container with the Ansible scripts

i. Build the Docker container with the Ansible playbooks

```
  ./build.sh
```
>*Note*: Modify the image tag in the  *build.sh* file  with your unique image name 

## Using your custom image

i. Clone the companion repo (https://github.ibm.com/carew/cp4i-workshop-lab-env-setup) 

ii. Modify the file *launch.sh* to point to the custom image you built in the  previous section.

iii. Follow the instructions in the companion  repo README file to provision your CP4I Workshop env using your custom image
