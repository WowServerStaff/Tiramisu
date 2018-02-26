FROM  debian:9

EXPOSE 8085 3724

ENV TC_DIR     /usr/local/trinitycore
ENV TC_REPO    git://github.com/TrinityCore/TrinityCore.git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y \
  git \
  cmake \
  make \
  gcc \
  g++ \
  libmariadbclient-dev \
  libssl1.0-dev \
  libbz2-dev \
  libreadline-dev \
  libncurses-dev \
  libboost-all-dev \
  mysql-server \
  p7zip \
  zlib1g \
  zlib1g-dev \
  libreadline-dev

RUN mkdir -p $TC_DIR && \
  cd $TC_DIR && \
  git clone -b 3.3.5 --depth 1 $TC_REPO

ADD build_core.sh /etc/build_core.sh
RUN chmod +x /etc/build_core.sh
RUN /etc/build_core.sh

ADD entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

ENV CONF_DIR   /opt/trinitycore/conf
ENV MAPS_DIR  /opt/trinitycore/maps

ENTRYPOINT  ["/etc/entrypoint.sh"]

ENV DEBIAN_FRONTEND newt
