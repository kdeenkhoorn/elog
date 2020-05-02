# ELOG
This docker image is an armhf version of ELOG based on my own debian 9 linux image.

## Image dependencies:
- Volume /var/lib/elog for persistent storage
- Port: 8080 for web access to ELOG
- User: elog (uid: 2001)
- Group: elog (gid: 2001)

## Build characteristics: 
- Based on armhf debian 9 (kdedesign/debian-stretch:latest)

## More info:
- Check: https://github.com/kdeenkhoorn/elog
- Check: https://hub.docker.com/r/kdedesign/elog/

Have fun!

Kl@@s

