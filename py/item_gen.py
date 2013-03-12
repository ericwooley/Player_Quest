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

adj = []
adj.append(dict(name="Flying", atk=15, df=5))
adj.append(dict(name="Smashing", atk=15, df=1))
adj.append(dict(name="Crushing", atk=18, df=2))
adj.append(dict(name="Unweildable", atk=12, df=1))
adj.append(dict(name="Unbreakable", atk=10, df=20))
adj.append(dict(name="Heavy", atk=4, df=15))
adj.append(dict(name="Decorative", atk=2, df=2))
adj.append(dict(name="Ragged", atk=3, df=2))
adj.append(dict(name="Unusual", atk=5, df=6))



items = []
items.append("BreastPlate")
items.append("Bracers")
items.append("Shoulder")
items.append("Helmet")
items.append("Leggings")
items.append("Gloves")
items.append("Boots")
items.append("Sword")
items.append("Axe")
items.append("Dagger")
items.append("Bow")
items.append("Staff")
items.append("Wand")
items.append("Soul Stone")

item_type = []
item_type.append(dict(name="Ice", atk=7, df=5))
item_type.append(dict(name="Fire", atk=10, df=3))
item_type.append(dict(name="Light", atk=5, df=10))
item_type.append(dict(name="Healing", atk=-15, df=1))
item_type.append(dict(name="Regeneration", atk=-3, df=1))
item_type.append(dict(name="Knowledge", atk=10, df=10))
item_type.append(dict(name="Water", atk=5, df=10))
item_type.append(dict(name="Mathamatics", atk=2, df=1))
item_type.append(dict(name="Damage", atk=15, df=1))
item_type.append(dict(name="Depression", atk=1, df=1))
item_type.append(dict(name="Doubt", atk=1, df=1))
item_type.append(dict(name="Tremendous Gas", atk=5, df=5))

wi = dict()

for i in range(1,2000):
    name = ""
    while(len(name) < 1 and not (name in wi) ):
        item = dict()
        pre = random.choice(adj)
        peice = random.choice(items)
        it = random.choice(item_type)
        name = pre['name'] + " " + peice + " of " + it['name']
        item['name'] = name
        item['attack'] = (pre['atk'] + it['atk']) * random.randint(1, 5)
        item['defense'] = (pre['df'] + it['df']) * random.randint(1, 5)
        name = name.title();
        wi[name] = item
    print json.dumps(wi[name])

#     #print "\nlevel:", level, "\thealth:", health, "\tattack:", attack, "\tdfense:", dfense
q = """
        INSERT INTO wearable_item (`wearable_item_name`, `attack_bonus`, `defense_bonus`, `rank`)
        VALUES
    """
firstpass = True
for c in wi:
    if(not firstpass):
        q+=','
    firstpass = False
    if(abs(wi[c]['attack']) == 0):
        attackm = 1 
    else:
        attackm = abs(wi[c]['attack'])

    q += "(\"%s\", %i, %i, %i)\n" % (wi[c]["name"], wi[c]["attack"], wi[c]["defense"], attackm * wi[c]["defense"])
#q += ")"
print "query: ", q
try:
    db.query(q)
except Exception as e:
    print e


# db.query("SELECT * FROM user_login")
# result = db.store_result();

# print json.dumps(result.fetch_row())