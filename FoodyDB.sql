-- Créer la base de données
CREATE DATABASE FoodyDB ENCODING 'UTF8';
\c FoodyDB;

-- Création des types ENUM (Assurez-vous que cette ligne est exécutée avant la création des tables)
CREATE TYPE statut_commande AS ENUM ('EN_COURS', 'PAYE', 'ANNULE'); 
CREATE TYPE mode_paiement AS ENUM ('CB', 'ESPECES', 'CHEQUE'); 

-- Table : Clients
CREATE TABLE Clients (
    ID_Client SERIAL PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50),
    Contact VARCHAR(100) UNIQUE NOT NULL,
    Points_Fidelite INT DEFAULT 0
);

-- Table : Employes
CREATE TABLE Employes (
    ID_Employe SERIAL PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50),
    Poste VARCHAR(50),
    Horaire TIMESTAMP
);

-- Table : Inventaire
CREATE TABLE Inventaire (
    ID_Produit SERIAL PRIMARY KEY,
    Nom_Produit VARCHAR(100) NOT NULL,
    Quantite_Disponible INT DEFAULT 0,
    Seuil_Critique INT DEFAULT 5
);

-- Table : Menus
CREATE TABLE Menus (
    ID_Plat SERIAL PRIMARY KEY,
    Nom_Plat VARCHAR(100) NOT NULL,
    Description TEXT,
    Prix DECIMAL(10, 2) NOT NULL,
    Disponibilite BOOLEAN DEFAULT TRUE
);

-- Table : Commandes
CREATE TABLE Commandes (
    ID_Commande SERIAL PRIMARY KEY,
    ID_Client INT NOT NULL,
    ID_Employe INT,
    Date_Commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Statut statut_commande DEFAULT 'EN_COURS',
    Total_Commande DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (ID_Client) REFERENCES Clients(ID_Client),
    FOREIGN KEY (ID_Employe) REFERENCES Employes(ID_Employe)
);

-- Table : Details_Commande
CREATE TABLE Details_Commande (
    ID_Commande INT NOT NULL,
    ID_Plat INT NOT NULL,
    Quantite INT NOT NULL,
    PRIMARY KEY (ID_Commande, ID_Plat),
    FOREIGN KEY (ID_Commande) REFERENCES Commandes(ID_Commande) ON DELETE CASCADE,
    FOREIGN KEY (ID_Plat) REFERENCES Menus(ID_Plat) ON DELETE CASCADE
);

-- Table : Paiements
CREATE TABLE Paiements (
    ID_Paiement SERIAL PRIMARY KEY,
    ID_Commande INT NOT NULL,
    Date_Paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Mode_Paiement mode_paiement NOT NULL,
    FOREIGN KEY (ID_Commande) REFERENCES Commandes(ID_Commande)
);



-- Table Véhicule
CREATE TABLE Vehicule (
    ID_Vehicule SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour un ID auto-incrémenté
    Marque VARCHAR(50),
    Modele VARCHAR(50),
    Immatriculation VARCHAR(20),
    Capacite DECIMAL(10, 2),
    Disponibilite BOOLEAN DEFAULT TRUE
);

-- Table Livreur
CREATE TABLE Livreur (
    ID_Livreur SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour un ID auto-incrémenté
    ID_Employe INT,
    ID_Vehicule INT,
    Zone_Livraison TEXT,
    FOREIGN KEY (ID_Employe) REFERENCES Employes(ID_Employe),
    FOREIGN KEY (ID_Vehicule) REFERENCES Vehicule(ID_Vehicule)
);

-- Création de la table Logs_Activites
CREATE TABLE Logs_Activites (
    ID_Log SERIAL PRIMARY KEY,               -- Utilisation de SERIAL au lieu de AUTO_INCREMENT
    ID_Employe INT NOT NULL,                 -- Employé ayant généré le log
    ID_Commande INT DEFAULT NULL,            -- Commande concernée (optionnel)
    Action VARCHAR(255) NOT NULL,            -- Description de l'action
    Date_Action TIMESTAMP NOT NULL DEFAULT NOW(), -- Date et heure de l'action
    Details TEXT DEFAULT NULL,               -- Détails supplémentaires

    -- Clés étrangères
    CONSTRAINT FK_Logs_Employe FOREIGN KEY (ID_Employe) REFERENCES Employes(ID_Employe) ON DELETE CASCADE,
    CONSTRAINT FK_Logs_Commande FOREIGN KEY (ID_Commande) REFERENCES Commandes(ID_Commande) ON DELETE SET NULL
);


