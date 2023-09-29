#!/bin/bash
# /etc/profile.d/profile.sh
[ -d "/opt/microfocus/EnterpriseDeveloper/bin" ] && . /opt/microfocus/EnterpriseDeveloper/bin/cobsetenv
export PATH=$PATH:~/AcuSupport/AcuScripts:~/MFSupport/MFScripts
export TERM=xterm
