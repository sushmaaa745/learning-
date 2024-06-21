-- 1. Procedure to Select All Squirrels
DELIMITER $$
CREATE PROCEDURE select_all_squirrels()
BEGIN
    -- Select all records from the squirrels table
    SELECT * FROM squirrels;
END$$
DELIMITER ;

-- Call the procedure
CALL select_all_squirrels();


-- 2. Function to Calculate Average Weight of Squirrels
DELIMITER $$
CREATE FUNCTION get_average_weight()
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE avg_weight DECIMAL(5,2);
    -- Calculate the average weight of squirrels
    SELECT AVG(weight) INTO avg_weight FROM squirrels;
    RETURN avg_weight;
END$$
DELIMITER ;

-- Call the function
SELECT get_average_weight();


-- 3. Procedure with IN Parameter to Retrieve Squirrel Details
DELIMITER $$
CREATE PROCEDURE get_squirrel_details(IN squirrel_id INT)
BEGIN
    -- Select squirrel details based on the given squirrel_id
    SELECT * FROM squirrels WHERE squirrel_id = squirrel_id;
END$$
DELIMITER ;

-- Call the procedure with a specific squirrel_id
CALL get_squirrel_details(3);


-- 4. Procedure with OUT Parameter to Count Squirrels
DELIMITER $$
CREATE PROCEDURE get_squirrel_count(OUT squirrel_count INT)
BEGIN
    -- Count the total number of squirrels
    SELECT COUNT(*) INTO squirrel_count FROM squirrels;
END$$
DELIMITER ;

-- Call the procedure and store the result in a variable
CALL get_squirrel_count(@count);
-- Select the variable to display the count
SELECT @count AS squirrel_count;


-- 5. Procedure Using Predefined SUM() Cursor to Calculate Total Weight of Squirrels
DELIMITER $$
CREATE PROCEDURE calc_total_squirrel_weight(OUT total_weight DECIMAL(10,2))
BEGIN
    -- Calculate the total weight of all squirrels
    SELECT SUM(weight) INTO total_weight FROM squirrels;
END$$
DELIMITER ;

-- Call the procedure and store the result in a variable
CALL calc_total_squirrel_weight(@total_weight);
-- Select the variable to display the total weight
SELECT @total_weight AS total_squirrel_weight;


-- 6. Procedure to Iterate Through Squirrels and Print Their Names
DELIMITER //
CREATE PROCEDURE print_squirrel_names()
BEGIN
    DECLARE squirrel_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    -- Declare a cursor for selecting all squirrel names
    DECLARE squirrel_cursor CURSOR FOR SELECT name FROM squirrels;
    -- Handler for cursor not found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN squirrel_cursor;

    get_names: LOOP
        -- Fetch the next squirrel name into the variable
        FETCH squirrel_cursor INTO squirrel_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        -- Print the fetched squirrel name
        SELECT squirrel_name;
    END LOOP get_names;

    -- Close the cursor
    CLOSE squirrel_cursor;
END;
DELIMITER ;


-- 7. Procedure to Select All Habitats
DELIMITER $$
CREATE PROCEDURE select_all_habitats()
BEGIN
    -- Select all records from the habitats table
    SELECT * FROM habitats;
END$$
DELIMITER ;

-- Call the procedure
CALL select_all_habitats();


-- 8. Function to Calculate the Total Number of Habitats for a Specific Food Supply Type
DELIMITER $$
CREATE FUNCTION get_total_habitats(food_type VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_habitats INT;
    -- Count the number of habitats with the specified food supply type
    SELECT COUNT(*) INTO total_habitats FROM habitats WHERE food_supply = food_type;
    RETURN total_habitats;
END$$
DELIMITER ;

-- Call the function with a specific food supply type
SELECT get_total_habitats('nuts');


-- 9. Procedure with IN Parameter to Retrieve Habitat Details
DELIMITER $$
CREATE PROCEDURE get_habitat_details(IN habitat_id INT)
BEGIN
    -- Select habitat details based on the given habitat_id
    SELECT * FROM habitats WHERE habitat_id = habitat_id;
END$$
DELIMITER ;

-- Call the procedure with a specific habitat_id
CALL get_habitat_details(2);


-- 10. Procedure with OUT Parameter to Count Different Species
DELIMITER $$
CREATE PROCEDURE get_species_count(OUT species_count INT)
BEGIN
    -- Count the number of distinct species in the squirrels table
    SELECT COUNT(DISTINCT species) INTO species_count FROM squirrels;
END$$
DELIMITER ;

-- Call the procedure and store the result in a variable
CALL get_species_count(@count);
-- Select the variable to display the count
SELECT @count AS species_count;


-- 11. Use Predefined SUM() Cursor to Calculate Total Weight of Squirrels in a Specific Habitat
DELIMITER $$
CREATE PROCEDURE calc_habitat_squirrel_weight(IN habitat_location VARCHAR(100), OUT total_weight DECIMAL(10,2))
BEGIN
    -- Calculate the total weight of squirrels in the specified habitat
    SELECT SUM(s.weight) INTO total_weight
    FROM squirrels s
    JOIN habitats h ON s.squirrel_id = h.squirrel_id
    WHERE h.location = habitat_location;
END$$
DELIMITER ;

-- Call the procedure with a specific habitat location and store the result in a variable
CALL calc_habitat_squirrel_weight('Forest', @total_weight);
-- Select the variable to display the total weight
SELECT @total_weight AS total_weight;


-- 12. Procedure to Iterate Through the Squirrels Table and Print Each Squirrel's Species
DELIMITER //
CREATE PROCEDURE print_squirrel_species()
BEGIN
    DECLARE squirrel_species VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    -- Declare a cursor for selecting all squirrel species
    DECLARE squirrel_cursor CURSOR FOR SELECT species FROM squirrels;
    -- Handler for cursor not found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN squirrel_cursor;

    get_species: LOOP
        -- Fetch the next squirrel species into the variable
        FETCH squirrel_cursor INTO squirrel_species;
        IF done THEN
            LEAVE get_species;
        END IF;
        -- Print the fetched squirrel species
        SELECT squirrel_species;
    END LOOP get_species;

    -- Close the cursor
    CLOSE squirrel_cursor;
END;
DELIMITER ;