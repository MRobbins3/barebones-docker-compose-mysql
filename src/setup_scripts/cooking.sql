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
  CONSTRAINT PK_Recipes PRIMARY KEY (recipe_name, recipe_creator)
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
) AUTO_INCREMENT=22 ;

INSERT INTO ingredients VALUES 
(1, 'flour', 'baking', 'pantry'),
(2, 'butter', 'dairy', 'fridge'),
(3, 'yeast', 'baking', 'fridge'), 
(4, 'sugar', 'baking', 'pantry'), 
(5, 'salt', 'spice', 'cabinet'), 
(6, 'milk', 'dairy', 'fridge'), 
(7, 'cinnamon', 'spice', 'cabinet'), 
(8, 'CRISCO', 'baking', 'pantry'),
(9, 'powdered sugar', 'baking', 'pantry'),
(10, 'cream cheese', 'dairy', 'fridge'),
(11, 'pumpkin puree', 'canned', 'pantry'), 
(12, 'chicken thighs', 'poultry', 'freezer'), 
(13, 'egg noodles', 'dry goods', 'pantry'), 
(14, 'chicken stock', 'canned', 'pantry'), 
(15, 'mixed veggies', 'vegetables', 'freezer'), 
(16, 'chicken gravy mix', 'dry goods', 'pantry'), 
(17, 'minute rice', 'dry goods', 'pantry'),
(18, 'canola oil', 'oil', 'pantry'),
(19, 'baking powder', 'baking', 'cabinet'),
(20, 'baking soda', 'baking', 'cabinet'),
(21, 'large egg', 'dairy', 'fridge')
;

CREATE TABLE recipe_ingredients (
  recipe_name varchar(50) NOT NULL,
  recipe_creator varchar(30) NOT NULL,
  ingredient_id int NOT NULL,
  quantity numeric, 
  qunatity_unit varchar(15),
  CONSTRAINT PK_recipe_ingredients PRIMARY KEY (recipe_name, recipe_creator, ingredient_id),
  CONSTRAINT FK_RecipeNameCreator FOREIGN KEY (recipe_name, recipe_creator) REFERENCES recipes (recipe_name, recipe_creator),
  CONSTRAINT FK_ingredient_id FOREIGN KEY (ingredient_id) REFERENCES ingredients (ingredient_id)
);

INSERT INTO recipe_ingredients VALUES
('Dinner Rolls', 'Esther Ketcham', 1, 4, 'cup'),
('Dinner Rolls', 'Esther Ketcham', 2, 2, 'tbsp'),
('Dinner Rolls', 'Esther Ketcham', 3, 2.5, 'tsp'),
('Dinner Rolls', 'Esther Ketcham', 4, 3, 'tbsp'),
('Dinner Rolls', 'Esther Ketcham', 5, 1, 'tsp'),
('Dinner Rolls', 'Esther Ketcham', 6, 1.5, 'cup'),
('Dinner Rolls', 'Patricia Baker', 1, 3.5, 'cup'),
('Dinner Rolls', 'Patricia Baker', 3, 1, 'tbsp'),
('Dinner Rolls', 'Patricia Baker', 4, 3, 'tbsp'),
('Dinner Rolls', 'Patricia Baker', 5, 1, 'tsp'),
('Dinner Rolls', 'Patricia Baker', 6, 1.75, 'cup'),
('Chicken Noodle Soup', 'Esther Ketcham', 12, 5, 'pound'),
('Chicken Noodle Soup', 'Esther Ketcham', 13, 16, 'ounces'),
('Chicken Noodle Soup', 'Esther Ketcham', 14, 8, 'cup'),
('Chicken Noodle Soup', 'Esther Ketcham', 15, 1, 'pound'),
('Chicken Noodle Soup', 'Esther Ketcham', 16, 4, 'packet'),
('Pumpkin Bars', 'Carly Duytschaver', 18, 1, 'cup'),
('Pumpkin Bars', 'Carly Duytschaver', 4, 2, 'cup'),
('Pumpkin Bars', 'Carly Duytschaver', 21, 4, 'each'),
('Pumpkin Bars', 'Carly Duytschaver', 1, 2, 'cup'),
('Pumpkin Bars', 'Carly Duytschaver', 11, 1, 'can'),
('Pumpkin Bars', 'Carly Duytschaver', 19, 2, 'tsp'),
('Pumpkin Bars', 'Carly Duytschaver', 20, 1, 'tsp'),
('Pumpkin Bars', 'Carly Duytschaver', 7, 2, 'tsp'),
('Pumpkin Bars', 'Carly Duytschaver', 5, 0.5, 'tsp')
;
