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

# Create .env file
cat <<EOF > .env
HOST=0.0.0.0
PORT=1337
APP_KEYS=someAppKey
API_TOKEN_SALT=someSalt
ADMIN_JWT_SECRET=someSecret
JWT_SECRET=someJWTSecret
EOF


# Install dependencies
yarn install

# Optional: build project (may fail on low memory)
yarn build
yarn start