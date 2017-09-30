#!/bin/bash

docker run --name elog --restart always -d -p 8080:8080 -v /data/docker/elog:/var/lib/elog cubian.phantasyworld.intern:5000/kdedesign/elog
