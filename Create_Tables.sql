DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS cohorts;
DROP TABLE IF EXISTS player_party;
DROP TABLE IF EXISTS enemy;
DROP TABLE IF EXISTS battle_log;
DROP TABLE IF EXISTS quest;
DROP TABLE IF EXISTS wearable_item;
DROP TABLE IF EXISTS players_wearable_items;
DROP TABLE IF EXISTS consumable_items;
DROP TABLE IF EXISTS players_consumable_items;

CREATE TABLE IF NOT EXISTS player (
	mana INT NOT NULL,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	player_name VARCHAR(100) NOT NULL UNIQUE,
	id INT NOT NULL AUTO_INCREMENT, 
	PRIMARY KEY (id)
)   ;


CREATE TABLE IF NOT EXISTS cohorts (
	id INT NOT NULL AUTO_INCREMENT,
	cohort_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (id)
	
) ;

CREATE TABLE IF NOT EXISTS player_party (
	player_id INT, FOREIGN KEY(player_id) REFERENCES player(id),
	cohort_id INT, FOREIGN KEY(cohort_id) REFERENCES cohorts(id),
	join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (player_id, cohort_id)
);


CREATE TABLE IF NOT EXISTS enemy (
	enemy_id INT NOT NULL AUTO_INCREMENT,
	enemy_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (enemy_id)
	
) ;



CREATE TABLE IF NOT EXISTS battle_log (
	battle_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(battle_id),
	enemy_id INT NOT NULL, FOREIGN KEY(enemy_id) REFERENCES enemy,
	player_id INT NOT NULL, FOREIGN KEY (player_id) REFERENCES player,
	player_victorious BOOLEAN NOT NULL,
	battle_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ;


CREATE TABLE IF NOT EXISTS quest (
	quest_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (quest_id),
	min_lvl INT NOT NULL,
	quest_text varchar (2000) NOT NULL,
	quest_name varchar (50) NOT NULL
) ;


CREATE TABLE IF NOT EXISTS wearable_item (
	wearable_item_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(wearable_item_id),
	wearable_item_name varchar(100) NOT NULL UNIQUE,
	attack_bonus INT NOT NULL DEFAULT 0,
	defense_bonus INT NOT NULL DEFAULT 0
);


CREATE TABLE IF NOT EXISTS players_wearable_items(
	wearable_item_id INT NOT NULL, FOREIGN KEY (wearable_item_id) references wearable_item,
	player_id INT NOT NULL, FOREIGN KEY (player_id) references player,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (wearable_item_id, player_id)
) ;


CREATE TABLE IF NOT EXISTS consumable_items (
	consumable_item_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (consumable_item_id),
	damage INT NOT NULL DEFAULT 0,
	mana_damage INT NOT NULL DEFAULT 0,
	drop_chance INT NOT NULL DEFAULT 0,
	consumable_item_name varchar(100) NOT NULL UNIQUE
) ;


CREATE TABLE IF NOT EXISTS players_consumable_items(
	consumable_item_id INT NOT NULL, FOREIGN KEY (consumable_item_id) references consumable_items,
	player_id INT NOT NULL, FOREIGN KEY (player_id) references player,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (consumable_item_id, player_id)
) ;
