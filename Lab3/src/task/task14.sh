#!/bin/bash

dpkg-scanpackages --multiversion . /dev/null > Packages

nano Release <<EOF
Origin: Local Repo
Label: Local Repo
Suite: stable
Version: 1.0
Codename: myrepo
Architectures: amd64
Components: main
Descripion: Local APT Repository
<<EOF

sudo apt install apt-utils
apt-ftparchive release . >> Release
