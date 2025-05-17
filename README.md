# Suricata Docker Image

This repository contains a Docker setup for building and running Suricata, an open-source network threat detection engine, from source. The image is based on Debian Bookworm and includes all necessary dependencies.

## Features

- Suricata version 7.0.10
- Built with libpcap, libnet, and other essential libraries
- Includes Rust and Cargo for building
- Configurable via environment variables
- Volumes for configuration, logs, and rules

## Getting Started

### Prerequisites

- Docker installed on your machine

### Building the Docker Image

To build the Docker image, run the following command in the root of the project:

```bash
docker build -t suricata .
```

### Running Suricata

To run Suricata using the built Docker image:

```bash
docker run --rm -v /path/to/config:/usr/local/etc/suricata -v /path/to/logs:/usr/local/var/log/suricata -v /path/to/rules:/usr/local/var/lib/suricata suricata
```

Replace `/path/to/config`, `/path/to/logs`, and `/path/to/rules` with the paths to your Suricata configuration, logs, and rules directories, respectively.

### Environment Variables

- `DEBIAN_FRONTEND`: Set to `noninteractive` to avoid prompts during package installation.
- `LIBNG_VERSION`: Version of libcap-ng to be installed.
- `SURICATA_VERSION`: Version of Suricata to be installed.

### Volumes

- `/usr/local/etc/suricata`: Configuration files
- `/usr/local/var/log/suricata`: Log files
- `/usr/local/var/lib/suricata`: Rule files

### Exposed Ports

The Dockerfile includes commented-out `EXPOSE` instructions for ports 514, 2055, 6055, and 10000. Uncomment these lines if you need to expose these ports.

## Maintainer

- noopduck@dev.null

## License

This project is licensed under the terms of the MIT license.
