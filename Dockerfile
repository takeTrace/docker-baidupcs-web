# acknowledge: https://github.com/SuperNG6/docker-baidupcs-web/blob/master/Dockerfile
# acknowledge: https://hub.docker.com/r/rdvde/baidupcs
# acknowledge: https://github.com/masx200/baidupcs-web/releases
FROM lsiobase/alpine:latest

# set label
LABEL maintainer="taketrace"

COPY root /

RUN apk add curl

RUN curl --silent "https://api.github.com/repos/masx200/baidupcs-web/releases/latest" | grep '"tag_name":' | \
sed -E 's/.*"([^"]+)".*/\1/' | \
xargs -I {} curl -sOL "https://github.com/masx200/baidupcs-web/releases/download/"{}/BaiduPCS-Go-v{}'-linux-amd64.zip'
RUN unzip BaiduPCS-Go-*.zip \
&& rm -rf BaiduPCS-Go-*.zip \
&& rm -rf /usr/bin/BaiduPCS-Go \
&& mv BaiduPCS-Go-*/BaiduPCS-Go /usr/bin/BaiduPCS-Go \
&& rm -rf BaiduPCS-Go-* \
&& chmod a+x /usr/bin/BaiduPCS-Go

VOLUME /root/Downloads /config
EXPOSE 5299