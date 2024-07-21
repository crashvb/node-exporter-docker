# node-exporter-docker

[![version)](https://img.shields.io/docker/v/crashvb/node-exporter/latest)](https://hub.docker.com/repository/docker/crashvb/node-exporter)
[![image size](https://img.shields.io/docker/image-size/crashvb/node-exporter/latest)](https://hub.docker.com/repository/docker/crashvb/node-exporter)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/node-exporter-docker.svg)](https://github.com/crashvb/node-exporter-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [node-exporter](https://prometheus.io/docs/guides/node-exporter/).

## Entrypoint Scripts

### node-exporter

The embedded entrypoint script is located at `/etc/entrypoint.d/node-exporter` and performs the following actions:

1. A new node-exporter configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | NODE\_EXPORTER\_USERS| prometheus | The list of users to be allowed access. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ entrypoint.d/
│  │  └─ node-exporter
│  ├─ healthcheck.d/
│  │  └─ node-exporter
│  ├─ node-exporter/
│  │  └─ web-config.yml
│  └─ supervisor/
│     └─ config.d/
│        └─ node-exporter.conf
├─ run/
│  └─ secrets/
│     ├─ node-exporter.crt
│     ├─ node-exporter.key
│     └─ node-exporterca.crt
└─ var/
   └─ lib/
      └─ node-exporter/
```

### Exposed Ports

* `9100/tcp` - Node exporter server listening port.

### Volumes

* `/etc/node-exporter` - Node exporter configuration directory.

## Development

[Source Control](https://github.com/crashvb/node-exporter-docker)

