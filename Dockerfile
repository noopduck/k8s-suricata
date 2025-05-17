FROM debian:bookworm

LABEL maintainer="noopduck@dev.null"
LABEL description="Suricata built from source with libpcap, libnet, and other dependencies"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LIBNG_VERSION=0.8.5
ENV SURICATA_VERSION=7.0.10

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  autoconf \
  automake \
  libtool \
  libpcap-dev \
  libnet1-dev \
  libyaml-dev \
  zlib1g-dev \
  libmagic-dev \
  libjansson-dev \
  libpcre2-dev \
  rustc \
  cargo \
  pkg-config \
  git \
  curl \
  ca-certificates \
  python3-yaml \
  python3 \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

# Download and build Suricata
WORKDIR /opt

RUN curl -LO https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-${LIBNG_VERSION}.tar.gz && \
  tar -xvzf libcap-ng-${LIBNG_VERSION}.tar.gz && \
  cd libcap-ng-${LIBNG_VERSION} && \
  ./configure && \
  make -j "$(nproc)" && \
  make install && \
  cd ..


RUN curl -LO https://www.openinfosecfoundation.org/download/suricata-${SURICATA_VERSION}.tar.gz && \
  tar -xvzf suricata-${SURICATA_VERSION}.tar.gz && \
  cd suricata-${SURICATA_VERSION} && \
  ./configure && \
  make -j"$(nproc)" && \
  make install-full && \
  ldconfig

# Clean up source
RUN rm -rf /opt/suricata-${SURICATA_VERSION} /opt/suricata-${SURICATA_VERSION}.tar.gz

RUN adduser suricata

# Create volumes for configuration, logs, and rules
VOLUME ["/usr/local/etc/suricata", "/usr/local/var/log/suricata", "/usr/local/var/lib/suricata"]

# Expose the default Suricata stats and log ports (if used)
#EXPOSE 514 2055 6055 10000

COPY ./entrypoint.sh /opt/entrypoint.sh

RUN chmod +x /opt/entrypoint.sh

# Default command
ENTRYPOINT [ "/opt/entrypoint.sh" ]

