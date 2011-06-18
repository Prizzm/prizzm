# Prizzm.com

  
## Project Setup


### Git

The code sits in 4 git branches: development, demo, master, and staging.
These four branches track 4 remote branches - development, demo, production, and
staging respectively.  These remotes point to the master branches of 4 heroku applications prizzm-dvelopment, prizzm-demo, prizzm-production, and prizzm-staging.

Weehn deploying, switch to the branch you want to deploy from, and type

git push

If you want to deploy to production from master however, you must do 

git push production

as the master branch default remote points to github ffor automatic pushees and
pulls.

When deploying a branch to heroku, don't forgt to push the branch tot github.
Or use the rake task to simplify this

rake demo heroku:deploy


### Development Machine

The following software is used in addition to Rails


ImageMagick 6.6.9.8

  ./configure && make && sudo make install



### Environment Variables

For any API keys are passwords that are necessary, specify those in the
prizzm_setup/secret_credentials file as environment variables.  We then load
those env vars in the config/heroku.yml file, and use the heroku rails gem to
add them to our production server environmeent, by running

bundle exec rake development heroku:setup



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

Ensure that files listed in prizzm_setup/secret-credentials are never shared publicly


# Facebook

## Publishing to the Wall

Use the "Facebook" model which provides the Facebook.post_message method. 

Facebook.post_message(message, auth_token)

parameters
   message -  hash, where the format is specified here  http://developers.facebook.com/docs/reference/api/post/
   auth_token
