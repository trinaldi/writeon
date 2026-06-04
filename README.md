# WriteOn

WriteOn is a daily activities manager, AKA a diary.
This repository contains the Backend code. Ruby on Rails GraphQL API using
MongoDB as the DB. 
Frontend code has its own repository, [WriteOn-Web](https://github.com/trinaldi/writeon-web). 

## Installing

```sh
Ruby 4.0.5
Rails 8.0.5
MongoDB 8.0.34
```

are the requisites. Having said that, use `bundler` to install the dependencies:

`$ bundle install`

then open the server `rails s`, which will default to port `5000`

Test the API with GraphiQL on `localhost:5000/graphiql`

## Contributing

Follow the rules on `.rubocop.yml` and make sure to test _everything_ before
opening a Pull Request

