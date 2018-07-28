create database testdb;

use testdb;

CREATE TABLE IF NOT EXISTS `test_table` (
	`id` int(10) NOT NULL auto_increment,
	`name` varchar(255),
	`comments` varchar(255),
	PRIMARY KEY( `id` )
);

INSERT INTO `test_table` values (default, 'James Smith', 'express server engineer');
INSERT INTO `test_table` values (default, 'Mary Hernandez', 'ember server engineer');
INSERT INTO `test_table` values (default, 'Amit Rodriguez', 'docker engineer');
INSERT INTO `test_table` values (default, 'Andy Khol', 'mysql-server engineer');
INSERT INTO `test_table` values (default, 'Selena wright', 'performance test engineer');
INSERT INTO `test_table` values (default, 'Sam Brown', 'process engineer');
INSERT INTO `test_table` values (default, 'Peter Singh', 'project manager');
