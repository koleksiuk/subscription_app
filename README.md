# Subscription site

## Run
### Dependencies:
* Ruby > 2.2
* PostgreSQL
* nix-based system :)


### Commands:

    bundle install && lotus db create && lotus db migrate

then

    lotus server

### Building assets from scratch

    cd react_app && ./setup.sh

### Load cron tabs

    ./setup_whenever.sh
