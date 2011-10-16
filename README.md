# Real Physicians

## Prototype

This is a mock backend & set of simple views to demonstrate the app idea & test viability at Portland Startup Weekend, 2011.

This prototype is intended to demonstrate viability on a variety of devices. There's a nice [Nokia simulator at dotmobi](http://emulator.mtld.mobi/emulator.php). 

> According to the Opera State of the Mobile web May 2011, Nokia 5130 is the second most popular Mobile phone used for browsing the internet in Nigeria, trailing only the Nokia 2700c.

-- [Source](http://naijatechguide.blogspot.com/2010/01/nokia-phones-for-2010-in-emerging.html)

## Premise

Real Physicians provides: 

* A consolidated database of board certified and licensed medical professionals
*  Aggregation of disparate data from different countries, region and continents
*  Standardized categories of licensed medical professionals with their credentials, prac;ces, availability and exper;se
*  A minimum level of trust utilizing global best practices
*  Layers of services to easily locate medical professionals
and information about them
*  Tools to quickly locate needed information for many use cases and scenarios
*  Access to qualified professionals regardless of income

## Requirements

This is a [Sinatra app](http://sinatrarb.com).

Required ruby gems are listed in the Gemfile. Run `bundle install`.

To bootstrap the database and load fixtures locally, see the Rake file. To get a list of tasks: `rake -T`


## Heroku

Currently, I'm deploying this to [Heroku](http://heroku.com). It's free and quick. This can easily be deployed to any Heroku instance; the existing deployment info is below.

[http://realphysicians.heroku.com/](http://realphysicians.heroku.com/)

## TODO

see http://doctorhosp.com