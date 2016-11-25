#!/bin/bash

set -xe

# If user don't provide any command
# Start the ELK server
# Run as user "elk"
if [[ "$1" == "" ]]; then
    ansible-playbook
else
    # Else allow the user to run arbitrarily commands like bash
    exec "$@"
fi
