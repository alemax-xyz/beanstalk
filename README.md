## Beanstalk docker image

Beanstalkd is a simple, fast, workqueue service (a specific case of message queueing), in which messages are organised in "tubes". Beanstalk clients can insert and consume messages into and from such tubes.
The beanstalk interface is generic, but was originally designed for reducing the latency of page views in high-volume web applications by running time-consuming tasks asynchronously.

This image is based on official beanstalkd package for Ubuntu Xenial and is built on top of [clover/base](https://hub.docker.com/r/clover/base/).
