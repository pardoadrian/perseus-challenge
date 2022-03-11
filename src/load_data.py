import sqlalchemy
import pandas as pd
from configparser import ConfigParser
import json



# Read DB conn parameters. This code snipet could be abstrated into a class

config = ConfigParser()
config.read('config.txt')

server = config.get('db_env','server')
user = config.get('db_env','user')
password = config.get('db_env','password')
db = config.get('db_env','db')
port = config.get('db_env','port')


# ORM which handles the interaction with the DB

en = sqlalchemy.create_engine('postgresql://' + user + ':' + password + '@' + server + ':' + port + '/' + db)


entities = [
    {'f_name':'users.json',
    'path':'./data/users/',
    'table':'stg_users'},
    {'f_name':'certificates.json',
    'path':'./data/certificates/',
    'table':'stg_certificates'},
    {'f_name':'courses.json',
    'path':'./data/courses/',
    'table':'stg_courses'}
]



def load_data(entity) -> None:
    df = pd.read_json(entity['path'] + entity['f_name'])
    df.to_sql(entity['table'], 
                schema='public', 
                con=en,
                if_exists='append',
                index=False)
    print('Entity loaded to db..\n')
    return None


if __name__ == "__main__":

    for entity in entities:
       
        load_data(entity)