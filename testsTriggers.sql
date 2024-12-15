-- TESTS TRIGGER


-- trigger 1 : Lorsqu'on atteint le seuil critique de quantite, change la disponibilite de l'aliment TRUE/FALSE

UPDATE Inventaire
SET Quantite_Disponible = 2
WHERE ID_Produit = 1;

-- trigger 2 : insert dans les logs la commande en cours

INSERT INTO Commandes (ID_Client, Date_Commande, Statut, Total_Commande, ID_Employe)
VALUES (1, NOW(), 'EN_COURS', 150, 3);

-- trigger 3 : vérification avant paiement si la commande existe

INSERT INTO Paiements (Date_Paiement, Mode_Paiement, ID_Commande)
VALUES (NOW(), 'CB', 14);

-- trigger 4 : Lorsqu’un paiement est enregistré, les points de fidélité sont mis à jour proportionnellement au montant de la commande.

INSERT INTO Paiements (Date_Paiement, Mode_Paiement, ID_Commande)
VALUES (NOW(), 'CB', 3);

-- trigger 5 : Un menu doit être disponible (Disponibilite = TRUE) avant de pouvoir être ajouté dans Details_Commande, cf. Trigger 1

INSERT INTO Details_Commande (ID_Commande, ID_Plat, Quantite)
VALUES (2, 2, 3);

-- trigger 6 : On empêche l’ajout d’un produit avec une quantité initiale inférieure au seuil critique.

INSERT INTO Inventaire (Nom_Produit, Quantite_Disponible, Seuil_Critique)
VALUES ('Cachir', 5, 10);

-- trigger 7 : Lorsqu’un employé change de poste, une entrée est ajoutée à Logs_Activites.

UPDATE Employes
SET Poste = 'Manager'
WHERE ID_Employe = 4;

-- trigger 8 : Ce trigger s'assure qu'un véhicule ne peut être assigné à un livreur que s'il est disponible.

    -- Supposons que le véhicule 29 est indisponible (Disponibilite = FALSE)
UPDATE Vehicule 
SET Disponibilite = FALSE 
WHERE ID_Vehicule = 29;

    -- Tentative d'affecter le véhicule indisponible au livreur 2
INSERT INTO Livreur (ID_Employe, ID_Vehicule, Zone_Livraison)
VALUES (2, 30, 'Zone Nord');


-- trigger 9 : Mise à jour automatique de la disponibilité du véhicule

INSERT INTO Livreur (ID_Employe, ID_Vehicule, Zone_Livraison)
VALUES (2, 3, 'Zone Nord');


-- trigger 10 : Ce trigger enregistre automatiquement dans la table Logs_Activites lorsqu'un livreur reçoit un nouveau véhicule

UPDATE Livreur
SET ID_Vehicule = 27
WHERE ID_Livreur = 9; 