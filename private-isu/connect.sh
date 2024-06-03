#!/bin/bash

SSH_KEY_NAME=$(terraform output -raw ssh_key)
HOST=$(terraform output -raw instance_host)

echo using ssh key: ${SSH_KEY_NAME}
ssh -i ./.ssh/${SSH_KEY_NAME}.pem ubuntu@${HOST}