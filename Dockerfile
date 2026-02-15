# Use the official PostGIS image as base
FROM postgis/postgis:17-master

# Build steps need root to install into system dirs (e.g. make install for h3)
USER root

ENV CMAKE_VERSION=4.0.0

RUN  apt update && \
  apt install -y software-properties-common lsb-release && \
  apt clean all

# Install build dependencies for H3 (noninteractive + use maintainer config on conflicts)
# postgresql-server-dev-17 matches base image PostGIS 17 so CMake finds PostgreSQL_LIBRARY
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confnew" \
  build-essential \
  git \
  wget \
  postgresql-server-dev-17 \
  && rm -rf /var/lib/apt/lists/*

# Install CMAKE
RUN wget -q https://cmake.org/files/v4.0/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
RUN tar xzf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -C /usr/local --strip-components=1 --no-same-owner
RUN rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
RUN cmake --version

# Clone and install H3 extension (build for PostgreSQL 17 to match base image)
# -DPostgreSQL_INDENT= disables the format step (pgindent fails on PG17 with uninitialized $typedefs_file)
RUN git clone https://github.com/postgis/h3-pg.git /tmp/pgh3 \
  && cd /tmp/pgh3 \
  && cmake -B build -DCMAKE_BUILD_TYPE=Release -DPOSTGRESQL_VERSION=17 -DPostgreSQL_INDENT= \
  && cmake --build build \
  && cmake --install build --component h3-pg

# Init default user (shell script so POSTGRES_* vars are set at container startup)
COPY docker-entrypoint-initdb.d/01-user.sh /docker-entrypoint-initdb.d/01-user.sh
RUN chmod +x /docker-entrypoint-initdb.d/01-user.sh

# Create initialization script
RUN echo "CREATE EXTENSION IF NOT EXISTS postgis;" > /docker-entrypoint-initdb.d/01-extensions.sql 
RUN echo "CREATE EXTENSION IF NOT EXISTS h3;" >> /docker-entrypoint-initdb.d/01-extensions.sql 

# Expose PostgreSQL port
EXPOSE 5432

# Match base image: run as postgres when container starts
USER postgres
