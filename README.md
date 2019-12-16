# README

[![Semaphore Status](https://semaphoreci.com/api/v1/projects/40f62f1c-8a04-4a71-9eb7-d37735deb586/2264410/badge.svg)](https://semaphoreci.com/zonawiki/iot_controller)
[![Ruby Critic](https://img.shields.io/badge/RC%20Score-98.07-brightgreen.svg)](https://github.com/ZonaWiki/iot_controller "Rubycritic score")
[![SimpleCov](https://img.shields.io/badge/simplecov-passing-green.svg)](https://github.com/ZonaWiki/iot_controller "SimpleCov score")

# Save Uplinks to Neo4jdb

AWS Lambda that saves uplinks from AWS-IoT to Neo4jDB
- ARN - arn:aws:lambda:us-east-1:247246293844:function:SaveToNeo4jDB

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

  - Ruby 2.5.0
  * Using Docker for Development
  - Docker version 17.03.0-ce or higher
  - Docker Compose version 1.21.2 or higher

### Installing

A step by step series of examples that tell you how to get a development env running

  1. Set the environment variables .evn.prod and .env.test inside the / of the project.

### Running the app

  - Run app in development mode `sudo docker-compose up`
  - Run app locally but with production configuration `sudo docker-compose -f docker-compose.prod-local.yml up`
  - Run app in production mode `sudo docker-compose -f docker-compose.prod.yml -p iot_controller up`

## Test Suite

  - Run `sudo docker-compose run test` for Ruby tests
  - Inside run the script `bin/run` to initialize Neo4j BD and install gems.

## Deployment

  - Run `sudo docker-compose run update` for deployment

## Checkers

  - Run `bin/bash` for QA script.

### Break down into end to end tests

Follow this good practices:
  * [Better Specs](http://www.betterspecs.org/)
  * [Basics](https://medium.com/devnetwork/step-by-step-guide-to-write-rspec-that-is-understandable-and-readable-30279b04dd43)

## Build an image and push it to DockerHub
  - `sudo docker build -t zonawik1/save_uplink_to_neo4jdb:version .`
  - `sudo docker push zonawik1/save_uplink_to_neo4jdb:version`

## Upload code directly to AWS Lambda
  - Before run the script please configure AWS CLI inside your console.
  - Use the API secrets inside the file PASSWORD in TECHNOLOGY folder (Google Drive)

### If no new gems
  - Run `sh script/up`

### If new gems in lambda
  - Uncomment the comment lines inside the script/up.
  - Run `sh script/up`

## Built With

* [Rails](https://github.com/rails/rails) - Framework used

## Contributing

This is a private repository.

## Authors

* **Nathaly Villamor** - *Development Lead at ProCibernética* - [Nathaly](https://github.com/Jinara)
* **William Calderon** - *Full stack developer at ProCibernética* - [William](https://github.com/wecalderonc)
* **Daniela Patiño** - *Full stack developer at ProCibernética* - [Daniela](https://github.com/)

See also the list of [contributors](https://github.com/ZonaWiki/iot_controller/graphs/contributors) who participated in this project.

## Acknowledgments
