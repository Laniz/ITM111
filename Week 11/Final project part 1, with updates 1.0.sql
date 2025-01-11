-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `project` ;

-- -----------------------------------------------------
-- Schema project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema enrollment_project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `enrollment_project` ;

-- -----------------------------------------------------
-- Schema enrollment_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enrollment_project` DEFAULT CHARACTER SET utf8mb3 ;
USE `project` ;

-- -----------------------------------------------------
-- Table `project`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`artist` ;

CREATE TABLE IF NOT EXISTS `project`.`artist` (
  `artist_id` INT UNSIGNED NOT NULL,
  `artist_name` VARCHAR(45) NOT NULL,
  `artist_dob` DATE NOT NULL,
  `artist_bio` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`album` ;

CREATE TABLE IF NOT EXISTS `project`.`album` (
  `album_id` INT UNSIGNED NOT NULL,
  `album_title` VARCHAR(45) NOT NULL,
  `album_release_date` DATE NOT NULL,
  `artist_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `fk_album_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `album_fk1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `project`.`artist` (`artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`user` ;

CREATE TABLE IF NOT EXISTS `project`.`user` (
  `user_id` INT UNSIGNED NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_number` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`song` ;

CREATE TABLE IF NOT EXISTS `project`.`song` (
  `song_id` INT UNSIGNED NOT NULL,
  `song_title` VARCHAR(45) NOT NULL,
  `album_id` INT UNSIGNED NOT NULL,
  `artist_id` INT UNSIGNED NOT NULL,
  `song_length` INT NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `song_release_date` DATE NOT NULL,
  PRIMARY KEY (`song_id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `song_fk2_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `song_fk1`
    FOREIGN KEY (`album_id`)
    REFERENCES `project`.`album` (`album_id`),
  CONSTRAINT `song_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `project`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`favorite` ;

CREATE TABLE IF NOT EXISTS `project`.`favorite` (
  `favorites_id` INT UNSIGNED NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  `add_date` DATE NOT NULL,
  PRIMARY KEY (`favorites_id`),
  INDEX `fk_favorite_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_favorite_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`following`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`following` ;

CREATE TABLE IF NOT EXISTS `project`.`following` (
  `following_id` INT UNSIGNED NOT NULL,
  `artist_id` INT UNSIGNED NOT NULL,
  `following_start_date` DATE NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`following_id`),
  INDEX `fk_following_artist1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_following_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `following_fk1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `project`.`artist` (`artist_id`),
  CONSTRAINT `following_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `project`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`genre` ;

CREATE TABLE IF NOT EXISTS `project`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL,
  `genre_name` VARCHAR(45) NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`genre_id`),
  INDEX `fk_genre_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `genre_fk1`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`language` ;

CREATE TABLE IF NOT EXISTS `project`.`language` (
  `language_id` INT UNSIGNED NOT NULL,
  `lang` CHAR(2) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`lang_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`lang_lookup` ;

CREATE TABLE IF NOT EXISTS `project`.`lang_lookup` (
  `lookup_id` INT UNSIGNED NOT NULL,
  `lookup_name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `language_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`lookup_id`),
  INDEX `fk_lang_lookup_language1_idx` (`language_id` ASC) VISIBLE,
  INDEX `lang_lookup_fk2_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `lang_lookup_fk1`
    FOREIGN KEY (`language_id`)
    REFERENCES `project`.`language` (`language_id`),
  CONSTRAINT `lang_lookup_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `project`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`playlist` ;

CREATE TABLE IF NOT EXISTS `project`.`playlist` (
  `playlsit_id` INT UNSIGNED NOT NULL,
  `playlsit_name` VARCHAR(45) NOT NULL,
  `playlsit_creation_date` DATE NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`playlsit_id`),
  INDEX `fk_playlsit_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `playlist_fk2_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `playlist_fk1`
    FOREIGN KEY (`user_id`)
    REFERENCES `project`.`user` (`user_id`),
  CONSTRAINT `playlist_fk2`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`playlist_song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`playlist_song` ;

CREATE TABLE IF NOT EXISTS `project`.`playlist_song` (
  `playlsit_id` INT UNSIGNED NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`playlsit_id`, `song_id`),
  INDEX `fk_playlsit_song_song1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_playlsit_song_playlsit1_idx` (`playlsit_id` ASC) VISIBLE,
  CONSTRAINT `playlsit_song_fk1`
    FOREIGN KEY (`playlsit_id`)
    REFERENCES `project`.`playlist` (`playlsit_id`),
  CONSTRAINT `playlsit_song_fk2`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`rating_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`rating_review` ;

CREATE TABLE IF NOT EXISTS `project`.`rating_review` (
  `rating_id` INT UNSIGNED NOT NULL,
  `rating` VARCHAR(45) NOT NULL,
  `review` VARCHAR(45) NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rating_id`),
  INDEX `fk_rating_review_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `rating_review_fk2_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `rating_review_fk1`
    FOREIGN KEY (`user_id`)
    REFERENCES `project`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `rating_review_fk2`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`search_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`search_history` ;

CREATE TABLE IF NOT EXISTS `project`.`search_history` (
  `search_history_id` INT UNSIGNED NOT NULL,
  `search_query` VARCHAR(45) NOT NULL,
  ` search_date` DATE NOT NULL,
  `song_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`search_history_id`),
  INDEX `song_id_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`song_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`song_tags` ;

CREATE TABLE IF NOT EXISTS `project`.`song_tags` (
  `song_tags_id` INT UNSIGNED NOT NULL,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`song_tags_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`song_song_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`song_song_tags` ;

CREATE TABLE IF NOT EXISTS `project`.`song_song_tags` (
  `song_id` INT UNSIGNED NOT NULL,
  `song_tags_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`song_id`, `song_tags_id`),
  INDEX `fk_song_song_tags_song_tags1_idx` (`song_tags_id` ASC) VISIBLE,
  INDEX `fk_song_song_tags_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `song_song_tags_fk1`
    FOREIGN KEY (`song_id`)
    REFERENCES `project`.`song` (`song_id`),
  CONSTRAINT `song_song_tags_song_fk2`
    FOREIGN KEY (`song_tags_id`)
    REFERENCES `project`.`song_tags` (`song_tags_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `enrollment_project` ;

-- -----------------------------------------------------
-- Table `enrollment_project`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`college` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE INDEX `college_id_UNIQUE` (`college_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1004
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`department` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`department` (
  `department_code` VARCHAR(45) NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_code`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  UNIQUE INDEX `department_code_UNIQUE` (`department_code` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `enrollment_project`.`college` (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1004
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`courses` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_credits` INT NOT NULL,
  `department_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC) VISIBLE,
  INDEX `fk_courses_department1_idx` (`department_code` ASC) VISIBLE,
  CONSTRAINT `fk_courses_department1`
    FOREIGN KEY (`department_code`)
    REFERENCES `enrollment_project`.`department` (`department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1005
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`term` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`),
  UNIQUE INDEX `term_id_UNIQUE` (`term_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1003
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`faculty` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`),
  UNIQUE INDEX `faculity_id_UNIQUE` (`faculty_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1006
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`sections` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`sections` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_number` INT NOT NULL,
  `section_capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE INDEX `sections_id_UNIQUE` (`section_id` ASC) VISIBLE,
  INDEX `fk_sections_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_sections_courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_sections_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `enrollment_project`.`courses` (`course_id`),
  CONSTRAINT `fk_sections_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `enrollment_project`.`term` (`term_id`),
  CONSTRAINT `fk_sections_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `enrollment_project`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1011
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`student` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `student_dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1011
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enrollment_project`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_sections_student_student1_idx` (`student_id` ASC) VISIBLE, 
  INDEX `fk_sections_student_sections1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_student_sections1`
    FOREIGN KEY (`section_id`)
    REFERENCES `enrollment_project`.`sections` (`section_id`),
  CONSTRAINT `fk_sections_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `enrollment_project`.`student` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- INSERT STATEMENTS
-- -----------------------------------------------------

USE enrollment_project;

INSERT INTO student (student_id, f_name, l_name, gender, city, state, student_dob)
VALUES (1001, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22')
,	(1002, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22')
,	(1003, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22')
,	(1004, 'Devon', 'Merril', 'M', 'Messa', 'AZ', '2000-07-22')
,	(1005, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22')
,	(1006, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22')
,	(1007, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22')
,	(1008, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22')
,	(1009, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22')
,	(1010, 'Susan', 'Sorensen', 'F', 'Messa', 'AZ', '1998-08-09');

INSERT INTO term (term_id, term, year)
Values('1001', 'Fall', 2019)
,	('1002', 'Winter', 2018);

-- still need to create inserts for sections

INSERT INTO college (college_id, college_name)
VALUES(1001,'College of Physical Science and Engineering')
,	(1002, 'College of Business and Communication')
,	(1003, 'College of Language and Letters');

INSERT INTO department (department_code, department_name, college_id)
VALUES('CIT', 'Computer Information Technology', 1001)
,	('ECON', 'Economics', 1002)
,	('HUM', 'Humanities and Philosophy', 1003);

INSERT INTO courses (course_id, course_num, course_credits, department_code)
VALUES('1001', 111, 3, 'CIT')
,	('1002', 388, 4, 'ECON')
,	('1003', 150, 3, 'ECON')
,	('1004', 376, 2, 'HUM');

INSERT INTO faculty (faculty_id, faculty_fname, faculty_lname)
VALUES(1001, 'Marty', 'Morring')
,	(1002, 'Nate', 'Norris')
,	(1003, 'Ben', 'Barrus')
,	(1004, 'John', 'Jensen')
,	(1005, 'Bill', 'Barney');

INSERT INTO sections(section_id, section_number, section_capacity, course_id, term_id, faculty_id)
VALUES(1001, 1, 30, 1001, 1001, 1001)
,	(1002, 1, 50, 1003, 1001, 1002)
,	(1003, 2, 50, 1003, 1001, 1002)
,	(1004, 1, 35, 1002, 1001, 1003)
,	(1005, 1, 30, 1004, 1001, 1004)
,	(1006, 2, 30, 1001, 1002, 1001)
,	(1007, 3, 35, 1001, 1002, 1005)
,	(1008, 1, 50, 1003, 1002, 1002)
,	(1009, 2, 50, 1003, 1002, 1002)
,	(1010, 1, 30, 1004, 1002, 1004);

INSERT INTO enrollment(student_id, section_id)
VALUES(1006, 1007)
,	(1007, 1006)
,	(1007, 1008)
,	(1007, 1010)
,	(1004, 1005)
,	(1009, 1009)
,	(1002, 1004)
,	(1003, 1004)
,	(1005, 1004)
,	(1005, 1005)
,	(1001, 1001)
,	(1001, 1003)
,	(1008, 1009)
,	(1010, 1006);

-- select * from student;
-- select * from faculty;
-- select * from college;
-- select * from courses;
-- select * from department;
-- select * from enrollment;
-- select * from sections;
-- select * from term;

-- catalog view


SELECT college.college_name
	, department.department_name
    , department.department_code
    , courses.course_num
    , courses.course_credits
FROM courses
JOIN department ON courses.department_code = department.department_code
JOIN college ON department.college_id = college.college_id;


-- section view


 SELECT term.year, 
		term.term,
       courses.department_code,
       courses.course_num,
       sections.section_number,
       faculty.faculty_fname,
       faculty.faculty_lname,
       sections.section_capacity
FROM term
JOIN sections ON term.term_id = sections.term_id
JOIN faculty ON faculty.faculty_id = sections.faculty_id
JOIN courses On sections.course_id = courses.course_id;


-- Student view

SELECT * FROM student; 

-- Enrollment view

SELECT concat(f_name, ' enrolling in ',
       courses.department_code, ' ', 
       courses.course_num, ' ',
       term.term, ' ',
       term.year, ' Section ',
       sections.section_number) AS enrollment
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN courses ON courses.course_id = sections.course_id
JOIN term ON term.term_id = sections.term_id
ORDER BY f_name; 



