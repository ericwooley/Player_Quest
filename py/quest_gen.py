import MySQLdb
import json
import random, math

config = json.load(open('config.json'))
db = MySQLdb.connect(
        host    = config['host'],
        user    = config['user'],
        passwd  = config['passwd'],
        db      = config['db']
    )

sybs = []
sybs.append("rock");
sybs.append("ouo");
sybs.append("tra");
sybs.append("bar");
sybs.append("mol");
sybs.append("nii");
sybs.append("mal");
sybs.append("tor");
sybs.append("than");
sybs.append("pal");
sybs.append("carn");
sybs.append("son");
sybs.append("tray");
sybs.append("van");
sybs.append("sar");
sybs.append("tin");
sybs.append("cal");
sybs.append("rov");
sybs.append("min");
sybs.append("trel");
sybs.append("wor");
sybs.append("kin");
sybs.append("slay");
sybs.append("er");
sybs.append("mok");
sybs.append("tam");
sybs.append("cill");
sybs.append("ab");
sybs.append("hor");
sybs.append("sen");
sybs.append("bol");
sybs.append("cre");
sybs.append("dov");
sybs.append("bo");
sybs.append("den");
sybs.append("pav");


enemys = dict()

for i in range(1,301):
    namelen = random.randint(1,4)
    name = ""
    count = 0
    while(len(name) < 1 and not (name in enemys) ):
        name = random.choice(sybs)
        if(namelen > 1):
            name += random.choice(sybs)
            if(namelen > 2):
                name += random.choice(sybs)
                if(namelen > 3):
                    name += random.choice(sybs)
        name = name.title();
        enemys[name] = dict()
        enemys[name]["name"] = name
    print type (enemys[name])

    enemys[name]["level"] = i
    max_points = i * 100
    enemys[name]["health"] = random.randint(20, int(math.floor(20 + max_points/2.0)))
    max_points = max_points - enemys[name]["health"]    
    enemys[name]["attack"] = random.randint(0, int(math.floor( max_points/2.0)))
    max_points = max_points - enemys[name]["attack"]
    enemys[name]["defense"] = max_points

    #print "\nlevel:", level, "\thealth:", health, "\tattack:", attack, "\tDefense:", defense
q = """
        INSERT INTO enemy (`enemy_name`, `health`, `lvl`, `attack`, `defense`)
        VALUES
"""
firstpass = True
for c in enemys:

    if(not firstpass):
        q+=','
    firstpass = False
    q += "(\"%s\", %i, %i, %i, %i)\n" % (enemys[c]["name"], enemys[c]["health"], enemys[c]["level"], enemys[c]["attack"], enemys[c]["defense"])
#q += ")"
print "query: ", q
try:
    db.query(q)
except Exception as e:
    print e


db.query("SELECT * FROM user_login")
result = db.store_result();

print json.dumps(result.fetch_row())