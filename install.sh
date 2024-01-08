#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2

# Install Docker
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
echo "Verifying Docker and Docker Compose installation..."
sudo docker --version
sudo docker-compose --version

# Download OpenCTI Docker Compose file
echo "Downloading OpenCTI Docker Compose file..."
curl -L https://raw.githubusercontent.com/colbik/docker_opencti/main/test.yml -o docker-compose.yml
curl -L https://raw.githubusercontent.com/colbik/docker_opencti/main/test.env -o docker-compose.env

# Create a directory for OpenCTI and move the Docker Compose file there
mkdir opencti
mv docker-compose.yml opencti/
mv docker-compose.env opencti/


# Navigate to OpenCTI directory
cd opencti

# Start OpenCTI
echo "Starting OpenCTI..."
sudo docker-compose --env-file /home/jirik/opencti/docker-compose.env up -d

# Display completion message
echo "OpenCTI should now be running. Access it via http://opencti.datasense.poc:8080 (or your server IP address)"
