#!/usr/bin/env bash

# This script quits a running server by writing quit command to
# autorun.src in server directory.

#source Settings.sh

echo Quitting TSU server

echo /broadcast Server quitting... > autorun.tmp
echo /quit >> autorun.tmp
mv autorun.tmp /home/steam/TSU/autorun.src
