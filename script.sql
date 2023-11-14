--
-- Base de données : `SystemeGestionBreifs1`
CREATE DATABASE SystemeGestionBreifs1;

USE SystemeGestionBreifs1;
-- ---
-- Create les table de base donnes 

--
-- Create la table utilisateur de base donnes 

CREATE TABLE Utilisateur(
    `UserID` INT PRIMARY KEY AUTO_INCREMENT,
    `userName` VARCHAR(50),
    `email` VARCHAR(50)
);

--
-- Create la table Squad de base donnes 

CREATE TABLE Squad(
    `SquadID` INT PRIMARY KEY AUTO_INCREMENT,
    `SquadNAME` VARCHAR(50),
    `ProjectID` INT,
    `UserID` INT
);
--
-- Create la table Projet de base donnes 

CREATE TABLE Projet(
    `ProjectID` INT PRIMARY KEY AUTO_INCREMENT,
    `ProjectName` VARCHAR(100),
    `ProjectDescription` VARCHAR(100),
    `DateDebut` DATE,
    `DateFin` DATE
);
--
-- Create la table Ressource de base donnes  

CREATE TABLE Ressource(
    `ResourceID` INT PRIMARY KEY AUTO_INCREMENT,
    `ResourceName` VARCHAR(50),
    `CategoryID` INT,
    `SubcategoryID` INT,
    `SquadID` INT,
    `ProjectID` INT
);
--
-- Create la table Category de base donnes  

CREATE TABLE Category(
    `CategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `CategoryDescription` VARCHAR(100)
);
-- Create la table Subcategory de base donnes  

CREATE TABLE Subcategory(
    `SubcategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `SubcategoryDescription` VARCHAR(100)
);

