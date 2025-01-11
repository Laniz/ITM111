-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artist` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` INT NOT NULL,
  `date_of_death` INT NULL,
  `country` VARCHAR(45) NOT NULL,
  `is_local` ENUM('y', 'n') NOT NULL,
  PRIMARY KEY (`artist_id`),
  UNIQUE INDEX `artist_id_UNIQUE` (`artist_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artwork` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artwork` (
  `artwork_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `period` VARCHAR(45) NOT NULL,
  `type` ENUM('Oil', 'Watercolor', 'Tempra') NOT NULL,
  `filename` VARCHAR(45) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `artist_id`),
  UNIQUE INDEX `artwork_id_UNIQUE` (`artwork_id` ASC) VISIBLE,
  INDEX `fk_artwork_artist_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mydb`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`keyword` ;

CREATE TABLE IF NOT EXISTS `mydb`.`keyword` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `keyword_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  UNIQUE INDEX `Keyword_id_UNIQUE` (`keyword_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`keyword_artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`keyword_artwork` ;

CREATE TABLE IF NOT EXISTS `mydb`.`keyword_artwork` (
  `keyword_id` INT NOT NULL,
  `artwork_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`keyword_id`, `artwork_id`, `artist_id`),
  INDEX `fk_Keyword_artwork_artwork1_idx` (`artwork_id` ASC, `artist_id` ASC) VISIBLE,
  INDEX `fk_Keyword_artwork_Keyword1_idx` (`keyword_id` ASC) VISIBLE,
  CONSTRAINT `fk_Keyword_artwork_Keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `mydb`.`keyword` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Keyword_artwork_artwork1`
    FOREIGN KEY (`artwork_id` , `artist_id`)
    REFERENCES `mydb`.`artwork` (`artwork_id` , `artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE mydb;

INSERT INTO artist (artist_id, first_name, middle_name, last_name, date_of_birth,
	date_of_death, country, is_local) 
    VALUES('1', 'Vincent', NULL,'Van Gogh', '1853', '1890','France','n'), 
    ('2', 'Rembrandt', 'Harmenszoon','van Rijn', '1606', '1669','Netherlands','n'),
    ('3', 'Leonardo', NULL,'da Vinci', '1452', '1519','Italy','n'),
    ('4', 'Venture', 'Lonzo','Coy', '1965', NULL,'United States','y'),
    ('5', 'Deborah', NULL,'Gill', '1970', NULL,'United States','y'),
    ('6', 'Claude', NULL,'Monet', '1840', '1926','France','n'),
    ('7', 'Pablo', NULL,'Picasso', '1904', '1973','Spain','n'),
    ('8', 'Michelangelo', 'di Lodovico','Simoni', '1475', '1564','Italy','n');
    
INSERT INTO artwork (artwork_id, title, year, period, type, filename, artist_id)
	VALUES('1','Irises','1889', 'Impressionism','Oil','irises.jpg','1'),
    ('2','The Starry Night','1889', '9 Post-Impressionism','Oil','starrynight.jpg','1'),
	('3','Sunflowers','1888', '9 Post-Impressionism','Oil','sunflowers.jpg','1'),
    ('4','Night Watch','1642', 'Baroque','Oil','nightwatch.jpg','2'),
    ('5','Storm on the Sea of Galilee','1633', 'Dutch Golden Age','Oil','stormgalilee.jpg','2'),
    ('6','Head of a Woman','1508', 'High Renaissance','Oil','headwoman.jpg','3'),
    ('7','Last Supper','1498', 'Renaissance','Tempra','lastsupper.jpg','3'),
    ('8','Mona Lisa','1517', 'Renaissance','Oil','monalisa.jpg','3'),
    ('9','Hillside Stream','2005', 'Modern','Oil','hillsidestream.jpg','4'),
    ('10','Old Barn','1992', 'Modern','Oil','oldbarn.jpg','4'),
    ('11','Beach Baby','1999', 'Modern','Watercolor','r beachbaby.jpg','5'),
    ('12','Women in the Garden','1866', 'Impressionism','Watercolor','womengarden.jpg','6'),
    ('13','Women in the Garden','1866', 'Modern','Watercolor','womengarden.jpg','7');
    
INSERT INTO Keyword (keyword_id, Keyword_name)
	VALUES('1','flowers'),
    ('2','blue'),
    ('3','girl'),
	('4','people'),
	('5','battle'),
	('6','boat'),
	('7','water'),
	('8','people'),
    ('9','Christ'),
    ('10','food'),
    ('11','landscape'),
    ('12','baby');
    
INSERT INTO keyword_artwork (keyword_id, artwork_id, artist_id)
	VALUES('1','1','1'),
    ('2','2','1'),
    ('11','2','1'),
	('1','3','1'),
    ('3','4','2'),
    ('4','4','2'),
    ('5','4','2'),
    ('6','5','2'),
    ('7','5','2'),
    ('8','5','2'),
    ('9','5','2'),
    ('3','6','3'),
    ('4','6','3'),
    ('10','7','3'),
    ('4','7','3'),
    ('9','7','3'),
    ('3','8','3'),
    ('4','8','3'),
    ('7','9','4'),
    ('11','9','4'),
    ('11','10','4'),
    ('7','11','5'),
    ('4','11','5'),
    ('12','11','5'),
    ('11','12','6'),
    ('4','12','6'),
    ('1','12','6'),
    ('2','13','7'),
    ('4','13','7');
    
SELECT * FROM artist;

SELECT * FROM artwork;

SELECT * FROM Keyword;

SELECT * FROM keyword_artwork;


    

