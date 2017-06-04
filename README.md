Spotippos
================

Come to live in Spotippos!

URLs
---------------
* - Production environment on Heroku
* - API Documentation

Dependencies
-------------

To run this project you need to have:

- Ruby 2.3.1
- Rails 5.1.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Setup the project
---------------
1. Install the depedencies above
2. `$ git clone git@github.com:joice/spotippos.git` - Clone the project
3. `$ cd spotippos` - Go into the project folder
4. `$ cp config/database.yml.example config/database.yml`  - Create database configuration file
5. `$ bundle exec rake db:setup` - Create & setup the database
6. `$ bundle install` - Install the gem dependencies
7. `$ bundle exec rake spec` - Run the specs to see if everything is working fine

If everything goes OK, you can now run the project!

Running the project
-------------------------
1. `$ bin/rails s` - Opens the server
2. Open http://localhost:3000

Running specs and checking coverage
-------------
`$ bundle exec rake spec` to run the specs.

`$ coverage=on bundle exec rake spec` to generate the coverage report then open the file `coverage/index.html` on your browser.

Import data to your machine
----------------
`$ bundle exec rake provinces:create` - Import provinces
`$ bundle exec rake properties:create` - Import provinces
