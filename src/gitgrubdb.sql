-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gitgrubdb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gitgrubdb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `gitgrubdb` ;

-- -----------------------------------------------------
-- Table `access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `access` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `access` (
  `id` INT NOT NULL,
  `access_level` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manager` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `manager` (
  `email` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(14) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `access_id` INT NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_manager_access_id`
    FOREIGN KEY (`access_id`)
    REFERENCES `access` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `access_id_idx` ON `manager` (`access_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` VARCHAR(15) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `open_time` TIME NULL,
  `close_time` TIME NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(14) NOT NULL,
  `manager_email` VARCHAR(45) NULL,
  `table_count` INT NULL COMMENT 'Null here would be for restaurant\nthat is delivery/ or pick-up ONLY\n',
  PRIMARY KEY (`id`),
  CONSTRAINT `fkey_manager_email`
    FOREIGN KEY (`manager_email`)
    REFERENCES `manager` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `manager_email_idx` ON `restaurant` (`manager_email` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `name_UNIQUE` ON `restaurant` (`name` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(15) NOT NULL,
  `start_time` TIME NULL COMMENT 'if null then all day menu\n',
  `end_time` TIME NULL COMMENT 'If time null then all day menu\n',
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`),
  CONSTRAINT `restaurant_id`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `restaurant_id_idx` ON `menu` (`restaurant_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `menu_section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_section` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `menu_section` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `section` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `menu_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_item` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT 'name of item (full stack burger, awesome sliced pizza)',
  `price` DECIMAL(7,2) NOT NULL,
  `description` VARCHAR(140) NULL,
  `rest_id` INT NOT NULL,
  `temp_id` INT NULL,
  `menusection_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fkey_menu_id`
    FOREIGN KEY (`menu_id`)
    REFERENCES `menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkey_menusection_id`
    FOREIGN KEY (`menusection_id`)
    REFERENCES `menu_section` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `menu_id_idx` ON `menu_item` (`menu_id` ASC);

SHOW WARNINGS;
CREATE INDEX `menusection_id_idx` ON `menu_item` (`menusection_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `customer` (
  `email` VARCHAR(30) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `access_id` INT NOT NULL,
  `phone` VARCHAR(14) NULL,
  `birth_day` DATE NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_customer_access_id`
    FOREIGN KEY (`access_id`)
    REFERENCES `access` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `customer` (`email` ASC);

SHOW WARNINGS;
CREATE INDEX `access_id_idx` ON `customer` (`access_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `order` (
  `orderid` INT NOT NULL AUTO_INCREMENT,
  `customer_email` VARCHAR(30) NOT NULL,
  `dateOrdered` DATE NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`orderid`),
  CONSTRAINT `fkey_customer_email`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `order` (`orderid` ASC);

SHOW WARNINGS;
CREATE INDEX `customer_email_idx` ON `order` (`customer_email` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `order_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `order_detail` (
  `orders_id` INT NOT NULL,
  `menuItems_id` INT NOT NULL,
  `lineItem` INT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`orders_id`, `menuItems_id`),
  CONSTRAINT `fk_orderDetails_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `order` (`orderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderDetails_menuItems1`
    FOREIGN KEY (`menuItems_id`)
    REFERENCES `menu_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_orderDetails_orders1_idx` ON `order_detail` (`orders_id` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_orderDetails_menuItems1_idx` ON `order_detail` (`menuItems_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `address` (
  `address_tag` VARCHAR(17) NOT NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  `customer_email` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`address_tag`, `customer_email`),
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `customer_id_idx` ON `address` (`customer_email` ASC);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `access`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `access` (`id`, `access_level`) VALUES (1, 1);
INSERT INTO `access` (`id`, `access_level`) VALUES (2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `manager`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `manager` (`email`, `phone`, `password`, `access_id`) VALUES ('tokyo_joe@mail.com', DEFAULT, 'password', 1);
INSERT INTO `manager` (`email`, `phone`, `password`, `access_id`) VALUES ('manager@panzano.com', DEFAULT, 'password', 1);
INSERT INTO `manager` (`email`, `phone`, `password`, `access_id`) VALUES ('manager@SB.com', DEFAULT, 'password', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `restaurant` (`id`, `category_id`, `name`, `open_time`, `close_time`, `street_address`, `city`, `state`, `zipcode`, `phone`, `manager_email`, `table_count`) VALUES (1, 'JAPANESE', 'Tokyo Joes', '1000', '2200', '6380 S Fiddlers Green Cir', 'Greenwood Village', 'CO', '80111', '(303)220-2877', 'tokyo_joe@mail.com', 30);
INSERT INTO `restaurant` (`id`, `category_id`, `name`, `open_time`, `close_time`, `street_address`, `city`, `state`, `zipcode`, `phone`, `manager_email`, `table_count`) VALUES (2, 'ITALIAN', 'Panzano', '630', '2300', '909 17th St', 'Denver', 'CO', '80202', '(303)296-3525', 'manager@panzano.com', 12);
INSERT INTO `restaurant` (`id`, `category_id`, `name`, `open_time`, `close_time`, `street_address`, `city`, `state`, `zipcode`, `phone`, `manager_email`, `table_count`) VALUES (3, 'AMERICAN(NEW)', 'The SportsBook Bar and Grill', '1100', '0200', '9660 E Arapahoe Rd', 'Greenwood Village', 'CO', '80112', '(303)799-1300', 'manager@SB.com', 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `menu` (`menu_id`, `type`, `start_time`, `end_time`, `restaurant_id`) VALUES (1, 'DINNER', '1700', '2200', 1);
INSERT INTO `menu` (`menu_id`, `type`, `start_time`, `end_time`, `restaurant_id`) VALUES (2, 'DINNER', '1600', '2300', 2);
INSERT INTO `menu` (`menu_id`, `type`, `start_time`, `end_time`, `restaurant_id`) VALUES (3, 'BAR', '1600', '2300', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_section`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `menu_section` (`id`, `section`) VALUES (1, 'APPETIZER');
INSERT INTO `menu_section` (`id`, `section`) VALUES (3, 'SALAD');
INSERT INTO `menu_section` (`id`, `section`) VALUES (20, 'SUSHI');
INSERT INTO `menu_section` (`id`, `section`) VALUES (2, 'ENTREE');
INSERT INTO `menu_section` (`id`, `section`) VALUES (4, 'DESERT');
INSERT INTO `menu_section` (`id`, `section`) VALUES (5, 'BEVERAGE');
INSERT INTO `menu_section` (`id`, `section`) VALUES (6, 'SIDE');
INSERT INTO `menu_section` (`id`, `section`) VALUES (10, 'PIZZA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (1, 'Gyoza', 3.99, 'Pork gyoza with Joe\'s dipping sauce', 1, NULL, 1, 1);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (2, 'Spring Rolls', 7.99, 'Chilled rice paper wraps with white chicken, tiger shrimp, or tofu', 1, NULL, 1, 1);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (3, 'California Roll', 5.99, 'Real crab, avocado, cucumber roll', 1, NULL, 20, 1);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (4, 'Tataki Salad', 12.99, 'Seared Ahi tuna, mixed greens, avocado, rice noodles', 1, NULL, 3, 1);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (5, 'Calamari', 11.00, 'Crispy calamari and spicey chili aioli', 2, NULL, 1, 2);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (6, 'Pastiche', 26.00, 'Layers of spicy meatballs and cheese tortellini', 2, NULL, 2, 2);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (7, 'Risotto', 8.00, 'Speck, butternut squash, and porcini', 2, NULL, 2, 2);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (8, 'Tiramisu', 9.00, 'Espresso soaked lady fingers layered with ameretto, mascarpone, and finished with cocoa', 2, NULL, 4, 2);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (9, 'Shock Top', 4.00, 'Belgium White AVB 5.2%', 3, NULL, 5, 3);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (10, 'Signature Margarita', 9.75, 'Cazadores Resposado cointreau, lime juice ', 3, NULL, 5, 3);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (11, 'Bottomless Chips and Salsa', 3.95, NULL, 3, NULL, 1, 3);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (12, 'Caesar Salad', 6.45, 'Romaine Lettuce, Croutons, Parmesan Cheese tossed in a Caesar dressing', 3, NULL, 3, 3);
INSERT INTO `menu_item` (`id`, `name`, `price`, `description`, `rest_id`, `temp_id`, `menusection_id`, `menu_id`) VALUES (13, 'Chicken add on', 3.00, 'Chicken add on for salad', 3, NULL, 6, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `customer` (`email`, `password`, `access_id`, `phone`, `birth_day`) VALUES ('maya.mohan@ahtllc.com', 'rows', 2, '(727)271-9295', '1992-10-21');
INSERT INTO `customer` (`email`, `password`, `access_id`, `phone`, `birth_day`) VALUES ('elijah.molnar@gmail.com', 'columns', 2, '(316)350-5067', '1971-01-05');
INSERT INTO `customer` (`email`, `password`, `access_id`, `phone`, `birth_day`) VALUES ('jeffrey.leupp@gmail.com', 'rowcol', 2, '(805)478-3754', '1983-03-29');
INSERT INTO `customer` (`email`, `password`, `access_id`, `phone`, `birth_day`) VALUES ('elenapignatelli@gmail.com', 'pipe', 2, '(860)307-6514', '1988-02-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `gitgrubdb`;
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('HOME', '2987 Wentworth Way', 'Tarpon Springs', 'FL', '34688', 'maya.mohan@ahtllc.com');
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('DETROIT', '22511 Santa Maria St', 'Santa Maria', 'MI', '48219', 'elijah.molnar@gmail.com');
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('HOME', '2627 W 34th Ave', 'Denver', 'CO', '80211', 'jeffrey.leupp@gmail.com');
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('HOME', '1110 NE Lakewood Dr', 'Newport', 'OR', '97365', 'elijah.molnar@gmail.com');
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('DENVER', '7587 E Technology Dr', 'Denver', 'CO', '80237', 'maya.mohan@ahtllc.com');
INSERT INTO `address` (`address_tag`, `street_address`, `city`, `state`, `zipcode`, `customer_email`) VALUES ('HOME', '2627 W 34th Ave', 'Denver', 'CO', '80211', 'elenapignatelli@gmail.com');

COMMIT;

