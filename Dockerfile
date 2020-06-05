FROM node:14-slim

LABEL maintainer="Rob Watson <rob@netflux.io>"

RUN apt-get update && apt-get install -y autoconf build-essential git libtool \
    libconfig-dev libssl-dev python3-dev

WORKDIR /src
RUN git clone https://github.com/libimobiledevice/libplist.git
WORKDIR /src/libplist
RUN ./autogen.sh
RUN make
RUN make install

WORKDIR /src
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git
WORKDIR /src/libusbmuxd
RUN ./autogen.sh
RUN make
RUN make install

WORKDIR /src
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
WORKDIR /src/libimobiledevice
RUN ./autogen.sh
RUN make
RUN make install

WORKDIR /src
RUN git clone https://github.com/google/ios-webkit-debug-proxy.git
WORKDIR /src/ios-webkit-debug-proxy
RUN ./autogen.sh
RUN make
RUN make install

RUN npm install -g remotedebug-ios-webkit-adapter

ENV LD_LIBRARY_PATH /usr/local/lib
ENTRYPOINT ["remotedebug_ios_webkit_adapter"]
