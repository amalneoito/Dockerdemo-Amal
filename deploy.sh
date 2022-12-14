name: Build and deploy to MASTER branch

on:
  push:
    branches: [master]

jobs:
  Backenduat:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout source code
        uses: actions/checkout@main

      - name: Build Backend
        run: |
          sudo npm i --force

      - name: Install SSH key
        uses: shimataro/ssh-key-action@v2
        with:
          key: ${{ secrets.VM_SSH_KEY }}
          name: id_rsa # optional
          known_hosts: ${{ secrets.VM_KNOWN_HOSTS }}
          if_key_exists: fail # replace / ignore / fail; optional (defaults to fail)

      - name: git pull and npm install
        run: |
          ssh -o StrictHostKeyChecking=no ${{ secrets.VM_USERNAME}}@${{ secrets.VM_KNOWN_HOSTS_ }}
          ssh -o StrictHostKeyChecking=no ${{ secrets.VM_USERNAME }}@${{ secrets.VM_HOST }} "cd /home/ubuntu/Dockerdemo-Amal/;git pull;npm install --force;docker stop demo-docker-amal;docker rm demo-docker-amal;docker run -d -p 49160:8080 --name=demo-docker-amal amalkr/deockerdemo-node-web-app;"
  
