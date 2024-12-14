-- ############################################
-- ## Trigger 1 : Mise a jour disponibilite ##
-- ############################################
--
-- **Description** :
-- Met a jour la disponibilite des menus dans la table `Menus` en fonction
-- de la quantite disponible dans l'inventaire. Si la quantite disponible
-- devient inferieure ou egale au seuil critique, la disponibilite est mise a FALSE.
--
-- **Tables concernees** : Inventaire, Menus

CREATE OR REPLACE FUNCTION check_menu_disponibilite()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Quantite_Disponible <= NEW.Seuil_Critique THEN
        UPDATE Menus
        SET Disponibilite = FALSE
        WHERE ID_Plat = NEW.ID_Produit;
    ELSE
        UPDATE Menus
        SET Disponibilite = TRUE
        WHERE ID_Plat = NEW.ID_Produit;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_menu_disponibilite
AFTER UPDATE ON Inventaire
FOR EACH ROW
EXECUTE FUNCTION check_menu_disponibilite();


-- #############################################
-- ## Trigger 2 : Historisation des actions ##
-- #############################################
--
-- **Description** :
-- Enregistre chaque insertion ou modification d'une commande dans la table
-- `Logs_Activites` avec les details de l'action.
--
-- **Tables concernees** : Commandes, Logs_Activites

CREATE OR REPLACE FUNCTION log_employee_action()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Logs_Activites (ID_Employe, ID_Commande, Action, Date_Action)
    VALUES (NEW.ID_Employe, NEW.ID_Commande, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_command_action
AFTER INSERT OR UPDATE ON Commandes
FOR EACH ROW
EXECUTE FUNCTION log_employee_action();


-- #############################################
-- ## Trigger 3 : Verification paiement valide ##
-- #############################################
--
-- **Description** :
-- Verifie qu'une commande existe avant d'ajouter un paiement.
-- Si la commande n'existe pas, une exception est levee.
--
-- **Tables concernees** : Paiements, Commandes

CREATE OR REPLACE FUNCTION verify_commande_exists()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Commandes WHERE ID_Commande = NEW.ID_Commande) THEN
        RAISE EXCEPTION 'La commande associee n''existe pas. Paiement annule.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verify_commande_paiement
BEFORE INSERT ON Paiements
FOR EACH ROW
EXECUTE FUNCTION verify_commande_exists();




-- ###########################################
-- ## Trigger 4 : Mise a jour points client ##
-- ###########################################
--
-- **Description** :
-- Met a jour les points de fidelite des clients lorsqu'un paiement est effectue.
-- Les points sont calcules comme 1 point pour 10 unites du total de la commande.
--
-- **Tables concernees** : Paiements, Clients, Commandes

CREATE OR REPLACE FUNCTION update_points_fidelite()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Clients
    SET Points_Fidelite = Points_Fidelite + (SELECT Total_Commande / 10
                                             FROM Commandes
                                             WHERE ID_Commande = NEW.ID_Commande)
    WHERE ID_Client = (SELECT ID_Client 
                       FROM Commandes 
                       WHERE ID_Commande = NEW.ID_Commande);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_points_fidelite
AFTER INSERT ON Paiements
FOR EACH ROW
EXECUTE FUNCTION update_points_fidelite();


-- #############################################
-- ## Trigger 5 : Verification des menus ##
-- #############################################
--
-- **Description** :
-- Lors de l'ajout d'un menu dans `Details_Commande`, verifie que le menu est disponible.
-- Si le menu n'est pas disponible, l'insertion est annulee.
--
-- **Tables concernees** : Details_Commande, Menus

CREATE OR REPLACE FUNCTION check_menu_disponibilite_details()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Menus
        WHERE ID_Plat = NEW.ID_Plat AND Disponibilite = TRUE
    ) THEN
        RAISE EXCEPTION 'Le menu n''est pas disponible.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_menu_disponibilite
BEFORE INSERT ON Details_Commande
FOR EACH ROW
EXECUTE FUNCTION check_menu_disponibilite_details();


-- #############################################
-- ## Trigger 6 : Verification quantite initiale ##
-- #############################################
--
-- **Description** :
-- Verifie qu'un produit ajoute dans l'inventaire ne dispose pas d'une quantite
-- initiale inferieure au seuil critique.
--
-- **Tables concernees** : Inventaire

CREATE OR REPLACE FUNCTION check_quantite_initiale()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Quantite_Disponible < NEW.Seuil_Critique THEN
        RAISE EXCEPTION 'La quantite initiale ne peut pas etre inferieure au seuil critique.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_quantite_inventaire
BEFORE INSERT ON Inventaire
FOR EACH ROW
EXECUTE FUNCTION check_quantite_initiale();


-- ##############################################
-- ## Trigger 7 : Historique des changements ##
-- ##############################################
--
-- **Description** :
-- Lorsqu'un employe change de poste, un log est ajoute dans la table `Logs_Activites`.
--
-- **Tables concernees** : Employes, Logs_Activites

CREATE OR REPLACE FUNCTION log_poste_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Logs_Activites (ID_Employe, Action, Date_Action, Operation)
    VALUES (OLD.ID_Employe, 'Modification', NOW(), 'Changement de poste de ' || OLD.Poste || ' a ' || NEW.Poste);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_poste_change
AFTER UPDATE OF Poste ON Employes
FOR EACH ROW
EXECUTE FUNCTION log_poste_change();