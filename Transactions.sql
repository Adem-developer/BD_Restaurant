-- Transaction 1

DO $$
DECLARE
    return_value INTEGER;
BEGIN

    INSERT INTO Commandes (ID_Client, ID_Employe, Date_Commande, Statut)
    VALUES (4, 2, '20241216', 'EN_COURS') 
    RETURNING ID_Commande INTO return_value;

    INSERT INTO Details_Commande(ID_Commande, ID_Plat, Quantite)
    VALUES (return_value, 5, 3);

END $$;

-- Transaction 2
BEGIN;

    DELETE FROM Details_Commande WHERE ID_Commande = '0';

    DELETE FROM Paiements WHERE ID_Commande = '0';

    DELETE FROM Commandes WHERE ID_Commande = '0'

COMMIT;
