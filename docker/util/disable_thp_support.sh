#!/bin/sh
nsenter -t 1 -m -u -n -i sh -c 'echo never > /sys/kernel/mm/transparent_hugepage/enabled && echo never > /sys/kernel/mm/transparent_hugepage/defrag'