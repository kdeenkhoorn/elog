#!/bin/bash

docker run --name elog --restart always -d -p 127.0.0.1:8080:8080 -v /data/docker/elog:/var/lib/elog kdedesign/elog 
