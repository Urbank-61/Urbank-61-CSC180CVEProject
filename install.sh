#!/bin/bash
echo "Installing MySQL Server and dependencies"
apt-get update && apt-get install -y mysql-server
echo "Running vulnerability simulation..."
# Simulated exploit happens here
