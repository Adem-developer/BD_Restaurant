-- Transaction 1
BEGIN;

    INSERT INTO Commandes (ID_Client, Date_Commande, Statut, Total_Commande, ID_Client, ID_Employes)
    VALUES (0, '20241216', 0, 63, 0, 0)
    RETURNING ID_Commande AS id;

    INSERT INTO Details_Commande(ID_Commande, ID_Plat, Quantite)
    VALUES (id, 0, 3);

COMMIT;


-- Transaction 2
BEGIN;

    DELETE FROM Details_Commande WHERE ID_Commande = '0';

    DELETE FROM Paiements WHERE ID_Commande = '0';

    DELETE FROM Commandes WHERE ID_Commande = '0'

COMMIT;