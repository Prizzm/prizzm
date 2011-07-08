#!/bin/bash

# http://xtremekforever.blogspot.com/2011/05/setup-rails-project-with-postgresql-on.html

createuser --superuser prizzm

createdb prizzm_development
createdb prizzm_test
sudo /etc/init.d/postgresql start

