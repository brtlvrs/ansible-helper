#! /bin/bash

## create ansible-helper wrapper to run the pwcli container interactively

echo "Installing ansible helper wrapper in /usr/local/bin/ah"
rm -f /usr/local/bin/ah
cat > /usr/local/bin/ah << 'EOF'
#!/usr/bin/env bash
#
#  A script wrapper for running the docker image ansible-helper interactively
#

docker_img="brtlvrs/ansible:latest"

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible/playbooks \
  -v /var/log/ansible/ansible.log \
  $docker_img "$@"  
EOF

chmod +x /usr/local/bin/ah


## create ansible-helper wrapper to run the ah-playbook container interactively

echo "Installing ansible helper wrapper in /usr/local/bin/ah-playbook"
rm -f /usr/local/bin/ah-playbook
cat > /usr/local/bin/ah-playbook << 'EOF'
#!/usr/bin/env bash

docker_img="ansible:latest"

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible/playbooks \
  -v /var/log/ansible/ansible.log \
  $docker_img ansible-playbook "$@"
EOF
chmod +x /usr/local/bin/ah-playbook