/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  dell
 * Created: 9 mai 2025
 */

-- Création de la base de données
--CREATE DATABASE IF NOT EXISTS gestion_projets DEFAULT CHARACTER SET utf8mb4;
USE gestion_projets;

-- Table Utilisateur
CREATE TABLE IF NOT EXISTS utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    pwd VARCHAR(100) NOT NULL,
    role ENUM('Administrateur', 'ChefProjet', 'Membre') NOT NULL
);

-- Table Equipe
CREATE TABLE IF NOT EXISTS equipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table Projet
CREATE TABLE IF NOT EXISTS projet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    dateDebut DATE,
    dateFin DATE,
    statut VARCHAR(50),
    equipe_id INT,
    chef_projet_id INT,
    FOREIGN KEY (equipe_id) REFERENCES equipe(id),
    FOREIGN KEY (chef_projet_id) REFERENCES utilisateur(id)
);

-- Table Tâche
CREATE TABLE IF NOT EXISTS tache (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    dureeEstimee INT,
    etat VARCHAR(50),
    projet_id INT,
    membre_id INT,
    FOREIGN KEY (projet_id) REFERENCES projet(id),
    FOREIGN KEY (membre_id) REFERENCES utilisateur(id)
);

-- Table Livrable
CREATE TABLE IF NOT EXISTS livrable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    fichier VARCHAR(255),
    dateDepot DATE,
    tache_id INT,
    FOREIGN KEY (tache_id) REFERENCES tache(id)
);

-- Table TempsTravail
CREATE TABLE IF NOT EXISTS temps_travail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    duree INT,
    date DATE,
    membre_id INT,
    tache_id INT,
    FOREIGN KEY (membre_id) REFERENCES utilisateur(id),
    FOREIGN KEY (tache_id) REFERENCES tache(id)
);
-- Utilisateurs (mot de passe original entre parenthèses)
INSERT INTO utilisateur (nom, email, pwd, role) VALUES
('Ahmed El Mansouri', 'ahmed@edu.uiz.ac.ma', '$2a$10$xaPL4KdSpgx9.QXFu1zZxeJIi2KSGo94M9Vvy733F1dbENeLR8K0e', 'Administrateur'), -- (pwd123)
('Fatima Zahra harit', 'fatima@edu.uiz.ac.ma', '$2a$10$tYUumEEKcwwrE7DV./e9geMEecu4qNm/A9JJpzSBuB0YXsWBioiqq', 'ChefProjet'),       -- (pwd456)
('Youssef Amrani', 'youssef@edu.uiz.ac.ma', '$2a$10$ulFxmcXB01ug/HIYCiSFauQYBa3hQ0MKtcqaybLr6kemSQhg0Qqfy', 'Membre');         -- (pwd789)

-- Données pour la table équipe
INSERT INTO equipe (nom) VALUES
('Équipe Répartie 1'),
('Équipe Cloud Atlas'),
('Équipe Distributed Warriors');

-- Données pour la table projet (liés aux systèmes répartis/distribués)
INSERT INTO projet (nom, description, dateDebut, dateFin, statut, equipe_id, chef_projet_id) VALUES
('Plateforme IoT Répartie', 'Gestion de capteurs répartis en environnement urbain.', '2025-04-01', '2025-06-30', 'En cours', 1, 2),
('Cloud Maroc', 'Infrastructure distribuée pour données gouvernementales.', '2025-03-15', '2025-07-15', 'Planifié', 2, 2),
('Système de Gestion de Projets Distribués', 'Suivi collaboratif de projets en mode distribué.', '2025-02-01', '2025-05-30', 'En cours', 3, 2);

-- Données pour la table tâche
INSERT INTO tache (nom, dureeEstimee, etat, projet_id, membre_id) VALUES
('Développement API MQTT', 10, 'En cours', 1, 3),
('Déploiement Docker Swarm', 15, 'Planifié', 2, 3),
('Module Suivi Temps', 8, 'Terminé', 3, 3);

-- Données pour la table livrable
INSERT INTO livrable (nom, fichier, dateDepot, tache_id) VALUES
('Rapport Capteurs IoT', 'iot_rapport.pdf', '2025-04-15', 1),
('Manuel Déploiement', 'cloud_manual.pdf', '2025-04-20', 2),
('Spécifications Module Temps', 'temps_spec.pdf', '2025-04-10', 3);

-- Données pour la table temps_travail
INSERT INTO temps_travail (duree, date, membre_id, tache_id) VALUES
(4, '2025-04-02', 3, 1),
(5, '2025-04-17', 3, 2),
(3, '2025-04-09', 3, 3);
