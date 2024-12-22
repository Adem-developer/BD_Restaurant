-- Transaction 1
BEGIN;

INSERT INTO Commandes (ID_Client, ID_Commande, Date_Commande, Statut, Total_Commande, ID_Employe)
VALUES (9, 23, '20241216', 'EN_COURS', 5, 3)
RETURNING ID_Commande;

INSERT INTO Details_Commande(ID_Commande, ID_Plat, Quantite)
VALUES (23, 4, 3); 

COMMIT;


-- Transaction 2
BEGIN;

    DELETE FROM Details_Commande WHERE ID_Commande = '0';

    DELETE FROM Paiements WHERE ID_Commande = '0';

    DELETE FROM Commandes WHERE ID_Commande = '0'

COMMIT;
