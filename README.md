# Prizzm.com

## Css compilation with Compass

Css for this project is stored in the sass files under the "app/stylesheets" directory.  We then
compile the sass into css before deploying to heroku. 

Make sure that you are running at least Compass 0.11.1

  gem install compass

Then go to the Rails root, and either compile one time by running

  compass compile .

or continuously watch all sass files and compile once they are updated with

  compass watch .


##  Pivotal Tracker project

Project roadmap is posted on 

https://www.pivotaltracker.com/projects/284851

## Github

Source code repository is stored on github at:

https://github.com/sid137/charles5



## Heroku Config
=== radiant-beach-401
Web URL:        http://radiant-beach-401.heroku.com/
Domain name:    http://www.prizzm.com/
Git Repo:       git@heroku.com:radiant-beach-401.git
Dynos:          1
Workers:        0
Repo size:      20M
Slug size:      13M
Stack:          bamboo-mri-1.9.2
Data size:      240k
Addons:         Custom Domains, Basic Logging, Shared Database 5MB
Owner:          sid137@gmail.com
Collaborators:  ndgiang84@gmail.com

## Hoptoad Exceptions

## Issue Tracker

## Tests

TODO


Ensure that files listed in SECRETS are never shared publicly
