# !/bin/bash

SSH_KEY_PATH=$(terraform output -raw key_pass)
USER=$(terraform output -raw user)
HOST=$(terraform output -raw host_ip)

ssh -i ${SSH_KEY_PATH} ${USER}@${HOST}
