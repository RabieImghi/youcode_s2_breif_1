--
-- Base de données : `SystemeGestionBreifs1`
DROP DATABASE IF EXISTS youcode_SystemeGestionBreifs1;
CREATE DATABASE IF NOT EXISTS youcode_SystemeGestionBreifs1;

USE youcode_SystemeGestionBreifs1;
--
-- Create les table de base donnes 

-- Create la table utilisateur de base donnes 
CREATE TABLE IF NOT EXISTS  Utilisateur(
    `UserID` INT PRIMARY KEY AUTO_INCREMENT,
    `userName` VARCHAR(50),
    `email` VARCHAR(50),
    `role` INT
)ENGINE=InnoDB;

-- Create la table Projet de base donnes 
CREATE TABLE IF NOT EXISTS Projet(
    `ProjectID` INT PRIMARY KEY AUTO_INCREMENT,
    `ProjectName` VARCHAR(100),
    `ProjectDescription` VARCHAR(100),
    `DateDebut` DATE,
    `DateFin` DATE
)ENGINE=InnoDB;

-- Create la table Squad de base donnes 
CREATE TABLE IF NOT EXISTS Squad(
    `SquadID` INT PRIMARY KEY AUTO_INCREMENT,
    `SquadName` VARCHAR(50),
    `ProjectID` INT,
    FOREIGN KEY (ProjectID) REFERENCES Projet(ProjectID)
)ENGINE=InnoDB;

-- Create la table Squad de base donnes 
CREATE TABLE IF NOT EXISTS SquadMembre(
    `SquadMemberID` INT PRIMARY KEY AUTO_INCREMENT,
    `SquadID` INT,
    `UserID` INT,
    FOREIGN KEY (SquadID) REFERENCES Squad(SquadID),
    FOREIGN KEY (UserID) REFERENCES Utilisateur(UserID)
)ENGINE=InnoDB;

-- Create la table Category de base donnes  
CREATE TABLE IF NOT EXISTS Category(
    `CategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `CategoryDescription` VARCHAR(100)
)ENGINE=InnoDB;

-- Create la table Subcategory de base donnes  
CREATE TABLE IF NOT EXISTS Subcategory(
    `SubcategoryID` INT PRIMARY KEY AUTO_INCREMENT,
    `SubcategoryDescription` VARCHAR(100)
)ENGINE=InnoDB;

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

/* -------------------------------------------------------------USER STORY 1 INSERT NEW USER------------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertUtilisateur(IN p_userName VARCHAR(255), IN p_email VARCHAR(255), IN p_role INT)
BEGIN
    INSERT INTO Utilisateur (userName, email, role)
    VALUES (p_userName, p_email, p_role);
END //
DELIMITER ;
CALL InsertUtilisateur('User Name','username@gmail.com',1);

/* -------------------------------------------------------------USER STORY 3 INSERT NEW PROJECT----------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertProjet(IN p_ProjectName VARCHAR(50), IN p_ProjectDescription VARCHAR(50) , IN p_DateDebut VARCHAR(11), IN p_DateFin VARCHAR(11))
BEGIN
    INSERT INTO Projet (ProjectName, ProjectDescription, DateDebut, DateFin)
    VALUES (p_ProjectName, p_ProjectDescription, p_DateDebut, p_DateFin);
END //
DELIMITER ;
CALL InsertProjet('Projet Name','projet desc','2024-10-12','2024-12-12');

/* -------------------------------------------------------------USER STORY 2 INSERT NEW SQUAD------------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertSquad(IN p_SquadName VARCHAR(50), IN p_ProjectID INT)
BEGIN
    INSERT INTO Squad (SquadName, ProjectID)
    VALUES (p_SquadNAME, p_ProjectID );
END //
DELIMITER ;
CALL InsertSquad('Squad Name',1);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertSquadMembre(IN p_SquadID INT, IN p_UserID INT )
BEGIN
    INSERT INTO SquadMembre (SquadID, UserID)
    VALUES (p_SquadID, p_UserID );
END //
DELIMITER ;
CALL InsertSquadMembre(1,1);

/* -------------------------------------------------------------USER STORY 4 SELECT PROJECT FOR MY SQUAD------------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SelectProjet()
BEGIN
    SELECT * FROM Utilisateur NATURAL JOIN SquadMembre NATURAL JOIN Squad NATURAL JOIN Projet;
END //
DELIMITER ;
CALL SelectProjet();

/* -------------------------------------------------------------USER STORY 7 INSERT NEW CETEGORY / SUBCATEGORY-------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertCategory(IN p_CategoryDescription VARCHAR(50))
BEGIN
    INSERT INTO Category
    SET CategoryDescription = p_CategoryDescription;
END //
DELIMITER ;
CALL InsertCategory("cat 1");

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertSubcategory(IN p_SubcategoryDescription VARCHAR(50))
BEGIN
    INSERT INTO Subcategory
    SET SubcategoryDescription = p_SubcategoryDescription;
END //
DELIMITER ;
CALL InsertSubcategory("sub cat 1");

/* -------------------------------------------------------------USER STORY 5 INSERT NEW RESSOURCE------------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS InsertRessource(IN p_ResourceName VARCHAR(50),IN p_CategoryID INT, IN p_SubcategoryID INT, IN p_SquadID INT, IN p_ProjectID INT)
BEGIN
    INSERT INTO Ressource (ResourceName, CategoryID, SubcategoryID, SquadID, ProjectID)
    VALUES (p_ResourceName, p_CategoryID, p_SubcategoryID, p_SquadID, p_ProjectID);
END //
DELIMITER ;
CALL InsertRessource('Resource Name', 1,1,1,1);

/* -------------------------------------------------------------USER STORY 6 UPDATE RESSOURCE INFO------------------------------------- */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS UpdateRessource(IN p_ResourceID INT,IN p_ResourceName VARCHAR(50),IN p_CategoryID INT,IN p_SubcategoryID INT,IN p_SquadID INT,IN p_ProjectID INT)
BEGIN
    UPDATE Ressource
    SET ResourceName = p_ResourceName, CategoryID = p_CategoryID, SubcategoryID = p_SubcategoryID, SquadID = p_SquadID, ProjectID = p_ProjectID
    WHERE ResourceID = p_ResourceID;
END //
DELIMITER ;
CALL UpdateRessource(1,'Ressource NV',1,1,1,1); 

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS UpdateUtilisateur(IN p_UserID INT,IN p_userName VARCHAR(50),p_email VARCHAR(50),IN p_role INT)
BEGIN
    UPDATE Utilisateur
    SET userName = p_userName, email = p_email, role = p_role
    WHERE UserID = p_UserID;
END //
DELIMITER ;
CALL UpdateUtilisateur(1,'User Name Neauveau','use@gmail.com',1);

