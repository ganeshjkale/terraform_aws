#!/bin/bash
echo "Setting SSH Key"
#ssh-add ~/<PATH TO SSH KEYFILE>.pem
echo "Adding IPs"
ssh-keyscan -H ec2-54-84-226-118.compute-1.amazonaws.com >> ~/.ssh/known_hosts
ssh-keyscan -H ec2-54-91-147-95.compute-1.amazonaws.com >> ~/.ssh/known_hosts
ssh-keyscan -H ec2-3-82-251-124.compute-1.amazonaws.com >>  ~/.ssh/known_hosts

