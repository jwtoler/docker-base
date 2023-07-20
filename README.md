# Docker Base

Docker Base allows for creating a shared MySQL, MailDev, and Redis environment. Additionally, it enables reverse proxying applications to ease access when developing.

## Initial Setup
```
git clone git@git.charlotte.edu:its-appdev/docker-base.git
sudo ./setup.sh
```

The above script will add a new docker network and configure your Mac to resolve any DNS requests for the .test TLD to localhost.

## Project Setup
* Projects will need to be part of the 'shared' network on their apache, fpm, and xdebug containers. To do this, add this line to the containers:
```
networks: [ default, shared ]
```
* The 'shared' network will need to be defined at the root level of the compose file:
```
networks:
    shared:
      external: true
```
* The apache container will need labels added for proxying. Replace APPNAME with the applications name.
```
labels:
    - "traefik.enable=true"
    - "traefik.http.routers.APPNAME.rule=Host(`APPNAME.dev.test`)"
```
* Your projects .env file should have the following values:
```
MYSQL_HOST=mysql.shared
CACHEWRAPPER_REDIS_HOST=redis.shared
MAILER_URL=maildev.shared
MAILER_PORT=1025
APPDEV_API_URL=http://appdev-api-web.shared
```

## Utilization
### Mail
* Inbox UI - [http://mail.dev.test](http://mail.dev.test)

### Proxy
* Status UI - [http://proxy.dev.test](http://proxy.dev.test)

### MySQL
* Can be accessed via localhost:3306 (standard MySQL port)

### Accessing applications
* Applications are accessible using the configured `.dev.test` hostnames above.