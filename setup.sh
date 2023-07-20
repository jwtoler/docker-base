#!/bin/sh

# Ensure we're running as root.
if [ "$EUID" -ne 0 ]
  then echo "This script requires it be ran as root."
  exit
fi

# Create the 'shared' network if it doesn't already exist
docker network inspect shared >/dev/null 2>&1 || docker network create shared

# Make /etc/resolver directory
mkdir -p /etc/resolver

# Add local resolver for .test tld
tee /etc/resolver/test > /dev/null <<END
nameserver 127.0.0.1
port 5053
END

echo "Done."



