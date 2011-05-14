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
http://sid137.hoptoadapp.com

## Facebook Integration
Use edge Devise (currently 1.4.0) with Omniauth integrated (from 1.2) to do Facebook Connect.

FYI, people on Mac OS may have difficulty dealing with SSL Certification so I add these lines to ./config/initializers/devise.rb to bypass certification verifying while you are in development mode.

    if Rails.env.development? 
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 
    end

To use FB Connect locally, please uncomment line #185 and comment out #183 in ./config/initializers/devise.rb

## Issue Tracker

## Tests

TODO

# Configuration variables and API keys
Secret api keys and other things are stored in environmental variables on
heroku.  See http://devcenter.heroku.com/articles/config-vars for details

Ensure that files listed in SECRETS are never shared publicly
