## Beanstalk docker image

_Beanstalkd_ is a simple, fast, workqueue service (a specific case of message queueing), in which messages are organized
 in "_tubes_". _Beanstalk_ clients can insert and consume messages into and from such tubes. The _beanstalk_ interface
 is generic, but was originally designed for reducing the latency of page views in high-volume web applications by
 running time-consuming tasks asynchronously.

This image is based on official `beanstalkd` package for debian and is built on top of [clover/common](https://hub.docker.com/r/clover/common/).

### Exposed ports
| Port | Description |
|---|---|
| 11300 | TCP port _beanstalkd_ is listening on |

### Enviroment variables
| Name | Default value | Description |
|---|---|---|
| `BEANSTALK_WAL_DIR` | `/var/lib/beanstalkd` | write-ahead log directory
| `BEANSTALK_LISTEN_ADDR` | `0.0.0.0` | listen on address
| `BEANSTALK_LISTEN_PORT` | `11300` | listen on port
| `BEANSTALK_FSYNC_MS` | `50` | fsync at most once every `FSYNC_MS` milliseconds (will never sync if _not set_; `0` means always fsync)
| `BEANSTALK_FSYNC_NEVER` | _not set_ | never fsync
| `BEANSTALK_MAX_JOB_SIZE` | `65535` | the maximum job size in bytes
| `BEANSTALK_WAL_FILE_SIZE` | `10485760` | the size of each wal file in bytes  (will be rounded up to a multiple of 512 bytes)
| `BEANSTALK_VERBOSE` | _not set_ | be more verbose (will be less verbose if _not set_)
| `PUID` | `50` | desired user id of the process owner _*_
| `PGID` | `50` | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | `beanstalk` | desired `PUID` user name
| `PGROUP` | `beanstalk` | desired `PGID` group name
| `CRON` | _not set_ | Will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | `UTC` | desired container timezone

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
