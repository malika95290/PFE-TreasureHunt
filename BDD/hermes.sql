-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 24 mai 2026 à 22:25
-- Version du serveur : 11.5.2-MariaDB
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hermes`
--

-- --------------------------------------------------------

--
-- Structure de la table `agents_externes`
--

DROP TABLE IF EXISTS `agents_externes`;
CREATE TABLE IF NOT EXISTS `agents_externes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifiant` varchar(50) NOT NULL,
  `organisation` varchar(100) NOT NULL,
  `niveau_accreditation` int(11) NOT NULL,
  `derniere_connexion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant` (`identifiant`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `agents_externes`
--

INSERT INTO `agents_externes` (`id`, `identifiant`, `organisation`, `niveau_accreditation`, `derniere_connexion`) VALUES
(1, 'agent_vanguard', 'Kryptos Intelligence (Externe)', 5, '2026-05-19 20:10:00'),
(2, 'admin_mvoland', 'Aegis Direction (Interne)', 4, '2026-05-18 13:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `cibles_surveillance`
--

DROP TABLE IF EXISTS `cibles_surveillance`;
CREATE TABLE IF NOT EXISTS `cibles_surveillance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_equipement` varchar(100) NOT NULL,
  `adresse_ip_cible` varchar(45) NOT NULL,
  `statut_interception` varchar(20) DEFAULT 'Actif',
  `date_mise_sur_ecoute` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `cibles_surveillance`
--

INSERT INTO `cibles_surveillance` (`id`, `nom_equipement`, `adresse_ip_cible`, `statut_interception`, `date_mise_sur_ecoute`) VALUES
(1, 'Terminal Satellite Aurora - Secteur Nord', '192.168.42.50', 'Actif', '2026-04-01 09:00:00'),
(2, 'Poste de travail - talimace (Thomas)', '192.168.10.115', 'Actif', '2026-05-18 14:50:00');

-- --------------------------------------------------------

--
-- Structure de la table `surveille`
--

DROP TABLE IF EXISTS `surveille`;
CREATE TABLE IF NOT EXISTS `surveille` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cible_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `date_capture` timestamp NULL DEFAULT current_timestamp(),
  `interface` varchar(50) NOT NULL,
  `nom_fichier_pcap` varchar(100) NOT NULL,
  `taille_octets` int(11) NOT NULL,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cible_id` (`cible_id`),
  KEY `agent_id` (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `surveille`
--

INSERT INTO `surveille` (`id`, `cible_id`, `agent_id`, `date_capture`, `interface`, `nom_fichier_pcap`, `taille_octets`, `statut`) VALUES
(1, 1, 1, '2026-05-17 02:00:00', 'eth0_mirror', 'aurora_routine_traffic.pcap', 1542008, 'Archivé'),
(2, 2, 2, '2026-05-18 13:02:00', 'eth1_spy', 'hermes_dump_secure_extraction.pcap', 42104, 'Terminé'),
(3, 1, 1, '2026-05-19 09:30:00', 'eth0_mirror', 'aurora_intercept_stream.pcap', 892110, 'En cours');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `surveille`
--
ALTER TABLE `surveille`
  ADD CONSTRAINT `surveille_ibfk_1` FOREIGN KEY (`cible_id`) REFERENCES `cibles_surveillance` (`id`),
  ADD CONSTRAINT `surveille_ibfk_2` FOREIGN KEY (`agent_id`) REFERENCES `agents_externes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
