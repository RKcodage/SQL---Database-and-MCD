-- SQLite
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS categories_recipes;
DROP TABLE IF EXISTS ingredients_recipes;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS ingredients;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
); 

/* 'ON DELETE CASCADE' = to erase all data of an user if he is deleted*/
CREATE TABLE recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50),
    date DATETIME,
    duration INTEGER DEFAULT O NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE 
);

CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE categories_recipes (
    recipe_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, category_id),
    UNIQUE (recipe_id, category_id)
);

CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(150)
);

CREATE TABLE ingredients_recipes (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(50),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
);

INSERT INTO users (username, email) VALUES
    ('John Doe', 'john@doe.fr');

INSERT INTO categories (title) VALUES 
    ('Plat'),
    ('Dessert'),
    ('Gateau');

INSERT INTO recipes (title, slug, duration, user_id) VALUES
    ('Soupe','soupe', 10, 1),
    ('Madeleine','madeleine', 30, 1);

INSERT INTO categories_recipes (recipe_id, category_id) VALUES
    (1,1),
    (2,2),
    (2,3);

INSERT INTO ingredients (name) VALUES
    ('Sucre'),
    ('Farine'),
    ('Levure chimique'),
    ('Beurre'),
    ('Lait'),
    ('Oeuf');

INSERT INTO ingredients_recipes (recipe_id, ingredient_id, quantity, unit) VALUES
    (2, 1, 150, 'g'),
    (2, 2, 200, 'g'),
    (2, 3, 8, 'g'),
    (2, 4, 100, 'g'),
    (2, 5, 50, 'g'),
    (2, 6, 3, NULL);
    

/* Request to find recipes wich contain eggs */
/* SELECT recipes.title
FROM ingredients
JOIN ingredients_recipes ON ingredients_recipes.ingredient_id = ingredients.id
JOIN recipes ON ingredients_recipes.recipe_id = recipes.id
WHERE ingredients.name = 'Oeuf';
*/

/* Request to find ingredients and quantities by recipe */
/* SELECT recipes.title, ingredients_recipes.quantity, ingredients.name as ingredient 
FROM recipes 
JOIN ingredients_recipes ON ingredients_recipes.recipe_id = recipes.id
JOIN ingredients ON ingredients_recipes.ingredient_id = ingredients.id;
*/

/* Request to update */
/* UPDATE ingredients_recipes
SET quantity = 10
WHERE recipe_id = 2 AND ingredient_id = 3;
*/

/* 
UPDATE ingredients_recipes
SET unit = 'pièces'
WHERE recipe_id = 2 AND ingredient_id = 6;
*/

