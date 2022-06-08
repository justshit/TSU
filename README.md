This is a docker image for running a Turbo Sliders Unlimited dedicated server.
Image is based on cm2network/steamcmd. It does not include TSU server binaries, but the entrypoint script (Run.sh) downloads, installs and runs the server. This script is slightly modified version of the script found in the official server installation package (https://www.turbosliders.com/help/dedicated-servers).

The server is installed in /home/steam/TSU and the user inside the container is "steam" with UID=1000.

Default ports used by the server are 7755 (server itself) and 7756 (query port). If you want to run multiple servers on one host, you need to define ports that are not overlapping each other. Variable TSU_PORT can be used to change the port, query port will automatically be TSU_PORT+1 (remember to open both of them on the host firewall, server only uses udp). 

Other variables that can and should be used are SERVER_NAME, to give your server a distinct name on the server browser list (default is "TSUinaContainer") and ADMIN_STEAMID for adding rcon possibilities on the server. Also, if you want to have private fun, use variable DISCOVERY with value "hidden". Server will not bee visible on the in-game browser, but you and your friends can connect with the IP of the host.

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
3) "I want some control on my private server!" (still, default port)
```sh
  docker run -d --net=host -e SERVER_NAME='my name' -e ADMIN_STEAMID='steamid' -e DISCOVERY=hidden mmvv/tsu_server:latest
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
7) To run without giving the container access to the host network interface you need to expose the udp ports
```sh
  docker run -d -p 7755:7755/udp -p 7756:7756/udp mmvv/tsu_server:latest
```
8) You can use `relay`-mode to run the server e.g. behind a NAT without having to worry about opening ports at your firewall (connect manually using the steam id printed on the server console or add a port forwarding for the query port to show your server in the server browser)
```sh
  docker run -d -e RELAY=true -p 7755:7755/udp -p 7756:7756/udp mmvv/tsu_server:latest
```
9) Host a hidden game for a LAN party on an alternative port without giving the container access to the host network interface (connect manually using the host ip address and your exposed port. 7777 in this example)
```sh
  docker run -d -e SERVER_NAME="TSU LAN server" -e RELAY=false -e DISCOVERY=hidden -p 7777:7755/udp -p 7778:7756/udp mmvv/tsu_server:latest
```
