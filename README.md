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

## Run

There is no run tag in the playbook.
A small script 'ah' is placed in /usr/local/bin.
It'll run docker run -it for you. If no parameters are given then you enter in to the container, else it will run interactivly the given parameters.

To get the ansible enviroment run

```bash
ah
```

The following prompt shows that you are running inside the docker container.

```bash
root@ansible-helper [ /ansible/playbooks ]#
```

The folder from where you start ah is presented as a volume to /ansible/playbooks.

Alternative

You can run your ansible playbook or other command directly without entering the container, as follows

```bash
ah ansible-playbook playbook-lightsOut.yaml --tags run
```

This will run the command ansible-playbook directly inside the ansible container. The folder from which this is run needs to contain the playbook.
See also the original blog pos that inspired this idea.

## build and archive

It is also possible to only build, or build and archive the docker image.
Archiving is usefull when you want to use the same image on other docker instances.
I have it also running on a Synology DSM.

To only build the image.
The container will be stopped and removed before the image is rebuild.

```bash
ansible-playbook playbook-ansible.yaml --tags build
```

To only archive the image.

```bash
ansible-playbook playbook-ansible.yaml --tags archive_only
```

Importing an running the archived image on another docker instance

```bash
docker load < (name of archive).tar

```

## tags

Tags are used to run a selection of the tasks.
Run below code, to display the functions of the tags

```bash
ansible-playbook playbook-FAH.yaml --tags help
```

|tag|remove<br>image|build<br>image|Archive<br>image|Remove<br>build<br>folder|
|---|:---:|:---:|:---:|:---:|
|build|x|x||x
|build_only|x|x||x
||
|archive|x|x|x|x

## Todo
