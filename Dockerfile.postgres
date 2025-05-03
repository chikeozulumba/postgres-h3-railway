# Use the official PostGIS image as base
FROM postgis/postgis:16-3.4

ENV CMAKE_VERSION=4.0.0

RUN  apt update && \
  apt install -y software-properties-common lsb-release && \
  apt clean all

# Install build dependencies for H3
RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  wget \
  postgresql-server-dev-16 \
  && rm -rf /var/lib/apt/lists/*

# Install CMAKE
RUN wget -q https://cmake.org/files/v4.0/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
RUN tar xzf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -C /usr/local --strip-components=1 --no-same-owner
RUN rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
RUN cmake --version

# Clone and install H3 extension
RUN git clone https://github.com/zachasme/h3-pg.git /tmp/pgh3 \
  && cd /tmp/pgh3 \
  && make \
  && make install

# Create initialization script
RUN echo "CREATE EXTENSION IF NOT EXISTS postgis;" > /docker-entrypoint-initdb.d/01-extensions.sql \
  && echo "CREATE EXTENSION IF NOT EXISTS h3;" >> /docker-entrypoint-initdb.d/01-extensions.sql

# Expose PostgreSQL port
EXPOSE 5432 
