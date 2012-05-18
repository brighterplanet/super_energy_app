# Super Energy App

This is a demo of an app using [Sparkwire](http://sparkwire.io) that can fetch a user's energy data and display a graph of usage.

## Sparkwire

Sparkwire is a service that provides an individual's Green Button data directly from the utility (PG&E for now) without any user intervention. See [the demo for the deets](http://www.youtube.com/watch?v=BSxuSUip_OA).

# Installation

This is a Rails app, so you'll need git, Ruby >= 1.9.1 and the bundler gem.

    $ git clone git://github.com/brighterplanet/super_energy_app.git
    $ bundle
    $ rake db:create
    $ rake db:migrate
    $ export SPARKWIRE_TOKEN=<token from app config on sparkwire.io>
    $ export SPARKWIRE_SECRET=<secret from app config on sparkwire.io>
    $ rails s

# Important parts

## OAuth

The Omniauth gem is used for OAuth login. A custom omniauth strategy is in `lib/omniauth/strategies/sparkwire.rb`.

You'll need to register your app on sparkwire.io (see the developer section once you've signed in). Once registered, set the SPARKWIRE\_TOKEN/SECRET env variables accordingly.

## Downloading

Once an account is OAuth-authenticated, you can download data from http://sparkwire.io/electric\_utility.xml. See `app/models/user.rb#latest\_readings` and `lib/sparkwire.rb`. The data is exactly the same as what would be obtained from PG&E. Currently, only the previous month of data is fetched. We can add date ranges according to need.

# Help!

Feel free to contact us at info@brighterplanet.com, [@brighterplanet](http://twitter.com/brighterplanet) on Twitter, or in our IRC room, #brighterplanet on freenode.
