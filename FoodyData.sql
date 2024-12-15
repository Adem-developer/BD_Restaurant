-- =======================================
-- Insertion des données dans la base
-- =======================================

-- Table : Clients
INSERT INTO Clients (Nom, Prenom, Contact, Points_Fidelite)
VALUES 
    ('Dupont', 'Jean', 'jean.dupont@gmail.com', 10),
    ('Martin', 'Sophie', 'sophie.martin@gmail.com', 15),
    ('Durand', 'Paul', 'paul.durand@gmail.com', 8),
    ('Bernard', 'Claire', 'claire.bernard@gmail.com', 5),
    ('Moreau', 'Alice', 'alice.moreau@gmail.com', 20),
    ('Lemoine', 'Julie', 'julie.lemoine@gmail.com', 25),
    ('Petit', 'Olivier', 'olivier.petit@gmail.com', 30),
    ('Benoit', 'Caroline', 'caroline.benoit@gmail.com', 12),
    ('Simon', 'Luc', 'luc.simon@gmail.com', 5),
    ('Tremblay', 'Anne', 'anne.tremblay@gmail.com', 18);

-- Table : Employes
INSERT INTO Employes (Nom, Prenom, Poste, Horaire)
VALUES 
    ('Lemoine', 'Pierre', 'Serveur', '2024-11-18 09:00:00'),
    ('Rousseau', 'Marie', 'Caissier', '2024-11-18 08:30:00'),
    ('Noir', 'Julien', 'Manager', '2024-11-18 08:00:00'),
    ('Morel', 'Emma', 'Serveur', '2024-11-18 12:00:00'),
    ('Girard', 'Thomas', 'Caissier', '2024-11-18 10:00:00'),
    ('Lopez', 'Laura', 'Chef de Cuisine', '2024-11-18 08:00:00'),
    ('Garcia', 'Antoine', 'Serveur', '2024-11-18 12:30:00');

-- Table : Inventaire
INSERT INTO Inventaire (Nom_Produit, Quantite_Disponible, Seuil_Critique)
VALUES 
    ('Tomates', 100, 10),
    ('Fromage', 50, 5),
    ('Poulet', 30, 5),
    ('Pâtes', 70, 15),
    ('Pain', 80, 10),
    ('Champignons', 50, 10),
    ('Crème Fraîche', 40, 10),
    ('Viande de Bœuf', 20, 5),
    ('Lait', 30, 8),
    ('Oignons', 60, 12);

-- Table : Menus
INSERT INTO Menus (Nom_Plat, Description, Prix, Disponibilite)
VALUES 
    ('Pizza Margherita', 'Pizza classique avec tomates et fromage', 10.50, TRUE),
    ('Pâtes Carbonara', 'Pâtes avec sauce carbonara', 12.00, TRUE),
    ('Poulet Rôti', 'Poulet rôti avec accompagnement', 15.00, TRUE),
    ('Salade César', 'Salade avec poulet et sauce césar', 9.00, TRUE),
    ('Soupe de légumes', 'Soupe maison avec légumes frais', 7.50, TRUE),
    ('Burger Maison', 'Burger avec viande de bœuf et légumes frais', 13.00, TRUE),
    ('Lasagnes', 'Lasagnes à la bolognaise maison', 14.50, TRUE),
    ('Tiramisu', 'Dessert italien classique', 6.50, TRUE),
    ('Sandwich Club', 'Sandwich avec poulet, tomate et salade', 8.50, TRUE),
    ('Quiche Lorraine', 'Quiche avec lardons et fromage', 9.00, TRUE);

-- Table : Commandes
INSERT INTO Commandes (ID_Client, ID_Employe, Date_Commande, Statut, Total_Commande)
VALUES 
    (1, 1, '2024-11-18 12:30:00', 'EN_COURS', 22.50),
    (2, 2, '2024-11-18 13:00:00', 'PAYE', 18.00),
    (3, 1, '2024-11-18 13:15:00', 'PAYE', 30.00),
    (4, 2, '2024-11-18 14:00:00', 'ANNULE', 0.00),
    (5, 4, '2024-11-18 12:15:00', 'PAYE', 21.50),
    (3, 1, '2024-11-18 13:30:00', 'EN_COURS', 35.00),
    (2, 2, '2024-11-18 14:00:00', 'ANNULE', 0.00),
    (6, 3, '2024-11-18 14:30:00', 'PAYE', 19.00),
    (7, 2, '2024-11-18 15:00:00', 'PAYE', 11.50);

-- Table : Détails_Commande
INSERT INTO Details_Commande (ID_Commande, ID_Plat, Quantite)
VALUES 
    (1, 1, 2), -- 2x Pizza Margherita
    (1, 4, 1), -- 1x Salade César
    (2, 3, 1), -- 1x Poulet Rôti
    (3, 2, 2), -- 2x Pâtes Carbonara
    (3, 5, 1), -- 1x Soupe de légumes
    (4, 3, 1), -- 1x Lasagnes
    (4, 5, 2), -- 2x Quiche Lorraine
    (5, 6, 1), -- 1x Tiramisu
    (5, 7, 1), -- 1x Sandwich Club
    (6, 2, 1), -- 1x Pâtes Carbonara
    (7, 1, 1), -- 1x Pizza Margherita
    (7, 3, 2); -- 2x Lasagnes

-- Table : Paiements
INSERT INTO Paiements (ID_Commande, Date_Paiement, Mode_Paiement)
VALUES 
    (2, '2024-11-18 13:10:00', 'CB'),
    (3, '2024-11-18 13:30:00', 'ESPECES'),
    (4, '2024-11-18 14:40:00', 'CB'),
    (5, '2024-11-18 14:45:00', 'ESPECES'),
    (6, '2024-11-18 15:15:00', 'CHEQUE');


-- AJOUTS DES TROIS DATAS CI DESSOUS

-- Table : Vehicule
INSERT INTO Vehicule (Marque, Modele, Immatriculation, Capacite, Disponibilite)
VALUES
    ('Peugeot', 'Partner', 'AB-123-CD', 500, TRUE),
    ('Renault', 'Kangoo', 'EF-456-GH', 600, TRUE),
    ('Citroën', 'Berlingo', 'IJ-789-KL', 400, TRUE),
    ('Ford', 'Transit', 'MN-012-OP', 800, TRUE),
    ('Mercedes', 'Sprinter', 'QR-345-ST', 1000, TRUE);


-- Table : Livreur
INSERT INTO Livreur (ID_Employe, ID_Vehicule, Zone_Livraison)
VALUES
    (1, 1, 'Centre-ville'),
    (3, 2, 'Banlieue nord'),
    (4, 3, 'Quartiers est'),
    (5, 4, 'Banlieue sud'),
    (7, 5, 'Périphérie ouest');


-- Insertion des données dans Logs_Activites
INSERT INTO Logs_Activites (ID_Employe, ID_Commande, actiondescr, Details)
VALUES
    (1, 1, 'Création de commande', 'Commande #1 créée par Jean Dupont'),
    (3, NULL, 'Modification de menu', 'Prix du plat "Pizza Margherita" mis à jour'),
    (2, 5, 'Annulation de commande', 'Commande #5 annulée par le client'),
    (4, 7, 'Paiement enregistré', 'Paiement CB enregistré pour commande #7'),
    (6, NULL, 'Mise à jour de stock', 'Quantité de "Tomates" ajustée dans l’inventaire'),
    (7, 2, 'Livraison terminée', 'Commande #2 livrée avec succès.');
