This is a docker image for running a Turbo Sliders Unlimited dedicated server.
Image is based on cm2network/steamcmd. It does not include TSU server binaries, but the entrypoint script (Run.sh) downloads, installs and runs the server. This script is slightly modified version of the script found in the official server installation package (https://www.turbosliders.com/help/dedicated-servers).

The server is installed in /home/steam/TSU and the user inside the container is "steam" with UID=1000.

Default ports used by the server are 7755 (server itself) and 7756 (query port). If you want to run multiple servers on one host, you need to define ports that are not overlapping each other. Variable TSU_PORT can be used to change the port, query port will automatically be TSU_PORT+1 (remember to open both of them on the host firewall, server only uses udp). 

Other variables that can and should be used are SERVER_NAME, to give your server a distinct name on the server browser list (default is "TSUinaContainer") and ADMIN_STEAMID for adding rcon possibilities on the server.

If you are interested in adding more maps, backing up config, logs or results, you should definitely map the server's config directory (home/steam/TSU/config) to your host with the switch -v.

examples:
1) "I just want to play!" (default port, no admin, default server name in the in-game browser)
```sh
  docker run -d --net=host mmvv/tsu_server:latest
```
2) "Well, would be nice to see my name there" (default port, no admin)
```sh
  docker run -d --net=host -e SERVER_NAME='my name' mmvv/tsu_server:latest
```
3) "I want some control on my server!" (still, default port)
```sh
  docker run -d --net=host -e SERVER_NAME='my name' -e ADMIN_STEAMID='steamid' mmvv/tsu_server:latest
```
4) "I want it all!"
```sh
  docker run -d --net=host -v /path/on/host:/home/steam/TSU/config -e TSU_PORT=7757 -e SERVER_NAME='my name' -e ADMIN_STEAMID='steamid' --name='name of my container'  mmvv/tsu_server:latest
```
5) While the container is running, you can pop in to it with command
```sh
  docker exec -ti 'name of my container' bash
```
6) Clean exit for TSU server for any maintenance work (before docker stop/restart)
```sh
  docker exec 'name of my container' /home/steam/Quit.sh
```
