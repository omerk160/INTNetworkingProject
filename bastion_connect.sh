#!/bin/bash

#KEY_PATH=/home/omer/omerNetworkingPTJkeypair.pem
KEY_PATH_2=/home/ubuntu/id_rsa
#KEY_PATH_2=~/.ssh/id_rsa
# Check if KEY_PATH environment variable is set
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check the number of arguments
if [ "$#" -lt 1 ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

# Assign variables
BASTION_IP=$1
PRIVATE_IP=$2
COMMAND=$3

# If only bastion IP is provided, connect to the bastion host
if [ -z "$PRIVATE_IP" ]; then
  ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP"
else
  # If both bastion IP and private IP are provided, connect to the private host through the bastion host
  if [ -z "$COMMAND" ]; then
    ssh -t -i "$KEY_PATH" ubuntu@"$BASTION_IP" "ssh -i /home/ubuntu/id_rsa ubuntu@$PRIVATE_IP"
  else
    ssh -t -i "$KEY_PATH" ubuntu@"$BASTION_IP" "ssh -i /home/ubuntu/id_rsa ubuntu@$PRIVATE_IP '$COMMAND'"
  fi
fi

