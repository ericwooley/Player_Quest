import MySQLdb
import json
import random

config = json.load(open('config.json'))
db = MySQLdb.connect(
        host    = config['host'],
        user    = config['user'],
        passwd  = config['passwd'],
        db      = config['db']
    )
try:
    db.query("""
        INSERT INTO user_login
            (`username`, `password_hash`)
            VALUES
            ('"""+config['user_name']+"""', '654321') 
        """)
except Exception as e:
    print e


db.query("SELECT * FROM user_login")
result = db.store_result();

print json.dumps(result.fetch_row())