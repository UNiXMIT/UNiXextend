#!/bin/bash
# Start Informix Database with - oninit
# Stop Informix Database with - onmode -ky
# Both require to execute as ROOT
# Setup Guide - http://bit.ly/2LqdqD7

export INFORMIXDIR=/home/informix
export INFORMIXSERVER=informix
export ONCONFIG=onconfig
export INFORMIXTERM=terminfo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/informix/lib:/home/informix/lib/esql
export PATH=$PATH:/home/informix/bin
