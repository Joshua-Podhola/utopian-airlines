-- MySQL Script generated by MySQL Workbench
-- Sun Apr 25 18:45:05 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema utopia_airlines
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `utopia_airlines` ;

-- -----------------------------------------------------
-- Schema utopia_airlines
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `utopia_airlines` DEFAULT CHARACTER SET utf8 ;
USE `utopia_airlines` ;

-- -----------------------------------------------------
-- Table `utopia_airlines`.`airport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`airport` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`airport` (
  `iata_id` CHAR(3) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iata_id`),
  UNIQUE INDEX `iata_id_UNIQUE` (`iata_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utopia_airlines`.`route`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`route` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`route` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `origin_id` CHAR(3) NOT NULL,
  `destination_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`, `origin_id`, `destination_id`),
  INDEX `fk_route_airport1_idx` (`origin_id` ASC) VISIBLE,
  INDEX `fk_route_airport2_idx` (`destination_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_route` (`origin_id` ASC, `destination_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_route_airport1`
    FOREIGN KEY (`origin_id`)
    REFERENCES `utopia_airlines`.`airport` (`iata_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_route_airport2`
    FOREIGN KEY (`destination_id`)
    REFERENCES `utopia_airlines`.`airport` (`iata_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utopia_airlines`.`airplane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`airplane` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`airplane` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `capacity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utopia_airlines`.`flight`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`flight` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`flight` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `route_id` INT UNSIGNED NOT NULL,
  `airplane_id` INT UNSIGNED NOT NULL,
  `departure_time` DATETIME NOT NULL,
  `economy_seats` INT UNSIGNED ZEROFILL NOT NULL,
  `business_seats` INT UNSIGNED ZEROFILL NOT NULL,
  `firstclass_seats` INT UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_flight_tbl_route1_idx` (`route_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_flight_airplane1_idx` (`airplane_id` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_flight_tbl_route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `utopia_airlines`.`route` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_flight_airplane1`
    FOREIGN KEY (`airplane_id`)
    REFERENCES `utopia_airlines`.`airplane` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utopia_airlines`.`traveller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`traveller` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`traveller` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `given_name` VARCHAR(255) NOT NULL,
  `family_name` VARCHAR(255) NOT NULL,
  `membership_number` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `membership_number_UNIQUE` (`membership_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `utopia_airlines`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utopia_airlines`.`ticket` ;

CREATE TABLE IF NOT EXISTS `utopia_airlines`.`ticket` (
  `flight_id` INT UNSIGNED NOT NULL,
  `traveller_id` INT UNSIGNED NOT NULL,
  `seat_class` ENUM("ECONOMY", "FIRST", "BUSINESS") NOT NULL,
  `is_cancelled` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_flight_bookings_flight` (`flight_id` ASC) VISIBLE,
  PRIMARY KEY (`flight_id`, `traveller_id`),
  INDEX `fk_ticket_traveller1_idx` (`traveller_id` ASC) VISIBLE,
  CONSTRAINT `fk_flight_bookings_flight`
    FOREIGN KEY (`flight_id`)
    REFERENCES `utopia_airlines`.`flight` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_traveller1`
    FOREIGN KEY (`traveller_id`)
    REFERENCES `utopia_airlines`.`traveller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `utopia_airlines`;

DELIMITER $$

USE `utopia_airlines`$$
DROP TRIGGER IF EXISTS `utopia_airlines`.`route_BEFORE_INSERT` $$
USE `utopia_airlines`$$
CREATE DEFINER = CURRENT_USER TRIGGER `utopia_airlines`.`route_BEFORE_INSERT` BEFORE INSERT ON `route` FOR EACH ROW
BEGIN
	IF (NEW.origin_id = NEW.destination_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'origin cannot be same as destination';
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`airport`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('JFK', 'New York');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('PDX', 'Portland');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAA', 'Anaa');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAB', 'Arrabury');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAC', 'El Arish');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAD', 'Adado');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAE', 'Annaba');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAF', 'Apalachicola');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAG', 'Arapoti');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAH', 'Aachen');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('AAI', 'Arraias');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('BAA', 'Bialla');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('BAB', 'Marysville');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('CAA', 'Catacamas');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('CAB', 'Cabinda');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('DAA', 'Fort Belvoir');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('DAB', 'Daytona Beach');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('EAA', 'Eagle');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('EAB', 'Abbs');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('FAA', 'Faranah');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('FAB', 'Farnborough');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('GAA', 'Guamal');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('GAB', 'Gabbs');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('HAA', 'Hasvik');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('HAB', 'Hamilton');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('IAA', 'Igarka');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('IAB', 'Wichita');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('JAA', 'Jalalabad');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('JAB', 'Jabiru');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('KAA', 'Kasama');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('KAB', 'Kariba');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('LAA', 'Lamar');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('LAB', 'Lab Lab');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('MAA', 'Chennai');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('MAB', 'Marab??');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('NAA', 'Narrabri');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('NAC', 'Narcoorte');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('OAA', 'Gardez');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('OAG', 'Orange');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('PAA', 'Hpa-An');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('PAB', 'Bilaspur');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('QAQ', 'L\'Aquila');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('QBC', 'Bella Coola');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('RAA', 'Rakanda');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('RAB', 'Rabaul');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('SAA', 'Saratoga');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('SAB', 'Saba');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('TAA', 'Tarapaina');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('TAB', 'Tobago');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('UAB', 'Adana');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('UAC', 'San Luis R??o Colorado');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('VAA', 'Vaasa');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('VAB', 'Yavarate');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('WAA', 'Wales');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('WAC', 'Wacca');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('XAI', 'Xinyang');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('XAL', '??lamos');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('YAA', 'Anahim Lake');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('YAB', 'Arctic Bay');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('ZAA', 'Alice Arm');
INSERT INTO `utopia_airlines`.`airport` (`iata_id`, `city`) VALUES ('ZAC', 'York Landing');

COMMIT;


-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`route`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (1, 'JFK', 'PDX');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (2, 'PDX', 'JFK');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (3, 'EAB', 'QAQ');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (4, 'MAB', 'MAA');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (5, 'XAI', 'SAB');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (6, 'ZAA', 'ZAC');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (7, 'FAA', 'UAB');
INSERT INTO `utopia_airlines`.`route` (`id`, `origin_id`, `destination_id`) VALUES (8, 'TAB', 'LAB');

COMMIT;


-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`airplane`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`airplane` (`id`, `capacity`) VALUES (1, 300);
INSERT INTO `utopia_airlines`.`airplane` (`id`, `capacity`) VALUES (2, 250);

COMMIT;


-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`flight`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`flight` (`id`, `route_id`, `airplane_id`, `departure_time`, `economy_seats`, `business_seats`, `firstclass_seats`) VALUES (1, 1, 1, '2021-04-25 18:30:00', 36, 2, 0);
INSERT INTO `utopia_airlines`.`flight` (`id`, `route_id`, `airplane_id`, `departure_time`, `economy_seats`, `business_seats`, `firstclass_seats`) VALUES (2, 2, 1, '2021-04-26 21:45:00', 69, 13, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`traveller`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (1, 'given1', 'family1', 'M123321');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (2, 'given2', 'family2', 'M234432');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (3, 'given3', 'family3', 'M345543');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (4, 'given4', 'family4', 'M456654');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (5, 'given5', 'family5', 'M567765');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (6, 'given6', 'family6', 'M678876');
INSERT INTO `utopia_airlines`.`traveller` (`id`, `given_name`, `family_name`, `membership_number`) VALUES (7, 'given7', 'family7', 'M789987');

COMMIT;


-- -----------------------------------------------------
-- Data for table `utopia_airlines`.`ticket`
-- -----------------------------------------------------
START TRANSACTION;
USE `utopia_airlines`;
INSERT INTO `utopia_airlines`.`ticket` (`flight_id`, `traveller_id`, `seat_class`, `is_cancelled`) VALUES (1, 1, 'ECONOMY', 0);
INSERT INTO `utopia_airlines`.`ticket` (`flight_id`, `traveller_id`, `seat_class`, `is_cancelled`) VALUES (1, 2, 'BUSINESS', 0);
INSERT INTO `utopia_airlines`.`ticket` (`flight_id`, `traveller_id`, `seat_class`, `is_cancelled`) VALUES (1, 3, 'FIRST', 0);
INSERT INTO `utopia_airlines`.`ticket` (`flight_id`, `traveller_id`, `seat_class`, `is_cancelled`) VALUES (1, 4, 'ECONOMY', 1);

COMMIT;

