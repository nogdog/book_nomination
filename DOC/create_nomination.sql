SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `book_nomination` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `book_nomination` ;

-- -----------------------------------------------------
-- Table `book_nomination`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `book_nomination`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT ,
  `login_name` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  `real_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`user_id`) ,
  UNIQUE INDEX `login_name_UNIQUE` (`login_name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_nomination`.`poll`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `book_nomination`.`poll` (
  `poll_id` INT NOT NULL AUTO_INCREMENT ,
  `end_timestamp` DATETIME NOT NULL ,
  `title` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  `creator_user_id` INT NOT NULL ,
  PRIMARY KEY (`poll_id`) ,
  INDEX `fk_poll_user1_idx` (`creator_user_id` ASC) ,
  CONSTRAINT `fk_poll_user1`
    FOREIGN KEY (`creator_user_id` )
    REFERENCES `book_nomination`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_nomination`.`nomination`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `book_nomination`.`nomination` (
  `nomination_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `poll_id` INT UNSIGNED NOT NULL ,
  `book_link` VARCHAR(255) NOT NULL ,
  `description` TEXT NOT NULL ,
  `discussion_topics` TEXT NULL ,
  `user_id` INT UNSIGNED NOT NULL ,
  `nomination_timestamp` TIMESTAMP NOT NULL DEFAULT NOW() ,
  `second_user_id` INT UNSIGNED NULL ,
  `second_timestamp` TIMESTAMP NULL ,
  PRIMARY KEY (`nomination_id`) ,
  INDEX `fk_nomination_poll_idx` (`poll_id` ASC) ,
  INDEX `fk_nomination_user1_idx` (`user_id` ASC) ,
  INDEX `fk_nomination_user2_idx` (`second_user_id` ASC) ,
  CONSTRAINT `fk_nomination_poll`
    FOREIGN KEY (`poll_id` )
    REFERENCES `book_nomination`.`poll` (`poll_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nomination_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `book_nomination`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nomination_user2`
    FOREIGN KEY (`second_user_id` )
    REFERENCES `book_nomination`.`user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `book_nomination` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
