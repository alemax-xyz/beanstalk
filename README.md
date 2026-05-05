## Beanstalk docker image

_Beanstalkd_ is a simple, fast, workqueue service (a specific case of message queueing), in which messages are organized
 in "_tubes_". _Beanstalk_ clients can insert and consume messages into and from such tubes. The _beanstalk_ interface
 is generic, but was originally designed for reducing the latency of page views in high-volume web applications by
 running time-consuming tasks asynchronously.

This image is based on official `beanstalkd` package for debian and is built on top of [clover/common](https://hub.docker.com/r/clover/common/).

### Enviroment variables
| Name | Default value | Description |
|---|---|---|
| `BEANSTALK_WAL_DIR` | `/var/lib/beanstalkd` | write-ahead log directory
| `BEANSTALK_LISTEN_ADDR` | `0.0.0.0` | listen on address
| `BEANSTALK_LISTEN_PORT` | `11300` | listen on port
| `BEANSTALK_FSYNC_MS` | _not set_ (`50`) | fsync at most once every `FSYNC_MS` milliseconds (will never sync if _not set_; `0` means always fsync)
| `BEANSTALK_FSYNC_NEVER` | _not set_ | never fsync
| `BEANSTALK_MAX_JOB_SIZE` | _not set_ (`65535`) | the maximum job size in bytes
| `BEANSTALK_WAL_FILE_SIZE` | _not set_ (`10485760`) | the size of each wal file in bytes  (will be rounded up to a multiple of 512 bytes)
| `BEANSTALK_VERBOSE` | _not set_ | be more verbose (will be less verbose if _not set_)
| `PUID` | _not set_ | desired user id of the process owner _*_
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user) _*_
| `PUSER` | _not set_ | desired `PUID` user name _*_
| `PGROUP` | _not set_ | desired `PGID` group name _*_
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone


_*_ By default, `beanstalk` will be running as `beanstalk` user (`PUID=50`, `PGID=50`).
To launch under `root` specify `PUID=0`, `PGID=0`.
Custom `PUID`/`PGID` could be used to preserve data volume ownership on host.
Custom `PUSER`/`PGROUP` could be used to specify user and group names.

### Exposed ports
| Port | Description |
|---|---|
| `BEANSTALK_LISTEN_ADDR` (`11300`) | TCP port _beanstalkd_ is listening on |

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
