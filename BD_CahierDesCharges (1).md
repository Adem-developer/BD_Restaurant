## **Cahier des Charges**
### **1. Le Projet Foody**
#### **1.1 Contexte**
- Le projet consiste à développer une base de données pour la gestion d’un restaurant.
- L’objectif est de faciliter la gestion des réservations, commandes, inventaire, employés, et paiements.
- La base de données devra être robuste, assurer l'intégrité des données et permettre des automatisations via des **transactions**, **triggers** et **fonctions**.

#### **1.2 Objectifs**
- Automatiser la gestion quotidienne des activités du restaurant.
- Offrir une interface de requêtage performante pour des analyses et rapports.
- Garantir la sécurité et l’intégrité des données.

#### **1.3 Périmètre**
- Gestion des **clients** (informations personnelles, historique des visites, fidélité).
- Gestion des **menus** (plats, catégories, prix, disponibilité).
- Gestion des **commandes** (prises en salle, livraison).
- Gestion de l’**inventaire** (stocks de cuisine).
- Gestion du **personnel** (employés, postes, horaires).
- Gestion des **paiements** (suivi des transactions financières).

---

### **2. Besoins Fonctionnels**
#### **2.1 Entités à Modéliser**
- **Clients** : ID client, nom, prénom, contact, fidélité.
- **Menus** : ID plat, nom plat, description, prix, disponibilité.
- **Commandes** : ID commande, ID client, plats commandés, quantité, prix total, statut (en cours, terminée).
- **Employés** : ID employé, nom, poste, horaires.
- **Inventaire** : ID produit, nom produit, quantité disponible, seuil critique.
- **Paiements** : ID paiement, ID commande, date paiement, mode paiement.

#### **2.2 Transactions**
- Création de commandes : insertion des détails de commande, mise à jour du stock.
- Gestion des paiements : mise à jour du statut des commandes après paiement.
- Gestion des stocks : déduire les quantités lors de la validation d’une commande.

#### **2.3 Triggers**
- **Stock critique** : Déclencher une alerte (ou une log) si le stock d’un produit passe sous un seuil critique.
- **Mise à jour automatique du statut de commande** : Lorsqu’un paiement est enregistré, marquer la commande comme "payée".
- **Enregistrement de la fidélité client** : Ajouter des points au client après une commande validée.

#### **2.4 Fonctions**
- Calcul du **montant total** d’une commande.
- Génération de **rapports** hebdomadaires (ex : total des ventes, plats les plus commandés).
- Recalcul automatique des **points fidélité** pour un client.

---

### **3. Contraintes Techniques**
#### **3.1 SGBD**
- Le projet utilisera un SGBD relationnel comme MySQL, PostgreSQL ou SQL Server.

#### **3.2 Transactions**
- Toutes les transactions doivent être **ACID** (Atomicité, Cohérence, Isolation, Durabilité).

#### **3.3 Sécurité**
- Mise en place de permissions pour restreindre les accès (ex : lecture seule pour certains utilisateurs).

#### **3.4 Volumétrie**
- Le système doit pouvoir gérer un restaurant de taille moyenne avec environ :
  - 200 clients actifs par mois.
  - 100 commandes par jour.
  - 50 produits gérés dans l’inventaire.

---

### **4. Organisation et Répartition des Tâches**
1. **Modélisation de la base de données (MCD et MLD)** : Adem.
2. **Implémentation des tables et contraintes** : Adem.
3. **Développement des transactions** : Romain.
4. **Création des triggers** : Djamel.
5. **Développement des fonctions** : Djamel.
6. **Tests et optimisation** : Tous les membres.
7. **Rapport** : Tous les membres.
8. **Diaporama** : Adem

---

### **5. Livrables**
- Modèle Conceptuel de Données (MCD).
- Scripts SQL pour la création des tables et des contraintes.
- Scripts SQL pour les transactions, triggers et fonctions.
- Rapport final incluant :
  - Description des fonctionnalités.
  - Démonstration des cas d’utilisation.
  - Documentation des scripts et code.

---

### **6. Calendrier Prévisionnel**
| Étape                      | Date Début   | Date Fin      |
|----------------------------|--------------|---------------|
| Analyse des besoins        | 06/11/2024   | 15/11/2024    |
| Modélisation MCD           | 30/11/2024   | 01/12/2024    |
| Implémentation des tables  | 30/11/2024   | 01/12/2024    |
| Développement SQL          | 02/12/2024   | 25/12/2024    |
| Tests et corrections       | 26/12/2024   | 28/12/2024    |
| GIT / Rapport              | 29/11/2024   | 22/12/2024    |
| Diapo                      | 23/11/2024   | 07/12/2024    |

---

### **7. Méthodologie**
- Suivi hebdomadaire des progrès.
- Utilisation d’outils comme GIT ou Discord pour coordonner les tâches.
- Répartition équitable des tâches et validation en groupe.

---