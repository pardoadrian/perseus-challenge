# perseus-challenge

## Config files
The docker compose yml file configures a postgres where the data will be stored. Spin up the image using
the following command:

docker-compose -f docker-compose-local.yml up (with root user, or using sudo)

There is also a requirements file where all the needed dependencies for the python enviroment are listed.

Finally, there is a config file which contains the db connection parameters

## SQL files
There are ddl sql scripts for defining the table structures and a single sql script which contains the queries asked in this challenge.

## Script
The load_file script reads from json files and loads the entities into the previuosly created database tables.

## Data arquitecture
There is only an stage layer. Ideally there should be an OBJ layer to store the raw json data, then an STAGING area where we use the attributes we need,rename attributes and cast datatypes, and a DIMENSIONAL layer where we consolidate the data.