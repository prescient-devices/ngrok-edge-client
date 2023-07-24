#!/usr/bin/env bash
arch=$(uname -i)
image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz"
if [[ $arch == x86_64* ]]; then
    echo "X64 Architecture"
    image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
elif [[ $arch == i*86 ]]; then
    echo "X32 Architecture"
    image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz"
elif  [[ $arch == arm* ]]; then
    echo "ARM Architecture"
    image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz"
elif  [[ $arch == aarch64* ]]; then
    echo "ARM - 64 Architecture"
    image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz"
elif  [[ $arch == aarch* ]]; then
    echo "ARM - 32 Architecture"
    image="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz"
fi

if [ ! $(which wget) ]; then
    echo 'Please install wget package'
    exit 1
fi

if [ ! $(which unzip) ]; then
    echo 'Please install zip package'
    exit 1
fi

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi

if [ ! -e ngrok.service ]; then
    git clone --depth=1 https://github.com/prescient-devices/ngrok-edge-client.git
    cd ngrok-edge-client
fi

cp ngrok.service /lib/systemd/system/
mkdir -p /opt/ngrok
cp ngrok.yml /opt/ngrok
sed -i "s/<add_your_token_here>/$1/g" /opt/ngrok/ngrok.yml

cd /opt/ngrok
wget $image -O ngrok-installer.tgz
tar zxvf ngrok-installer.tgz
rm ngrok-installer.tgz
chmod +x ngrok

systemctl enable ngrok.service
systemctl start ngrok.service
