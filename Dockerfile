FROM cm2network/steamcmd

ENV TSU_PORT=7755
ENV TSU_QUERY=7756
ENV ADMIN_STEAMID=0
ENV SERVER_NAME=TSUinaContainer
ENV DISCOVERY=public

EXPOSE $TSU_PORT/udp
EXPOSE $TSU_QUERY/udp

ADD Run.sh /home/steam/
ADD Quit.sh /home/steam/

USER steam

RUN mkdir -p /home/steam/TSU && chown 1000:1000 /home/steam/TSU

ENTRYPOINT ["/home/steam/Run.sh"]
