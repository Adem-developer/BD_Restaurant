-- ################################################
-- Fonction 1: Calculer le montant total d'une commande
-- ################################################
CREATE OR REPLACE FUNCTION calculer_montant_commande(p_ID_Commande INT) 
RETURNS DECIMAL(10,2) AS $$
DECLARE
    total DECIMAL(10,2) := 0;
BEGIN
    SELECT SUM(m.Prix * d.Quantite)
    INTO total
    FROM Details_Commande d
    JOIN Menus m ON d.ID_Plat = m.ID_Plat
    WHERE d.ID_Commande = p_ID_Commande;  -- Utilisation de p_ID_Commande pour le paramètre

    RETURN total;
END;
$$ LANGUAGE plpgsql;


SELECT calculer_montant_commande(1);  -- Exemple de test pour la commande avec ID 1

-- Commande 1 (2x Pizza Margherita + 1x Salade César)
-- Commande 2 (1x Poulet Rôti)
select * from details_commande; 



-- ################################################
-- Fonction 2: Rapport hebdomadaire des ventes
-- ################################################
CREATE OR REPLACE FUNCTION rapport_hebdomadaire_ventes()
RETURNS TABLE(date_vente DATE, total_ventes DECIMAL(10,2)) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        DATE(Date_Commande) AS date_vente,
        SUM(Total_Commande) AS total_ventes
    FROM Commandes
    WHERE Date_Commande >= CURRENT_DATE - INTERVAL '7 days'
    GROUP BY DATE(Date_Commande)
    ORDER BY date_vente;
END;
$$ LANGUAGE plpgsql;

-- Exemple de test pour voir les ventes des 7 derniers jours
SELECT * FROM rapport_hebdomadaire_ventes();  





-- ################################################
-- Fonction 3: Top des plats les plus commandés
-- ################################################
CREATE OR REPLACE FUNCTION top_plats_populaires()
RETURNS TABLE(Nom_Plat VARCHAR, total_commande INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.Nom_Plat,
        SUM(d.Quantite)::INTEGER AS total_commande  -- Convertir le type en INTEGER
    FROM Details_Commande d
    JOIN Menus m ON d.ID_Plat = m.ID_Plat
    GROUP BY m.Nom_Plat
    ORDER BY total_commande DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;


-- Exemple de test pour voir les 5 plats les plus populaires
SELECT * FROM top_plats_populaires();  





-- ################################################
-- Fonction 4: Analyse des performances des employés
-- ################################################
CREATE OR REPLACE FUNCTION analyse_performance_employes()
RETURNS TABLE(nom_employe VARCHAR, total_commandes INTEGER, total_ventes DECIMAL(10, 2)) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        (e.Nom || ' ' || e.Prenom)::VARCHAR AS nom_employe,  -- Convertir en VARCHAR explicitement
        COUNT(c.ID_Commande)::INTEGER AS total_commandes,  -- Conversion explicite en INTEGER
        SUM(c.Total_Commande)::DECIMAL(10, 2) AS total_ventes  -- Conversion explicite en DECIMAL
    FROM Commandes c
    JOIN Employes e ON c.ID_Employe = e.ID_Employe
    GROUP BY e.ID_Employe
    ORDER BY total_ventes DESC;
END;
$$ LANGUAGE plpgsql;


-- Test de analyse_performance_employes
SELECT * FROM analyse_performance_employes();