#!/usr/bin/env bash

# This script installs or updates TSU server to the directory given by 
# SERVER_DIRECTORY.
#
# It then runs the server and checks its return value, updating and/or 
# restarting the server if requested.
#
# To work, there must be a working steamcmd.sh under directory steamcmd.

# source Settings.sh

RESTART=1
INSTALL=1

while [ $RESTART -eq 1 ]
do
    RESTART=0
    if [ $INSTALL -eq 1 ]
    then
        echo Trying to install server to /home/steam/TSU.
#        cd steamcmd
        ./steamcmd.sh +force_install_dir /home/steam/TSU +login anonymous +app_update 1815810 validate +quit
#        cd -
    fi
    INSTALL=0

    echo Trying to run TSUs.
    cd /home/steam/TSU
    ./TSUs.x86_64 -name $SERVER_NAME -port $TSU_PORT -admin $ADMIN_STEAMID -$DISCOVERY
    EXIT_VALUE=$?
    cd -

    if [ $EXIT_VALUE -eq 221 ]
    then
        echo Server quit and requested restart.
        RESTART=1
    elif [ $EXIT_VALUE -eq 222 ]
    then
       echo Server quit and requested upgrade.
       RESTART=1
       INSTALL=1
    fi
done

echo Quit, exit code: $EXIT_VALUE
