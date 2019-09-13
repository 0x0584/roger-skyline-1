#!/bin/sh

OURFILE=/etc/crontab
SUMFILE=/var/log/shasum

if [ "$(shasum $OURFILE)" != "$SUMFILE" ]; then
        sendmail root@ardeb.1337.ma < /var/mail/change
fi
