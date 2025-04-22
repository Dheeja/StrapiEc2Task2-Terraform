#!/bin/bash
yum update -y && yum upgrade -y

# Install Node.js 18
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Install yarn globally
npm install -g yarn

cd /home/ec2-user

# Clone the repository
git clone https://github.com/Dheeja/Strapi-Task2-deploytoEC2Dock.git
cd Strapi-Task2-deploytoEC2Dock/strapi-app

# Install dependencies
yarn install

# Optional: build project (may fail on low memory)
yarn build
yarn start