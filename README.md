## Beanstalk docker image

_Beanstalkd_ is a simple, fast, workqueue service (a specific case of message queueing), in which messages are organized in "_tubes_".
_Beanstalk_ clients can insert and consume messages into and from such tubes.
The _beanstalk_ interface is generic, but was originally designed for reducing the latency of page views in high-volume web applications by running time-consuming tasks asynchronously.

This image is based on official _beanstalkd_ package for Ubuntu Bionic and is built on top of [clover/base](https://hub.docker.com/r/clover/base/).

### Data volumes
| Location | Description |
|---|---|
| `/var/lib/beanstalkd` | wal directory |

### Exposed ports
| Port | Description |
|---|---|
| 11300 | TCP port _beanstalkd_ is listening on |

### Enviroment variables
| Name | Default value | Description |
|---|---|---|
| `FSYNC_MS` | _not set_ | fsync at most once every `FSYNC_MS` milliseconds (will never sync if _not set_; `0` means always fsync) |
| `MAX_JOB_SIZE` | `65535` | the maximum job size in bytes |
| `WAL_FILE_SIZE` | `10485760` | the size of each wal file in bytes  (will be rounded up to a multiple of 512 bytes) |
| `DONT_COMPACT_BINLOG` | _not set_ | do not compact the binlog (will compact the binlog if _not set_) |
| `VERBOSE` | _not set_ | be more verbose (will be less verbose if _not set_) |
| `PUID` | `50` | Desired _UID_ of the process owner _*_ |
| `PGID` | primary group id of the _UID_ user (`50`) | Desired _GID_ of the process owner _*_ |

_*_ `PUID`/`PGID` could be used to preserve data volume ownership on host.
