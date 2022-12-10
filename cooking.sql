# creates the cooking database and the relevant tables

CREATE DATABASE cooking IF NOT EXISTS;

use cooking;

CREATE TABLE recipes (
  recipe_name varchar(50) NOT NULL,
  recipe_creator varchar(30) NOT NULL,
  servings int, 
  cooking_time int,
  prep_time int,
  PRIMARY KEY (recipe_name, recipe_creator)
);

CREATE TABLE ingredients (
  ingredient_id int NOT NULL AUTO_INCREMENT,
  name varchar(40) NOT NULL,
  category varchar(30), 
  location varchar(20),
  PRIMARY KEY (ingredient_ID)
);

CREATE TABLE recipe_ingredients (
  recipe_name varchar(50) NOT NULL,
  recipe_creator varchar(30) NOT NULL,
  ingredient_id int NOT NULL,
  quantity int, 
  qunatity_unit,
  PRIMARY KEY (recipe_name, recipe_creator, ingredient_id),
  FOREIGN KEY (recipe_name, recipe_creator) REFERENCES recipes (recipe_name, recipe_creator),
  FOREIGN KEY (ingredient_id) REFERENCES igredients (ingredient_id)
);
