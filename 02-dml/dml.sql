-- the DML is C,U and D of crud for the ROWS in the table

--INSERT INTO allows us to add a new row to a table
--INSERT INTO <table name> (<col1>, <col2>) VALUES ( <value1>, <value2> )
-- WE try to batc provessing with databes whenever possible

INSERT INTO parents (name, contact_number, address) VALUES 
("Peter Parker", "7127123", "New York City"),
("Tony Stare", "456456", "Avenger Tower");
 
INSERT INTO students (name,gender, date_of_birth, parent) VALUES
("Mary Baker", "F", NULL,  "2023-01-02", 3),
("James Stare", "M", 1, "2023-04-05");

-- engine = innodb, IS FOR THE Forgien Keys to work.

CREATE TABLE venues (
    venue_id INT unsigned Primary Key auto_increment,
    name VARCHAR(100) NOT NULL,
    capacity INT unsigned DEFAULT 10
) engine = innodb; 

--UPDATE EXSTING TOWS
--UPDATE <table ame> SET col1=val1, col2=val2... WHERE <some col>=<some value>

--DELETE EISTING ROWS
--DELETE FROM <table name< WHERE <some col>=<some value>
DELETE FROM parents WHERE 
