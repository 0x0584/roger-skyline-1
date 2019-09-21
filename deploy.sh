#!/bin/sh
# 10.11.16.6 is teh server IP
# 63845 is the ssh port
scp -r -C -P 63845 -p ~/Workspace/deploy foobar@10.11.16.6:~/
