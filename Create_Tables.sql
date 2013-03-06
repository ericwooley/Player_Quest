DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS cohort;
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
);


CREATE TABLE IF NOT EXISTS cohort (
	id INT NOT NULL AUTO_INCREMENT,
	cohort_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (id)
);

-- How I made it
CREATE TABLE IF NOT EXISTS player_party (
	player_id INT,
	cohort_id INT,
	join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (player_id, cohort_id)
	,INDEX `fk_player_has_cohort_cohort1_idx` (`cohort_id` ASC)
	,INDEX `fk_player_has_cohort_player_idx` (`player_id` ASC) 
);
ALTER TABLE player_party ADD CONSTRAINT player_id_ref_player FOREIGN KEY (player_id) REFERENCES player(id);
ALTER TABLE player_party ADD CONSTRAINT cohort_id_ref_cohort FOREIGN KEY (cohort_id) REFERENCES cohort(id);


CREATE TABLE IF NOT EXISTS enemy (
	id INT NOT NULL AUTO_INCREMENT,
	enemy_name varchar(100) NOT NULL UNIQUE,
	health INT NOT NULL,
	lvl INT NOT NULL,
	attack INT NOT NULL,
	defense INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS battle_log (
	battle_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(battle_id),
	enemy_id INT NOT NULL, FOREIGN KEY(enemy_id) REFERENCES enemy(id),
	player_id INT NOT NULL, FOREIGN KEY (player_id) REFERENCES player(id),
	player_victorious BOOLEAN NOT NULL,
	battle_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS quest (
	quest_id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (quest_id),
	min_lvl INT NOT NULL,
	quest_text varchar (2000) NOT NULL,
	quest_name varchar (50) NOT NULL
);


CREATE TABLE IF NOT EXISTS wearable_item (
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),
	wearable_item_name varchar(100) NOT NULL UNIQUE,
	attack_bonus INT NOT NULL DEFAULT 0,
	defense_bonus INT NOT NULL DEFAULT 0
);


CREATE TABLE IF NOT EXISTS players_wearable_items(
	wearable_item_id INT NOT NULL, FOREIGN KEY (wearable_item_id) references wearable_item(id),
	player_id INT NOT NULL, FOREIGN KEY (player_id) references player(id),
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (wearable_item_id, player_id)
);


CREATE TABLE IF NOT EXISTS consumable_items (
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id),
	damage INT NOT NULL DEFAULT 0,
	mana_damage INT NOT NULL DEFAULT 0,
	drop_chance INT NOT NULL DEFAULT 0,
	consumable_item_name varchar(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS players_consumable_items(
	consumable_item_id INT NOT NULL, FOREIGN KEY (consumable_item_id) references consumable_items(id),
	player_id INT NOT NULL, FOREIGN KEY (player_id) references player(id),
	acquire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (consumable_item_id, player_id)
);
