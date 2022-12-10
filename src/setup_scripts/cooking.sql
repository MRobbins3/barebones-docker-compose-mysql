# creates the cooking database and the relevant tables

CREATE DATABASE cooking IF NOT EXISTS;

use cooking;

DROP TABLE IF EXISTS recipe_ingredients;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS recipes;

CREATE TABLE recipes (
  recipe_name varchar(50) NOT NULL,
  recipe_creator varchar(30) NOT NULL,
  servings int, 
  cooking_time int,
  prep_time int,
  PRIMARY KEY (recipe_name, recipe_creator)
);

INSERT INTO recipes VALUES 
('Dinner Rolls', 'Esther Ketcham', 15, 15, 135),
('Dinner Rolls', 'Patricia Baker', 18, 20, 90),
('Cinnamon Rolls', 'Patricia Baker', 18, 30, 75), 
('Pumpkin Bars', 'Carly Duytschaver', 30, 22, 20), 
('Chicken Noodle Soup', 'Esther Ketcham', 8, 180, 30),
('Chicken and Rice', 'Patricia Baker', 4, 60, 60)
;

CREATE TABLE ingredients (
  ingredient_id int NOT NULL AUTO_INCREMENT,
  name varchar(40) NOT NULL,
  category varchar(30), 
  location varchar(20),
  PRIMARY KEY (ingredient_ID)
);

INSERT INTO ingredients VALUES 
('flour', 'baking', 'pantry'),
('butter', 'dairy', 'fridge'),
('yeast', 'baking', 'fridge'), 
('sugar', 'baking', 'pantry'), 
('salt', 'spice', 'cabinet'), 
('milk', 'dairy', 'fridge'), 
('cinnamon', 'spice', 'cabinet'), 
('CRISCO', 'baking', 'pantry'),
('powdered sugar', 'baking', 'pantry'),
('cream cheese', 'dairy', 'fridge'),
('pumpkin puree', 'canned', 'pantry'), 
('chicken thighs', 'poultry', 'freezer'), 
('egg noodles', 'dry goods', 'pantry'), 
('chicken stock', 'canned', 'pantry'), 
('mixed veggies', 'vegetables', 'freezer'), 
('chicken gravy mix', 'dry goods', 'pantry'), 
('minute rice', 'dry goods', 'pantry')
;

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

INSERT INTO recipe_ingredients VALUES
()
;


