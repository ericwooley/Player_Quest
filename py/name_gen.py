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
sybs.append("var");
sybs.append("cron");
sybs.append("earl");
sybs.append("sib");
sybs.append("nim");
sybs.append("van");
sybs.append("ent");
sybs.append("bon");
sybs.append("vlad");
sybs.append("carn");
sybs.append("don");
sybs.append("sar");
sybs.append("mi");
sybs.append("par");
sybs.append("si");
sybs.append("dro");
sybs.append("ur");
sybs.append("mar");
sybs.append("niv");
sybs.append("lor");
sybs.append("ev");
sybs.append("bei");
sybs.append("te");
sybs.append("yen");
sybs.append("tsu");
sybs.append("bas");
sybs.append("bel");
sybs.append("rak");
sybs.append("tor");
sybs.append("nal");
sybs.append("tsu");
sybs.append("san");
sybs.append("bo");
sybs.append("den");
sybs.append("pav");


cohorts = dict()

for i in range(1,301):
    namelen = random.randint(1,4)
    name = ""
    count = 0
    while(len(name) < 1 and not (name in cohorts) ):
        name = random.choice(sybs)
        if(namelen > 1):
            name += random.choice(sybs)
            if(namelen > 2):
                name += random.choice(sybs)
                if(namelen > 3):
                    name += random.choice(sybs)
        name = name.title();
        cohorts[name] = dict()
        cohorts[name]["name"] = name
    print type (cohorts[name])

    cohorts[name]["level"] = i
    max_points = i * 100
    cohorts[name]["health"] = random.randint(20, int(math.floor(20 + max_points/2.0)))
    max_points = max_points - cohorts[name]["health"]    
    cohorts[name]["attack"] = random.randint(0, int(math.floor( max_points/2.0)))
    max_points = max_points - cohorts[name]["attack"]
    cohorts[name]["defense"] = max_points

    #print "\nlevel:", level, "\thealth:", health, "\tattack:", attack, "\tDefense:", defense
q = """
        INSERT INTO cohort (`cohort_name`, `health`, `lvl`, `attack`, `defense`)
        VALUES
"""
firstpass = True
for c in cohorts:

    if(not firstpass):
        q+=','
    firstpass = False
    q += "(\"%s\", %i, %i, %i, %i)\n" % (cohorts[c]["name"], cohorts[c]["health"], cohorts[c]["level"], cohorts[c]["attack"], cohorts[c]["defense"])
#q += ")"
print "query: ", q
try:
    db.query(q)
except Exception as e:
    print e


db.query("SELECT * FROM user_login")
result = db.store_result();

print json.dumps(result.fetch_row())