
DROP TABLE IF EXISTS battle_log;
DROP TABLE IF EXISTS enemy;

DROP TABLE IF EXISTS quest_log;
DROP TABLE IF EXISTS quest;

DROP TABLE IF EXISTS players_wearable_items;
DROP TABLE IF EXISTS wearable_item;

DROP TABLE IF EXISTS players_consumable_items;
DROP TABLE IF EXISTS consumable_items;

DROP TABLE IF EXISTS players_spells;
DROP TABLE IF EXISTS spells;

DROP TABLE IF EXISTS player_party;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS cohort;
DROP TABLE IF EXISTS user_login;


CREATE TABLE IF NOT EXISTS user_login(
	id INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(100) NOT NULL UNIQUE,
	password_hash VARCHAR(20) NOT NULL,
	PRIMARY KEY (id)
)ENGINE=innodb;
SELECT * FROM user_login;

CREATE TABLE IF NOT EXISTS player (
	mana INT NOT NULL DEFAULT 10,
	health INT NOT NULL DEFAULT 10,
	lvl INT NOT NULL DEFAULT 1,
	attack INT NOT NULL DEFAULT 10,
	defense INT NOT NULL DEFAULT 10,
	player_name VARCHAR(100) NOT NULL UNIQUE,
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	PRIMARY KEY (id),
	INDEX `player_id_index` (id)
)ENGINE=innodb;
ALTER TABLE player 
	ADD CONSTRAINT player_user_id_ref_user_login 
	FOREIGN KEY (user_id) REFERENCES user_login(id) 
	ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS cohort (
	id INT NOT NULL AUTO_INCREMENT,
	cohort_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (id),
	INDEX `cohort_id_index` (id)
)ENGINE=innodb;

CREATE TABLE IF NOT EXISTS player_party (
	player_id INT,
	cohort_id INT,
	join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (player_id, cohort_id)
	,INDEX `player_id_index` (`player_id`)
	,INDEX `cohort_id_index` (`cohort_id`) 
)ENGINE=innodb;
ALTER TABLE player_party 
	ADD CONSTRAINT player_party_id_ref_player 
	FOREIGN KEY (player_id) REFERENCES player(id)
	ON DELETE CASCADE;
ALTER TABLE player_party 
	ADD CONSTRAINT cohort_party_id_ref_cohort 
	FOREIGN KEY (cohort_id) REFERENCES cohort(id)
	ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS enemy (
	id INT NOT NULL AUTO_INCREMENT,
	enemy_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (id),
	INDEX `enemy_id_index` (id)
)ENGINE=innodb;

CREATE TABLE IF NOT EXISTS battle_log (
	battle_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(battle_id),
	enemy_id INT NOT NULL,
	player_id INT NOT NULL,
	player_victorious BOOLEAN NOT NULL,
	battle_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	INDEX `battle_id_index` (battle_id),
	INDEX `enemy_id_index` (enemy_id),
	INDEX `player_id_index` (player_id)
)ENGINE=innodb;
ALTER TABLE battle_log 
	ADD CONSTRAINT enemy_battle_log_id_ref_enemy 
	FOREIGN KEY (enemy_id) REFERENCES enemy(id);
ALTER TABLE battle_log 
	ADD CONSTRAINT player_battle_log_id_ref_player 
	FOREIGN KEY (player_id) REFERENCES player(id)
	ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS quest (
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id),
	min_lvl INT NOT NULL,
	quest_text varchar (2000) NOT NULL,
	quest_name varchar (50) NOT NULL,
	INDEX `quest_id_index` (id)
)ENGINE=innodb;


CREATE TABLE IF NOT EXISTS wearable_item (
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),
	wearable_item_name varchar(100) NOT NULL UNIQUE,
	attack_bonus INT NOT NULL DEFAULT 0,
	defense_bonus INT NOT NULL DEFAULT 0,
	rank INT NOT NULL DEFAULT 0,
	INDEX `wi_index` (id)
)ENGINE=innodb;

CREATE TABLE IF NOT EXISTS quest_log(
	quest_id INT NOT NULL,
	player_id INT NOT NULL,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (quest_id, player_id),
	INDEX `quest_id_index` (quest_id),
	INDEX `player_id_index` (player_id)
)ENGINE=innodb;
ALTER TABLE quest_log
	ADD CONSTRAINT quest_log_id_ref_quest 
	FOREIGN KEY (quest_id) REFERENCES quest(id);
ALTER TABLE quest_log
	ADD CONSTRAINT quest_log_id_ref_player 
	FOREIGN KEY (player_id) references player(id)
	ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS players_wearable_items(
	wearable_item_id INT NOT NULL,
	player_id INT NOT NULL,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (wearable_item_id, player_id),
	INDEX `wearable_item_index` (wearable_item_id),
	INDEX `player_index` (player_id)
)ENGINE=innodb;
ALTER TABLE players_wearable_items 
	ADD CONSTRAINT wearable_item_ref_wearable_item 
	FOREIGN KEY (wearable_item_id) REFERENCES wearable_item(id);
ALTER TABLE players_wearable_items 
	ADD CONSTRAINT wi_id_ref_player 
	FOREIGN KEY (player_id) references player(id)
	ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS consumable_items (
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id),
	damage INT NOT NULL DEFAULT 0,
	mana_damage INT NOT NULL DEFAULT 0,
	drop_chance INT NOT NULL DEFAULT 0,
	consumable_item_name varchar(100) NOT NULL UNIQUE,
	INDEX `consumable_item_index` (id)
)ENGINE=innodb;


CREATE TABLE IF NOT EXISTS players_consumable_items(
	consumable_item_id INT NOT NULL,
	player_id INT NOT NULL,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (consumable_item_id, player_id),
	INDEX `consumable_item_index` (consumable_item_id),
	INDEX `player_index` (player_id)
)ENGINE=innodb;
ALTER TABLE players_consumable_items 
	ADD CONSTRAINT player_cons_items_id_ref_player 
	FOREIGN KEY (player_id) REFERENCES player(id);
ALTER TABLE players_consumable_items 
	ADD CONSTRAINT consumable_item_id_ref_consumable_item 
	FOREIGN KEY (consumable_item_id) REFERENCES consumable_items(id);

CREATE TABLE IF NOT EXISTS spells(
	id INT NOT NULL AUTO_INCREMENT, 
	spell_name VARCHAR(100) NOT NULL UNIQUE,
	damage INT NOT NULL DEFAULT 0,
	effect VARCHAR(100) NOT NULL,
	rank INT NOT NULL DEFAULT 0,
	PRIMARY KEY(id),
	INDEX `spell_id` (id)
)ENGINE=innodb;

CREATE TABLE IF NOT EXISTS players_spells(
	spell_id INT NOT NULL,
	player_id INT NOT NULL,
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (spell_id, player_id),
	INDEX `player_index` (player_id),
	INDEX `spell_index` (spell_id)
)ENGINE=innodb;
ALTER TABLE players_spells
	ADD CONSTRAINT player_spells_id_ref_player 
	FOREIGN KEY (player_id) REFERENCES player(id);
ALTER TABLE players_spells 
	ADD CONSTRAINT player_spells_id_ref_spell 
	FOREIGN KEY (spell_id) REFERENCES spells(id);

