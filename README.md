# Prizzm.com


## Project Setup

### Development Machine

The following software is used in addition to Rails


ImageMagick 6.6.9.8

  ./configure && make && sudo make install



### Environment Variables

For any API keys are passwords that are necessary, specify those in
environmental variables, and add the variable to the list here.


Provided by Sidney:

HOPTOAD_API_KEY             => 
NEW_RELIC_APPNAME           => 
NEW_RELIC_ID                => 
NEW_RELIC_LICENSE_KEY       => 
PRIZZM_S3_ACCESS_KEY_ID     => 
PRIZZM_S3_SECRET_ACCESS_KEY => 


Provided by Giang:


Provided by Charles:


### Gems

All necessary gems should be installable by running the following command from
the Rails root directory

    bundle install



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

## Issue Tracker

## Tests

TODO

# Configuration variables and API keys
Secret api keys and other things are stored in environmental variables on
heroku.  See http://devcenter.heroku.com/articles/config-vars for details

Ensure that files listed in SECRETS are never shared publicly
