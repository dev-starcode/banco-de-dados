-- MySQL Script generated by MySQL Workbench
-- Sat Apr  5 11:50:09 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema starcode
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema starcode
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `starcode` DEFAULT CHARACTER SET utf8 ;
USE `starcode` ;

-- -----------------------------------------------------
-- Table `starcode`.`brands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`brands` ;

CREATE TABLE IF NOT EXISTS `starcode`.`brands` (
  `brand_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`brand_id`),
  UNIQUE INDEX `brand_id_UNIQUE` (`brand_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`categories` ;

CREATE TABLE IF NOT EXISTS `starcode`.`categories` (
  `category_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_id_UNIQUE` (`category_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`suppliers` ;

CREATE TABLE IF NOT EXISTS `starcode`.`suppliers` (
  `supplier_id` VARCHAR(36) NOT NULL,
  `cod` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `document` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(12) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_id_UNIQUE` (`supplier_id` ASC) VISIBLE,
  UNIQUE INDEX `cod_UNIQUE` (`cod` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`products` ;

CREATE TABLE IF NOT EXISTS `starcode`.`products` (
  `product_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `image` TEXT NULL DEFAULT NULL,
  `brand_id` VARCHAR(36) NOT NULL,
  `category_id` VARCHAR(36) NOT NULL,
  `supplier_id` VARCHAR(36) NOT NULL,
  `quantity` INT NOT NULL,
  `quantity_min` INT NOT NULL,
  `price_cost` DECIMAL(10,2) NOT NULL,
  `selling_price` DECIMAL(10,2) NOT NULL,
  `validate_date` DATE NULL DEFAULT NULL,
  `status` ENUM("active", "inactive") NULL DEFAULT 'active',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  INDEX `fk_product_brand_idx` (`brand_id` ASC) VISIBLE,
  INDEX `fk_product_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_product_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_brand`
    FOREIGN KEY (`brand_id`)
    REFERENCES `starcode`.`brands` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `starcode`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `starcode`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`product_price_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`product_price_history` ;

CREATE TABLE IF NOT EXISTS `starcode`.`product_price_history` (
  `product_price_history_id` VARCHAR(36) NOT NULL,
  `product_id` VARCHAR(36) NOT NULL,
  `type` ENUM("cost", "selling") NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_price_history_id`),
  UNIQUE INDEX `product_price_history_id_UNIQUE` (`product_price_history_id` ASC) VISIBLE,
  INDEX `fk_product_price_history_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_price_history_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `starcode`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`stock_movements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`stock_movements` ;

CREATE TABLE IF NOT EXISTS `starcode`.`stock_movements` (
  `stock_movement_id` VARCHAR(36) NOT NULL,
  `product_id` VARCHAR(36) NOT NULL,
  `quantity_changed` INT NOT NULL,
  `movement_type` INT NOT NULL,
  `date_moviment` DATETIME NOT NULL,
  `reason` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`stock_movement_id`),
  UNIQUE INDEX `stock_movement_id_UNIQUE` (`stock_movement_id` ASC) VISIBLE,
  INDEX `fk_stock_movements_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_stock_movements_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `starcode`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`users` ;

CREATE TABLE IF NOT EXISTS `starcode`.`users` (
  `user_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `tenant` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `tantant_UNIQUE` (`tenant` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`clients` ;

CREATE TABLE IF NOT EXISTS `starcode`.`clients` (
  `client_id` VARCHAR(36) NOT NULL,
  `cod` VARCHAR(9) NOT NULL,
  `name` VARCHAR(255) NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `document` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`client_id`),
  UNIQUE INDEX `client_id_UNIQUE` (`client_id` ASC) VISIBLE,
  UNIQUE INDEX `cod_UNIQUE` (`cod` ASC) VISIBLE,
  UNIQUE INDEX `document_UNIQUE` (`document` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`cashier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`cashier` ;

CREATE TABLE IF NOT EXISTS `starcode`.`cashier` (
  `cashier_id` VARCHAR(36) NOT NULL,
  `opening_amount` DECIMAL(10,2) NOT NULL,
  `status` ENUM("opened", "closed") NOT NULL,
  `opened_at` DATETIME NULL,
  `closed_at` DATETIME NULL DEFAULT NULL,
  `user_opened_id` VARCHAR(36) NOT NULL,
  `user_closed_id` VARCHAR(36) NOT NULL,
  `total_sales` INT NULL DEFAULT NULL,
  `closing_amount` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`cashier_id`),
  UNIQUE INDEX `cashier_id_UNIQUE` (`cashier_id` ASC) VISIBLE,
  INDEX `fk_cashier_users1_idx` (`user_opened_id` ASC) VISIBLE,
  INDEX `fk_cashier_users2_idx` (`user_closed_id` ASC) VISIBLE,
  CONSTRAINT `fk_cashier_users1`
    FOREIGN KEY (`user_opened_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cashier_users2`
    FOREIGN KEY (`user_closed_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`sales` ;

CREATE TABLE IF NOT EXISTS `starcode`.`sales` (
  `sale_id` VARCHAR(36) NOT NULL,
  `user_id` VARCHAR(36) NOT NULL,
  `client_id` VARCHAR(36) NOT NULL,
  `cashier_id` VARCHAR(36) NOT NULL,
  `parcial_price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(10,2) NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `status` ENUM("paid", "pending", "canceled") NULL DEFAULT 'pending',
  `sale_date` DATE NOT NULL,
  PRIMARY KEY (`sale_id`),
  UNIQUE INDEX `saller_id_UNIQUE` (`sale_id` ASC) VISIBLE,
  INDEX `fk_sallers_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_sallers_clients1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_sales_cashier1_idx` (`cashier_id` ASC) VISIBLE,
  CONSTRAINT `fk_sallers_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sallers_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `starcode`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_cashier1`
    FOREIGN KEY (`cashier_id`)
    REFERENCES `starcode`.`cashier` (`cashier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`sale_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`sale_products` ;

CREATE TABLE IF NOT EXISTS `starcode`.`sale_products` (
  `sale_products_id` VARCHAR(36) NOT NULL,
  `sale_id` VARCHAR(36) NOT NULL,
  `product_id` VARCHAR(36) NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `price_coust` DECIMAL(10,2) NOT NULL,
  `price_sale` DECIMAL(10,2) NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`sale_products_id`),
  UNIQUE INDEX `idsale_products_UNIQUE` (`sale_products_id` ASC) VISIBLE,
  INDEX `fk_sale_products_sale1_idx` (`sale_id` ASC) VISIBLE,
  UNIQUE INDEX `sale_id_UNIQUE` (`sale_id` ASC) VISIBLE,
  INDEX `fk_sale_products_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_products_sale1`
    FOREIGN KEY (`sale_id`)
    REFERENCES `starcode`.`sales` (`sale_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_products_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `starcode`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`cashier_moviments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`cashier_moviments` ;

CREATE TABLE IF NOT EXISTS `starcode`.`cashier_moviments` (
  `cashier_moviment_id` VARCHAR(36) NOT NULL,
  `cashier_id` VARCHAR(36) NOT NULL,
  `user_id` VARCHAR(36) NOT NULL,
  `type` ENUM("in", "out") NOT NULL,
  `amount` DOUBLE(10,2) NOT NULL,
  `reason` VARCHAR(255) NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`cashier_moviment_id`),
  UNIQUE INDEX `cashier_moviment_id_UNIQUE` (`cashier_moviment_id` ASC) VISIBLE,
  INDEX `fk_cashier_moviments_cashier1_idx` (`cashier_id` ASC) VISIBLE,
  INDEX `fk_cashier_moviments_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_cashier_moviments_cashier1`
    FOREIGN KEY (`cashier_id`)
    REFERENCES `starcode`.`cashier` (`cashier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cashier_moviments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`shopping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`shopping` ;

CREATE TABLE IF NOT EXISTS `starcode`.`shopping` (
  `shopping_id` VARCHAR(36) NOT NULL,
  `supplier_id` VARCHAR(36) NOT NULL,
  `product_id` VARCHAR(36) NOT NULL,
  `price_cost` DECIMAL(10,2) NOT NULL,
  `quantity` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`shopping_id`),
  UNIQUE INDEX `shopping_id_UNIQUE` (`shopping_id` ASC) VISIBLE,
  INDEX `fk_shopping_suppliers1_idx` (`supplier_id` ASC) VISIBLE,
  INDEX `fk_shopping_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `starcode`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shopping_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `starcode`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`enterprises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`enterprises` ;

CREATE TABLE IF NOT EXISTS `starcode`.`enterprises` (
  `enterprise_id` VARCHAR(36) NOT NULL,
  `user_id` VARCHAR(36) NOT NULL,
  `logo` VARCHAR(255) NULL DEFAULT NULL,
  `document` VARCHAR(20) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`enterprise_id`),
  UNIQUE INDEX `enterprise_id_UNIQUE` (`enterprise_id` ASC) VISIBLE,
  INDEX `fk_enterprises_users1_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `document_UNIQUE` (`document` ASC) VISIBLE,
  CONSTRAINT `fk_enterprises_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`addresses` ;

CREATE TABLE IF NOT EXISTS `starcode`.`addresses` (
  `address_id` VARCHAR(36) NOT NULL,
  `entity_id` VARCHAR(36) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT 'DEFAULT \'Brasil\'',
  `postal_code` VARCHAR(15) NULL DEFAULT NULL,
  `complement` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `enterprise_address_id_UNIQUE` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`enterprise_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`enterprise_users` ;

CREATE TABLE IF NOT EXISTS `starcode`.`enterprise_users` (
  `identerprise_user_id` VARCHAR(36) NOT NULL,
  `user_id` VARCHAR(36) NOT NULL,
  `enterprise_id` VARCHAR(36) NOT NULL,
  `role` ENUM("owner", "manager", "employee") NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`identerprise_user_id`),
  UNIQUE INDEX `identerprise_user_id_UNIQUE` (`identerprise_user_id` ASC) VISIBLE,
  INDEX `fk_enterprise_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_enterprise_users_enterprises1_idx` (`enterprise_id` ASC) VISIBLE,
  CONSTRAINT `fk_enterprise_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enterprise_users_enterprises1`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `starcode`.`enterprises` (`enterprise_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`permissions` ;

CREATE TABLE IF NOT EXISTS `starcode`.`permissions` (
  `permission_id` VARCHAR(36) NOT NULL,
  `type` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`permission_id`),
  UNIQUE INDEX `idpermission_id_UNIQUE` (`permission_id` ASC) VISIBLE,
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`user_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`user_permissions` ;

CREATE TABLE IF NOT EXISTS `starcode`.`user_permissions` (
  `user_permission_id` VARCHAR(36) NOT NULL,
  `user_id` VARCHAR(36) NOT NULL,
  `permission_id` VARCHAR(36) NOT NULL,
  `granted_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_permission_id`),
  UNIQUE INDEX `user_permission_id_UNIQUE` (`user_permission_id` ASC) VISIBLE,
  INDEX `fk_user_permissions_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_permissions_permissions1_idx` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_permissions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `starcode`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_permissions_permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `starcode`.`permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`account_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`account_categories` ;

CREATE TABLE IF NOT EXISTS `starcode`.`account_categories` (
  `account_categories_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`account_categories_id`),
  UNIQUE INDEX `account_categories_id_UNIQUE` (`account_categories_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`payment_methods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`payment_methods` ;

CREATE TABLE IF NOT EXISTS `starcode`.`payment_methods` (
  `payment_methods_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`payment_methods_id`),
  UNIQUE INDEX `payment_methods_id_UNIQUE` (`payment_methods_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`accounts_payables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`accounts_payables` ;

CREATE TABLE IF NOT EXISTS `starcode`.`accounts_payables` (
  `accounts_payable_id` VARCHAR(36) NOT NULL,
  `description` TEXT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `due_date` DATETIME NOT NULL,
  `payment_date` DATETIME NULL DEFAULT NULL,
  `status` ENUM("pending", "paid") NULL DEFAULT 'pending',
  `account_categories_id` VARCHAR(36) NOT NULL,
  `payment_methods_id` VARCHAR(36) NULL,
  `supplier_id` VARCHAR(36) NULL,
  PRIMARY KEY (`accounts_payable_id`),
  INDEX `fk_accounts_payable_account_categories1_idx` (`account_categories_id` ASC) VISIBLE,
  INDEX `fk_accounts_payable_payment_methods1_idx` (`payment_methods_id` ASC) VISIBLE,
  INDEX `fk_accounts_payable_suppliers1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_accounts_payable_account_categories1`
    FOREIGN KEY (`account_categories_id`)
    REFERENCES `starcode`.`account_categories` (`account_categories_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_payable_payment_methods1`
    FOREIGN KEY (`payment_methods_id`)
    REFERENCES `starcode`.`payment_methods` (`payment_methods_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_payable_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `starcode`.`suppliers` (`supplier_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `starcode`.`accounts_receivables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `starcode`.`accounts_receivables` ;

CREATE TABLE IF NOT EXISTS `starcode`.`accounts_receivables` (
  `accounts_receivable` VARCHAR(36) NOT NULL,
  `description` TEXT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `due_date` DATETIME NOT NULL,
  `received_date` DATETIME NULL,
  `status` ENUM("pending", "received") NULL DEFAULT 'pending',
  `client_id` VARCHAR(36) NULL,
  `account_categories_id` VARCHAR(36) NULL,
  `payment_methods_id` VARCHAR(36) NULL,
  PRIMARY KEY (`accounts_receivable`),
  UNIQUE INDEX `accounts_receivable_UNIQUE` (`accounts_receivable` ASC) VISIBLE,
  INDEX `fk_accounts_receivables_clients1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_accounts_receivables_account_categories1_idx` (`account_categories_id` ASC) VISIBLE,
  INDEX `fk_accounts_receivables_payment_methods1_idx` (`payment_methods_id` ASC) VISIBLE,
  CONSTRAINT `fk_accounts_receivables_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `starcode`.`clients` (`client_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_receivables_account_categories1`
    FOREIGN KEY (`account_categories_id`)
    REFERENCES `starcode`.`account_categories` (`account_categories_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_receivables_payment_methods1`
    FOREIGN KEY (`payment_methods_id`)
    REFERENCES `starcode`.`payment_methods` (`payment_methods_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
