# Brtlvrs Ansible-Helper project

|version| 0.0.1 | [MIT license](LICENSE)|Copyright (c) 2020 Bart Lievers|[blog](https://vblog.bartlievers.nl)|
|---|---|---|---|---|

This repository contains my approach for building, maintaining an running a ansible docker container.
This is based on this [blog](https://ruleoftech.com/2017/dockerizing-all-the-things-running-ansible-inside-docker-container).

## Ansible-Helper container

An Ansible-Helper container is a docker image containing al the bits & bytes to run ansible, to be used to run interactivly with docker.

## Goal

Besides getting expierence with Ansible, Docker, git etc...  using the docker interactive run features to run ansible in a box without installing it in the host OS.
The playbook will install a small bash script in /usr/local/bin named ah (ansible-helper). It executes docker run -it with the ansible image, presenting you boxed enviroment with ansible.

In this way you can use a certian version of ansible, without having it installed in your host OS and having issues with dependancies when updating packages.

## History

|version|Ansible<br>version|History|
|---|---|---|
|0.2|2.9.0|moved from ansible playbook, to scripts for building ansible image
|0.0.1|2.9.0|start

## My environment

My docker containers run on VMware photon OS.
A docker image containing Ansible, prepped to run in interactive mode.

Details:
|||||
|---|---|---|---|
|VM|||
||Virtualization| vmware|
||Operating System| VMware Photon OS/Linux| 
||Kernel| Linux 4.19.104-1.ph3-esx|
||Architecture|x86-64|
|Ansible| | |
||version|2.8.3|
||python|2.7.17|
|Docker|||
|| Engine| Community |
||version|18.09.9|
|Ansible Image||||
||From| Alpine|3.7
|||Ansible|2.9.0|

## build

To build the ansible-helper image execute 
```bash
./install
```

This will build the docker image ansible:2.9.0 and copy bash scripts to /usr/local/bin

## Run

To run ansible helper use
cmd| explenation
|---|---|
ah| ansible helper cmdlet, use the ansible cmdlets as arguments.
ah-playbook| run ansible-playbook cmdlet. Alternative to 'ah ansible-playbook'

### how it works

Both ah and ah-playbook will run the following 
```bash
docker_img="ansible:latest"

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible/playbooks \
  -v /var/log/ansible/ansible.log \
  $docker_img "$@"
```

This will run a docker container interactively with the ansible:latest image. It will mount the id_rsa files, making it possible to connect to the local host. And mounts the local folder under /ansible/playbooks.
ah-playbook command ends withansible-playbook "$@" instead of only "$@"

See the example folder for an example of an ansible structure you can use.