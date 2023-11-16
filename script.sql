--
-- Base de données : `SystemeGestionBreifs1`
DROP DATABASE IF EXISTS youcode_SystemeGestionBreifs1;
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
)ENGINE=InnoDB;
--
-- Create la table Projet de base donnes 

CREATE TABLE IF NOT EXISTS Projet(
    `ProjectID` INT PRIMARY KEY AUTO_INCREMENT,
    `ProjectName` VARCHAR(100),
    `ProjectDescription` VARCHAR(100),
    `DateDebut` DATE,
    `DateFin` DATE
)ENGINE=InnoDB;
--
-- Create la table Squad de base donnes 

CREATE TABLE IF NOT EXISTS Squad(
    `SquadID` INT PRIMARY KEY AUTO_INCREMENT,
    `SquadName` VARCHAR(50),
    `ProjectID` INT,
    `UserID` INT,
    FOREIGN KEY (ProjectID) REFERENCES Projet(ProjectID),
    FOREIGN KEY (UserID) REFERENCES Utilisateur(UserID)
)ENGINE=InnoDB;
--
-- Create la table Category de base donnes  

CREATE TABLE IF NOT EXISTS Category(
    `CategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `CategoryDescription` VARCHAR(100)
)ENGINE=InnoDB;
--
-- Create la table Subcategory de base donnes  

CREATE TABLE IF NOT EXISTS Subcategory(
    `SubcategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `SubcategoryDescription` VARCHAR(100)
)ENGINE=InnoDB;
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
    FOREIGN KEY (SquadID) REFERENCES Squad(`SquadID`),
    FOREIGN KEY (ProjectID) REFERENCES Projet(`ProjectID`)
)ENGINE=InnoDB;


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

/*En tant que chef de projet, je veux créer un nouveau projet en 
fournissant des détails tels que le nom, la description et les dates,
pour définir clairement les paramètres de chaque projet. */

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS InsertProjet(IN p_ProjectName VARCHAR(50), IN p_ProjectDescription VARCHAR(50) , IN p_DateDebut VARCHAR(11), IN p_DateFin VARCHAR(11))
BEGIN
    INSERT INTO Projet (ProjectName, ProjectDescription, DateDebut, DateFin)
    VALUES (p_ProjectName, p_ProjectDescription, p_DateDebut, p_DateFin);
END //
DELIMITER ;

CALL InsertProjet('Projet Name','projet desc','2024-10-12','2024-12-12');

/*En tant que membre de squad, je veux voir la liste des projets pour
lesquels mon squad est responsable pour comprendre les projets actuels 
et suivre lesresponsabilités.*/

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS SelectProjet()
BEGIN
    SELECT * FROM Squad NATURAL JOIN Projet;
    
END //
DELIMITER ;

CALL SelectProjet();

/*En tant que responsable des ressources, je veux ajouter une 
nouvelle ressource en spécifiant son nom, sa catégorie, sa 
sous-catégorie et son association éventuelle à un squad ou à un projet,
pour gérer efficacement les ressources disponibles.*/

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS InsertRessource(IN p_ResourceName VARCHAR(50),IN p_CategoryID INT, IN p_SubcategoryID INT, IN p_SquadID INT, IN p_ProjectID INT)
BEGIN
    INSERT INTO Ressource (ResourceName, CategoryID, SubcategoryID, SquadID, ProjectID)
    VALUES (p_ResourceName, p_CategoryID, p_SubcategoryID, p_SquadID, p_ProjectID);
END //
DELIMITER ;

CALL InsertRessource('Resource Name', 1,1,1,1);

/* En tant que développeur Fullstack, je veux pouvoir mettre à jour les 
détails d'un utilisateur, d'un squad, d'un projet ou d'une ressource 
existante pour ajuster les informations en fonction des évolutions. */
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS UpdateRessource(
    IN p_ResourceID INT,
    IN p_ResourceName VARCHAR(50),
    IN p_CategoryID INT,
    IN p_SubcategoryID INT,
    IN p_SquadID INT,
    IN p_ProjectID INT
)
BEGIN
    UPDATE Ressource
    SET
        ResourceName = p_ResourceName,
        CategoryID = p_CategoryID,
        SubcategoryID = p_SubcategoryID,
        SquadID = p_SquadID,
        ProjectID = p_ProjectID
    WHERE ResourceID = p_ResourceID;
END //

DELIMITER ;


-- CALL UpdateRessource(1,'Resource Name Neauveau', 1,1,1,1);