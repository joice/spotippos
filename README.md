[![CircleCI](https://circleci.com/gh/joice/spotippos.svg?style=svg)](https://circleci.com/gh/joice/spotippos)

Spotippos
================

Come to live in Spotippos!

URLs
---------------
* https://spotipposland.herokuapp.com/ - Production environment on Heroku
* https://spotipposland.herokuapp.com/docs - API Documentation

Dependencies
-------------

To run this project you need to have:

- Ruby 2.3.1
- Rails 5.1.1
- PostgresSQL
- Redis

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Setup the project
---------------
1. Install the depedencies above
2. `$ git clone git@github.com:joice/spotippos.git` - Clone the project
3. `$ cd spotippos` - Go into the project folder
4. `$ bundle install` - Install the gem dependencies
5. `$ cp config/database.yml.example config/database.yml`  - Create database configuration file
6. `$ bin/rake db:setup` - Create & setup the database
7. `$ bin/rspec .` - Run the specs to see if everything is working fine

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

`$ bundle exec rake properties:create` - Import properties

Deploy proccess
----------------

1. `$ heroku login` - Install the heroku CLI
2. `cd spotippos/` - Go into the project folder
3. `heroku git:remote -a spotipposland` - Add heroku remote
4. `$ git push heroku master` - Deploy

Suggested AWS infraesructure for production environment
----------------

* https://cl.ly/1H2f3S2i1T2v


Suggested application test
----------------

1. Creating a property on Spotipposland

```
curl -X POST \
  http://spotipposland.herokuapp.com/api/v1/properties \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'postman-token: 471f3ea1-a431-7e1b-510d-2a7c73b5a16b' \
  -F 'property[title]=Imóvel código 1, com 5 quartos e 4 banheiros' \
  -F 'property[x]=870' \
  -F 'property[price]=1250000' \
  -F 'property[description]=Lorem ipsum dolor sit amet, consectetur adipiscing elit.' \
  -F 'property[y]=867' \
  -F 'property[beds]=5' \
  -F 'property[baths]=4' \
  -F 'property[square_meters]=134'
```

2. Find a property on Spotipposland

```
curl -X GET \
  http://spotipposland.herokuapp.com/api/v1/properties/665 \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'postman-token: e445f5f7-240b-2d79-85ca-ab1b83fa5c38' \
```

3. Search properties on Spotipposland passing 2 points

```
curl -X GET \
  'http://spotipposland.herokuapp.com/api/v1/properties?ax=300&ay=1000&bx=700&by=500&format=json' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'postman-token: 46890674-0aad-5d64-decb-88a852fbfb36' \
```
