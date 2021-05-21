# ansible-helper / deploy

## deploy.sh

This is the deployment script for deploying the ansible container in docker.

## preriquisites

- docker engine

## usage

To run the deployment run

``` #!\bin\bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/brtlvrs/ansible-helper/v2.9/deploy/deploy.sh)"
```

Of course you could use wget instead of curl.<br>
The script will create two executable file in /usr/local/bin called ah and ah-playbook<br>
This wrapper will execute a `docker run -it -rm -v <volumes> brtlivrs\pwcli:latest pwsh` command.
Giving you an ansible environment. the folder from which you run ah or ah-playbook is mounted under /pwsh. This is the working directory of the container.

It mounts the following volumes / files:

- ~/.ssh/id_rsa to /root/.ssh/id_rsa
- ˜/.ssh/id_rsa.pub to /root.ssh/id_rsa.pub
- $(pwd) to /ansible/playbooks
- /var/log/ansible/ansible.log as a volume to maintain logging