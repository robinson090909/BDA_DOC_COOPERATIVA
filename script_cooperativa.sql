-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema doc_cooperativa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doc_cooperativa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doc_cooperativa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `doc_cooperativa` ;

-- -----------------------------------------------------
-- Table `doc_cooperativa`.`socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`socio` (
  `id_socio` INT NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(10) NULL DEFAULT NULL,
  `nombre` VARCHAR(25) NULL DEFAULT NULL,
  `apellidos` VARCHAR(25) NULL DEFAULT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_socio`),
  UNIQUE INDEX `cedula` (`cedula` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`solicitud_ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`solicitud_ingreso` (
  `id_solicitud_ingreso` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NOT NULL,
  `fecha_ingreso` DATE NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_solicitud_ingreso`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  CONSTRAINT `solicitud_ingreso_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`creditos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`creditos` (
  `id_creditos` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NOT NULL,
  `solicitud_credito` VARCHAR(100) NULL DEFAULT NULL,
  `monto` DECIMAL(10,2) NULL DEFAULT NULL,
  `estado` VARCHAR(30) NULL DEFAULT NULL,
  `fecha_solicitud` DATE NULL DEFAULT NULL,
  `fecha_desembolso` DATE NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_creditos`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  CONSTRAINT `creditos_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`polizas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`polizas` (
  `id_polizas` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NOT NULL,
  `monto` DECIMAL(10,2) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  `fecha_solicitud` DATE NULL DEFAULT NULL,
  `fecha_vencimiento` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_polizas`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  CONSTRAINT `polizas_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`documentos` (
  `id_documentos` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NOT NULL,
  `id_solicitud_ingreso` INT NULL DEFAULT NULL,
  `id_creditos` INT NULL DEFAULT NULL,
  `id_polizas` INT NULL DEFAULT NULL,
  `tipo_de_documento` VARCHAR(50) NOT NULL,
  `estado_documento` VARCHAR(20) NULL DEFAULT 'Vigente',
  PRIMARY KEY (`id_documentos`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  INDEX `id_solicitud_ingreso` (`id_solicitud_ingreso` ASC) VISIBLE,
  INDEX `id_creditos` (`id_creditos` ASC) VISIBLE,
  INDEX `id_polizas` (`id_polizas` ASC) VISIBLE,
  CONSTRAINT `documentos_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`),
  CONSTRAINT `documentos_ibfk_2`
    FOREIGN KEY (`id_solicitud_ingreso`)
    REFERENCES `doc_cooperativa`.`solicitud_ingreso` (`id_solicitud_ingreso`),
  CONSTRAINT `documentos_ibfk_3`
    FOREIGN KEY (`id_creditos`)
    REFERENCES `doc_cooperativa`.`creditos` (`id_creditos`),
  CONSTRAINT `documentos_ibfk_4`
    FOREIGN KEY (`id_polizas`)
    REFERENCES `doc_cooperativa`.`polizas` (`id_polizas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`actualizacion_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`actualizacion_doc` (
  `id_actualizacion_doc` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NULL DEFAULT NULL,
  `id_documentos` INT NULL DEFAULT NULL,
  `fecha_actualizacion` DATE NULL DEFAULT NULL,
  `motivo` VARCHAR(100) NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_actualizacion_doc`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  INDEX `id_documentos` (`id_documentos` ASC) VISIBLE,
  CONSTRAINT `actualizacion_doc_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`),
  CONSTRAINT `actualizacion_doc_ibfk_2`
    FOREIGN KEY (`id_documentos`)
    REFERENCES `doc_cooperativa`.`documentos` (`id_socio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`devolucion_aho_aportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`devolucion_aho_aportes` (
  `id_devolucion_aho_aportes` INT NOT NULL AUTO_INCREMENT,
  `id_socio` INT NOT NULL,
  `monto_devolucion` DECIMAL(10,2) NULL DEFAULT NULL,
  `fecha_devolucion` DATE NULL DEFAULT NULL,
  `estado` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_devolucion_aho_aportes`),
  INDEX `id_socio` (`id_socio` ASC) VISIBLE,
  CONSTRAINT `devolucion_aho_aportes_ibfk_1`
    FOREIGN KEY (`id_socio`)
    REFERENCES `doc_cooperativa`.`socio` (`id_socio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doc_cooperativa`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doc_cooperativa`.`ubicacion` (
  `id_ubicacion` INT NOT NULL AUTO_INCREMENT,
  `id_documentos` INT NULL DEFAULT NULL,
  `numero_carpeta` VARCHAR(20) NULL DEFAULT NULL,
  `estanteria` VARCHAR(20) NULL DEFAULT NULL,
  `columna` VARCHAR(20) NULL DEFAULT NULL,
  `fila` VARCHAR(20) NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  `ruta_digital` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ubicacion`),
  INDEX `id_documentos` (`id_documentos` ASC) VISIBLE,
  CONSTRAINT `ubicacion_ibfk_1`
    FOREIGN KEY (`id_documentos`)
    REFERENCES `doc_cooperativa`.`documentos` (`id_documentos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
