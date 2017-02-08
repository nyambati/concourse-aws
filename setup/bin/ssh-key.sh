#!/bin/bash

OUTPUT_DIR=$(dirname pwd)/config
DEFAULT_SSH_KEY_USER='bosh'
DEFAULT_SSH_PRIVATE_KEY_PATH="${OUTPUT_DIR}/concourse.key"
DEFAULT_SSH_PUBLIC_KEY_PATH="${OUTPUT_DIR}/concourse.key.pub"


echo "Ssh Key USer = $DEFAULT_SSH_KEY_USER"
echo "Private Key Path = $DEFAULT_SSH_PRIVATE_KEY_PATH"
echo "Public Key Path = $DEFAULT_SSH_PUBLIC_KEY_PATH"

create_ssh_key() {
  if [ -z "${SSH_KEY_USER}" ] && [ -z "${SSH_PRIVATE_KEY_PATH}" ]; then
    SSH_KEY_USER="${DEFAULT_SSH_KEY_USER}"
    SSH_PRIVATE_KEY_PATH="${DEFAULT_SSH_PRIVATE_KEY_PATH}"
    SSH_PUBLIC_KEY_PATH="${DEFAULT_SSH_PUBLIC_KEY_PATH}"

    ssh-keygen -N "" -t rsa -b 4096 -f "${SSH_PRIVATE_KEY_PATH}" -C "${SSH_KEY_USER}"
    echo "${SSH_KEY_USER}:$(cat ${SSH_PUBLIC_KEY_PATH})" > "${SSH_PUBLIC_KEY_PATH}"
  fi
}

create_ssh_key