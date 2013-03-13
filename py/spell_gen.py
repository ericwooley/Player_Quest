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
adj.append(dict(name="Flying", atk=15))
adj.append(dict(name="Smashing", atk=15))
adj.append(dict(name="Crushing", atk=18, effect=2))
adj.append(dict(name="Unweildable", atk=12))
adj.append(dict(name="Unbreakable", atk=10))
adj.append(dict(name="Heavy", atk=4))
adj.append(dict(name="Ragged", atk=3))
adj.append(dict(name="Unusual", atk=5))


spell_type = []
spell_type.append(dict(name="Ice", atk=7, effect="Ice Burn"))
spell_type.append(dict(name="Fire", atk=10, effect="Fire Burn"))
spell_type.append(dict(name="Lightning", atk=5, effect="Paralyze"))
spell_type.append(dict(name="Healing", atk=-15, effect="Heal"))
spell_type.append(dict(name="Regeneration", atk=-3, effect="Regeneration"))
spell_type.append(dict(name="Water", atk=5, effect="Drown"))
spell_type.append(dict(name="Damage", atk=15, effect="Double Damage"))
spell_type.append(dict(name="Tremendous Gas", atk=5, effect="Smell Bad"))

wi = dict()

for i in range(1,100):
    name = ""
    while(len(name) < 1 and not (name in wi) ):
        spell = dict()
        pre = random.choice(adj)
        it = random.choice(spell_type)
        name = pre['name'] + " spell of " + it['name']
        spell['name'] = name
        spell['attack'] = (pre['atk'] * it['atk']) * random.randint(1, 5)
        spell['effect'] = it['effect']
        name = name.title();
        wi[name] = spell
    print json.dumps(wi[name])

#     #print "\nlevel:", level, "\thealth:", health, "\tattack:", attack, "\tdfense:", dfense
q = """
        INSERT INTO spells (`spell_name`, `damage`, `effect`, `rank`)
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

    q += "(\"%s\", %i, \"%s\", %i)\n" % (wi[c]["name"], wi[c]["attack"], wi[c]["effect"], attackm)
#q += ")"
print "query: ", q
try:
    db.query(q)
except Exception as e:
    print e


# db.query("SELECT * FROM user_login")
# result = db.store_result();

# print json.dumps(result.fetch_row())