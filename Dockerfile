FROM cm2network/steamcmd

ENV TSU_PORT=7755
ENV TSU_QUERY=7756
ENV ADMIN_STEAMID=0
ENV SERVER_NAME=TSUinaContainer

EXPOSE $TSU_PORT/udp
EXPOSE $TSU_QUERY/udp

ADD Run.sh /home/steam/

USER steam
ENTRYPOINT ["/home/steam/Run.sh"]
