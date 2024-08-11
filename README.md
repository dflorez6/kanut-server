# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Docker Compose Execute Rails Commands on Container

### Using docker-compose exec

If your Rails application is managed by docker-compose, you can run the migrations with the following command:

    docker-compose exec api bundle exec rails db:migrate

* api: This is the name of your Rails service in the docker-compose.yml file. Replace it with the correct service name if yours is different 

* bundle exec rails db:migrate: This command runs the Rails migrations.

### Using docker exec

If you're not using docker-compose or you want to run the command directly on a specific container, use docker exec:

    docker exec -it kanut-server-container bundle exec rails db:migrate

* kanut-server-container: This is the name of your running Rails container. Replace it with the actual container name.
* -it: Allows you to interact with the container (i.e., interactive terminal).
* bundle exec rails db:migrate: This command runs the Rails migrations.

### Running Multiple Commands

If you need to create the database and migrate in one step:

    docker-compose exec api bash -c "bundle exec rails db:create db:migrate"

This command opens a bash shell in the container and runs both the db:create and db:migrate commands in sequence.