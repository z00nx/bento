#!/bin/bash -eux
sudo apt-get update
sudo apt-get install -y jq
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 22598A94
cd /usr/local/bin/
curl https://api.github.com/repos/sans-dfir/sift-cli/releases/latest | jq .assets[0].browser_download_url | xargs wget -N
curl https://api.github.com/repos/sans-dfir/sift-cli/releases/latest | jq .assets[1].browser_download_url | xargs wget -N
gpg --verify sift-cli-linux.sha256.asc
shasum -a 256 -c sift-cli-linux.sha256.asc
mv sift-cli-linux sift
chmod +x sift
rm sift-cli-linux.sha256.asc
apt-get purge -y jq
apt-get autoremove --purge
sift install --user=vagrant --mode=packages-only
rm -rf /var/cache/sift
