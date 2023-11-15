--
-- Base de données : `SystemeGestionBreifs1`
CREATE DATABASE IF NOT EXISTS youcode_SystemeGestionBreifs1;

USE youcode_SystemeGestionBreifs1;
--
-- Create les table de base donnes 

--
-- Create la table utilisateur de base donnes 

CREATE TABLE IF NOT EXISTS  Utilisateur(
    `UserID` INT PRIMARY KEY AUTO_INCREMENT,
    `userName` VARCHAR(50),
    `email` VARCHAR(50)
);
--
-- Create la table Projet de base donnes 

CREATE TABLE IF NOT EXISTS Projet(
    `ProjectID` INT PRIMARY KEY AUTO_INCREMENT,
    `ProjectName` VARCHAR(100),
    `ProjectDescription` VARCHAR(100),
    `DateDebut` DATE,
    `DateFin` DATE
);
--
-- Create la table Squad de base donnes 

CREATE TABLE IF NOT EXISTS Squad(
    `SquadID` INT PRIMARY KEY AUTO_INCREMENT,
    `SquadName` VARCHAR(50),
    `ProjectID` INT,
    `UserID` INT,
    FOREIGN KEY (ProjectID) REFERENCES Projet(ProjectID),
    FOREIGN KEY (UserID) REFERENCES Utilisateur(UserID)
);
--
-- Create la table Category de base donnes  

CREATE TABLE IF NOT EXISTS Category(
    `CategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `CategoryDescription` VARCHAR(100)
);
--
-- Create la table Subcategory de base donnes  

CREATE TABLE IF NOT EXISTS Subcategory(
    `SubcategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `SubcategoryDescription` VARCHAR(100)
);
--
-- Create la table Ressource de base donnes  

CREATE TABLE IF NOT EXISTS Ressource(
    `ResourceID` INT PRIMARY KEY AUTO_INCREMENT,
    `ResourceName` VARCHAR(50),
    `CategoryID` INT,
    `SubcategoryID` INT,
    `SquadID` INT,
    `ProjectID` INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(`CategoryID`),
    FOREIGN KEY (SubcategoryID) REFERENCES Subcategory(`SubcategoryID`),
    FOREIGN KEY (SquadID) REFERENCES SquadID(`SquadID`),
    FOREIGN KEY (ProjectID) REFERENCES ProjectID(`ProjectID`)
);


/* En tant qu'administrateur système, je veux créer de nouveaux 
utilisateurs dans la base de données pour maintenir une liste
actualisée des membres de l'équipe.*/

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertUtilisateur(IN p_userName VARCHAR(255), IN p_email VARCHAR(255))
BEGIN
    INSERT INTO Utilisateur (userName, email)
    VALUES (p_userName, p_email);
END //
DELIMITER ;
CALL InsertUtilisateur('User Name','username@gmail.com');

/* En tant que leader de squad, je souhaite créer un nouveau squad,
spécifiant le nom et ajoutant des membres à ce squad, pour former 
rapidement des équipes dédiées à des projets spécifiques.*/

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS InsertSquad(IN p_SquadName VARCHAR(50), IN p_ProjectID INT , IN p_UserID INT)
BEGIN
    INSERT INTO Squad (SquadName, ProjectID, UserID)
    VALUES (p_SquadNAME, p_ProjectID, p_UserID);
END //
DELIMITER ;

CALL InsertSquad('Squad Name',1,1);
