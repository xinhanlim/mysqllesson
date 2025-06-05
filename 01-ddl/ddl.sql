-- showdatabases in the sever, tradition(type in full uppercase)
SHOW DATABASES;

--create a new database
-- CREATE DATABASE <NAME OF DATABASE>
CREATE DATABASE swimming_coach;

--MariaDB  [(none)]:, the none means active database

--set the current active database
--USER <name of database>
USE swimming_coach;


--CREATE TABLE<name of table> ( <column name> <data type> <options>, <column name 2> <data type> <options> )
--auto_increment means auto give the first row 1, only use for primary key
CREATE TABLE parents (
    parents_id int unsigned primary key auto_increment,
    name varchar(100) not null,
    contact_number varchar(20) not null,
    address varchar(500) not null
) engine = innodb ;

--show all tables in he current active database
SHOW TABLES;

--show the colums of a table
DESCRIBE parents;

CREATE TABLE sessions(
    sessions_id int unsigned primary key auto_increment,
    date_and_time datetime not null
) engine = innodb;

--create the student table
CREATE TABLE students(
    student_id int unsigned primary key auto_increment,
    name varchar(100) not null,
    gender varchar(2) not null,
    swimming_grade tinyint unsigned,
    date_of_birth datetime
) engine = innodb;

--makes changes to the columns of an existing table
ALTER TABLE students modify column date_of_birth not null;

--add a new column to a table
alter table students add column parents_id int unsigned not null;

--confiur students.parent_id column as FK to parents.parent_id column
alter table students add constraint fk_parents_students
    foreign key (parents_id) references parents(parents_id);

--INSERTING rows in a table ( Data Manupluation Langauge)
INSERT into parents (name,contact_number,address) values("Tan Ah Kow", "12341234", "Yishun Ring Road");

--we use DQL ( Data Query Lanugage to see content)
select * FROM parents;

--insert a students; need a foreign key to the parents
insert into students (name, gender, swimming_grade, date_of_birth, parents_id) 
values("Tan Ah Mew", "f" , 1, "2024-05-31",1);

-- add a temporary students that is to be deleted
alter table students add column test varchar(100);

-- to delete a column
alter table students drop column test;