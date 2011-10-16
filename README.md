# Real Physicians

## Prototype

This is a mock backend & set of simple views to demonstrate the app idea & test viability at Portland Startup Weekend, 2011.

This prototype is intended to demonstrate viability on a variety of devices:

    http://emulator.mtld.mobi/emulator.php

## Requirements

This is a Sinatra app (http://sinatrarb.com).

Required ruby gems are listed in the Gemfile. Run `bundle install`.

To bootstrap the database and load fixtures locally, see the Rake file. To get a list of tasks: `rake -T`


## Heroku

Currently, I'm deploying this to Heroku (http://heroku.com). It's free and quick. This can easily be deployed to any Heroku instance; the existing deployment info is below.

=== realphysicians
Web URL:        http://realphysicians.heroku.com/
Git Repo:       git@heroku.com:realphysicians.git
Dynos:          1
Workers:        0
Repo size:      3M
Slug size:      2M
Stack:          bamboo-mri-1.9.2
Data size:      56k
Addons:         Basic Logging, Shared Database 5MB
Owner:          bryan@upstartlabs.com

## TODO

see http://doctorhosp.com