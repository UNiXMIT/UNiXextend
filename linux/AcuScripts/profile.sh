#!/bin/bash
# /etc/profile.d/profile.sh
[ ! -d "~/AcuSupport" ] && cd ~/AcuSupport
[ ! -d "/opt/microfocus/EnterpriseDeveloper/bin" ] && . /opt/microfocus/EnterpriseDeveloper/bin
export PATH=$PATH:~/AcuSupport/AcuScripts:~/MFSupport/MFScripts
export TERM=xterm
