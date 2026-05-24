-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 24 mai 2026 à 22:24
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
-- Base de données : `aegis_core`
--

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `nom_fichier` varchar(255) NOT NULL,
  `date_depot` datetime DEFAULT current_timestamp(),
  `auteur_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auteur_id` (`auteur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `documents`
--

INSERT INTO `documents` (`id`, `titre`, `nom_fichier`, `date_depot`, `auteur_id`) VALUES
(1, 'Note Vocale Incident', 'Note_Vocale_Incident.wav', '2026-05-20 00:12:06', 2);

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `date_creation` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`id`, `user_id`, `titre`, `description`, `date_creation`) VALUES
(1, 2, 'Rappel : Logistique', 'Penser à acheter les croquettes pour Felix avant la fermeture de la supérette.', '2026-05-22 20:57:42'),
(2, 1, 'Revue stratégique annuelle', 'Préparer les slides pour le comité de direction du 30 mai. Inclure les KPIs sécurité et les projets en cours.', '2026-05-01 06:00:00'),
(3, 1, 'Point avec OTAN', 'Confirmer la réunion de coordination avec rpetit avant le déplacement à Bruxelles. Ordre du jour à valider.', '2026-05-05 06:00:00'),
(4, 1, 'Audit infrastructures', 'Demander à amoreau un rapport sur l état des systèmes critiques avant fin mai.', '2026-05-10 06:00:00'),
(5, 1, 'Budget Défense Q3', 'Revoir les allocations budgétaires avec le service financier. Priorité aux projets cyber.', '2026-05-15 06:00:00'),
(6, 2, 'Rappel : Logistique', 'Penser à acheter les croquettes pour Felix avant la semaine prochaine. Aussi prévoir rdv vétérinaire.', '2026-05-22 06:00:00'),
(7, 2, 'Mise à jour firmware routeurs', 'Planifier la fenêtre de maintenance nocturne pour patcher les routeurs coeur de réseau. Prévoir rollback.', '2026-05-08 06:00:00'),
(8, 2, 'Documentation VLAN', 'Mettre à jour le schéma de segmentation réseau suite aux changements de la semaine dernière.', '2026-05-12 06:00:00'),
(9, 2, 'Incident lien primaire', 'Rédiger le rapport post-incident concernant la coupure du lien primaire datacenter B. Cause racine identifiée.', '2026-05-18 06:00:00'),
(10, 3, 'Rapport opérations mai', 'Finaliser le bilan mensuel des opérations. Sections à compléter : incidents, capacités, projections.', '2026-05-02 06:00:00'),
(11, 3, 'Réunion de crise simulée', 'Coordonner l exercice de continuité d activité prévu le 12 juin. Convoquer les chefs de département.', '2026-05-09 06:00:00'),
(12, 3, 'Validation procédures urgence', 'Relire et signer les nouvelles procédures d urgence transmises par sblanchard.', '2026-05-14 06:00:00'),
(13, 3, 'Effectifs zone nord', 'Faire le point sur les rotations de personnel prévues pour l été avec les responsables RH.', '2026-05-20 06:00:00'),
(14, 4, 'Architecture SI cible', 'Finaliser le document d architecture cible horizon 2028. Intégrer les retours de lchampagne.', '2026-05-03 06:00:00'),
(15, 4, 'POC chiffrement post-quantique', 'Suivre l avancement du POC mené par arichard. Résultats attendus pour fin juin.', '2026-05-07 06:00:00'),
(16, 4, 'Homologation système ARES', 'Préparer le dossier d homologation à soumettre à l ANSSI. Deadline : 15 juin.', '2026-05-13 06:00:00'),
(17, 4, 'Réunion fournisseurs', 'Préparer les questions techniques pour la réunion avec les fournisseurs d équipements réseau.', '2026-05-19 06:00:00'),
(18, 5, 'Audit sécurité trimestriel', 'Lancer la campagne d audit interne Q2. Périmètre : accès logiques, journalisation, chiffrement.', '2026-05-04 06:00:00'),
(19, 5, 'Politique mots de passe', 'Mettre à jour la politique de gestion des mots de passe. Intégrer les recommandations ANSSI 2026.', '2026-05-08 06:00:00'),
(20, 5, 'Revue habilitations', 'Vérifier que les droits d accès correspondent aux fiches de poste. Signaler les anomalies à direction.', '2026-05-16 06:00:00'),
(21, 5, 'Formation cybersécurité', 'Organiser la session de sensibilisation obligatoire pour les nouveaux arrivants du mois de juin.', '2026-05-21 06:00:00'),
(22, 6, 'Contrat industriel CI-7', 'Finaliser les négociations avec le groupement industriel. Clause de souveraineté des données à revoir.', '2026-05-02 06:00:00'),
(23, 6, 'Coordination DGA', 'Préparer le brief pour la réunion DGA du 3 juin. Points clés : budget, délais, jalons critiques.', '2026-05-10 06:00:00'),
(24, 6, 'Rapport partenariats', 'Synthétiser l état des partenariats stratégiques en cours pour présentation au COO.', '2026-05-17 06:00:00'),
(25, 6, 'Veille réglementaire', 'Suivre les évolutions de la directive NIS2 et leurs impacts sur notre organisation.', '2026-05-22 06:00:00'),
(26, 7, 'Agenda direction juin', 'Préparer et diffuser le planning des réunions de direction pour le mois de juin.', '2026-05-05 06:00:00'),
(27, 7, 'Compte-rendu CODIR', 'Rédiger et diffuser le compte-rendu du CODIR du 20 mai dans les 48h.', '2026-05-21 06:00:00'),
(28, 7, 'Accueil délégation étrangère', 'Organiser la visite de la délégation partenaire prévue le 8 juin. Logistique et protocole.', '2026-05-15 06:00:00'),
(29, 7, 'Courrier ministériel', 'Préparer la réponse au courrier du cabinet ministériel reçu le 19 mai.', '2026-05-19 06:00:00'),
(30, 8, 'Note stratégique IA', 'Rédiger une note sur les risques et opportunités liés à l intégration de l IA dans les systèmes défense.', '2026-05-06 06:00:00'),
(31, 8, 'Scénarios géopolitiques', 'Mettre à jour les scénarios de tension pour la zone est-européenne. Sources à vérifier.', '2026-05-11 06:00:00'),
(32, 8, 'Brief hebdomadaire', 'Préparer le brief stratégique hebdomadaire pour la direction. Format : 2 pages max.', '2026-05-18 06:00:00'),
(33, 8, 'Analyse partenaires', 'Évaluer la fiabilité des partenaires institutionnels dans le cadre du projet HORIZON.', '2026-05-22 06:00:00'),
(34, 9, 'Contrats sous-traitants', 'Vérifier la conformité RGPD des contrats avec les sous-traitants. Délai : fin du mois.', '2026-05-03 06:00:00'),
(35, 9, 'Contentieux en cours', 'Faire le point sur les dossiers contentieux avec le cabinet externe. Audience le 14 juin.', '2026-05-09 06:00:00'),
(36, 9, 'NDA partenaires', 'Mettre à jour les accords de confidentialité avec les nouveaux partenaires industriels.', '2026-05-16 06:00:00'),
(37, 9, 'Réglementation export', 'Analyser les nouvelles restrictions à l exportation de technologies duales. Impact sur nos projets.', '2026-05-20 06:00:00'),
(38, 10, 'Réunion OTAN Bruxelles', 'Préparer le dossier de position pour la réunion de coordination OTAN du 4 juin.', '2026-05-04 06:00:00'),
(39, 10, 'Rapport interopérabilité', 'Synthétiser les résultats de l exercice d interopérabilité ALLIED SHIELD 2026.', '2026-05-12 06:00:00'),
(40, 10, 'Point forces alliées', 'Coordonner avec les attachés de défense alliés pour le partage de renseignements opérationnels.', '2026-05-18 06:00:00'),
(41, 10, 'Traduction documents OTAN', 'Faire traduire et classifier les documents reçus du QG OTAN la semaine passée.', '2026-05-21 06:00:00'),
(42, 11, 'Déploiement zone ouest', 'Finaliser le plan de déploiement des unités en zone ouest pour juillet. Validation direction requise.', '2026-05-05 06:00:00'),
(43, 11, 'Rapport sécurité périmétrique', 'Analyser les incidents des 30 derniers jours sur le périmètre physique. Actions correctives à prévoir.', '2026-05-11 06:00:00'),
(44, 11, 'Exercice alerte', 'Organiser l exercice de montée en alerte du 20 juin. Scénario : intrusion système d information.', '2026-05-17 06:00:00'),
(45, 11, 'Coordination forces', 'Réunion de coordination avec les commandants de secteur prévue le 2 juin.', '2026-05-22 06:00:00'),
(46, 12, 'Rapport renseignement mensuel', 'Compiler et classifier le rapport de renseignement mensuel. Diffusion restreinte niveau TS.', '2026-05-01 06:00:00'),
(47, 12, 'Analyse source SOLEIL', 'Croiser les informations issues de la source SOLEIL avec les données SIGINT de la semaine.', '2026-05-07 06:00:00'),
(48, 12, 'Veille menaces', 'Mettre à jour la cartographie des menaces acteurs étatiques pour le trimestre en cours.', '2026-05-14 06:00:00'),
(49, 12, 'Brief décideurs', 'Préparer le brief de renseignement pour les décideurs du 27 mai. Durée : 20 minutes.', '2026-05-22 06:00:00'),
(50, 13, 'Migration datacenter', 'Superviser la phase 2 de migration vers le datacenter redondant. Date cible : 30 juin.', '2026-05-02 06:00:00'),
(51, 13, 'Revue PCA/PRA', 'Mettre à jour le Plan de Continuité et de Reprise d Activité suite aux nouveaux systèmes déployés.', '2026-05-08 06:00:00'),
(52, 13, 'Inventaire actifs SI', 'Lancer la campagne d inventaire annuelle des actifs informatiques. Coordonner avec sblanchard.', '2026-05-15 06:00:00'),
(53, 13, 'Projet SIGMA - jalons', 'Suivre les jalons du projet SIGMA avec l équipe projet. Retard de 2 semaines à rattraper.', '2026-05-20 06:00:00'),
(54, 14, 'Coordination ministères', 'Préparer la réunion de coordination interministérielle du 5 juin. Ordre du jour à circuler.', '2026-05-03 06:00:00'),
(55, 14, 'Note de synthèse CGET', 'Rédiger la note de synthèse pour le CGET sur l avancement des projets communs.', '2026-05-10 06:00:00'),
(56, 14, 'Réponse Sénat', 'Préparer les éléments de réponse à la commission sénatoriale sur les capacités cyber nationales.', '2026-05-17 06:00:00'),
(57, 14, 'Réunion SGDSN', 'Confirmer la participation à la réunion SGDSN du 28 mai et préparer les supports.', '2026-05-21 06:00:00'),
(58, 15, 'Algorithmes post-quantiques', 'Évaluer CRYSTALS-Kyber et CRYSTALS-Dilithium pour remplacement des algorithmes asymétriques actuels.', '2026-05-04 06:00:00'),
(59, 15, 'Audit implémentation TLS', 'Vérifier la conformité des configurations TLS 1.3 sur les passerelles sécurisées.', '2026-05-09 06:00:00'),
(60, 15, 'Rotation clés KMS', 'Planifier la rotation trimestrielle des clés dans le système de gestion de clés.', '2026-05-16 06:00:00'),
(61, 15, 'Documentation algo', 'Mettre à jour la documentation des algorithmes approuvés pour les nouveaux projets.', '2026-05-20 06:00:00'),
(62, 16, 'POC QKD', 'Documenter les résultats du proof-of-concept de distribution de clés quantiques avec le labo.', '2026-05-05 06:00:00'),
(63, 16, 'Veille NIST PQC', 'Suivre les dernières publications NIST sur la cryptographie post-quantique. Rapport à direction.', '2026-05-11 06:00:00'),
(64, 16, 'Benchmark chiffrement', 'Comparer les performances des algorithmes candidats sur notre matériel embarqué.', '2026-05-18 06:00:00'),
(65, 16, 'Formation équipe', 'Animer la session de formation interne sur les fondamentaux de la cryptographie quantique.', '2026-05-22 06:00:00'),
(66, 17, 'Renouvellement certificats', 'Anticiper le renouvellement de 47 certificats arrivant à expiration en juillet. Planning à établir.', '2026-05-03 06:00:00'),
(67, 17, 'Audit PKI', 'Réaliser l audit annuel de l infrastructure PKI. Vérifier les CRL et les OCSP.', '2026-05-08 06:00:00'),
(68, 17, 'Nouvelle AC subordonnée', 'Préparer le dossier de création d une nouvelle autorité de certification pour le projet HERMES.', '2026-05-14 06:00:00'),
(69, 17, 'Révocation urgente', 'Traiter la demande de révocation du certificat compromis signalée par gcolin ce matin.', '2026-05-22 06:00:00'),
(70, 18, 'Bibliothèque crypto interne', 'Finaliser la v2.0 de la bibliothèque cryptographique maison. Tests unitaires à 94%.', '2026-05-02 06:00:00'),
(71, 18, 'Intégration HSM', 'Développer le module d interface avec les nouveaux HSM Thales installés la semaine dernière.', '2026-05-09 06:00:00'),
(72, 18, 'Review code chiffrement', 'Effectuer la revue de code du module de chiffrement de fichiers développé par kbonnet.', '2026-05-16 06:00:00'),
(73, 18, 'Correction CVE-2026-1337', 'Analyser l impact de la CVE sur notre bibliothèque et développer le patch correctif.', '2026-05-21 06:00:00'),
(74, 19, 'Audit annuel cryptologie', 'Lancer l audit de sécurité annuel du département cryptologie. Périmètre défini avec sblanchard.', '2026-05-04 06:00:00'),
(75, 19, 'Pentest HSM', 'Réaliser les tests d intrusion sur les nouveaux modules HSM avant mise en production.', '2026-05-10 06:00:00'),
(76, 19, 'Rapport conformité', 'Rédiger le rapport de conformité aux référentiels ANSSI pour les systèmes de chiffrement.', '2026-05-17 06:00:00'),
(77, 19, 'Veille CVE crypto', 'Mettre à jour le tableau de bord des vulnérabilités affectant nos composants cryptographiques.', '2026-05-22 06:00:00'),
(78, 20, 'Inventaire certificats', 'Mettre à jour l inventaire exhaustif des certificats actifs sur l ensemble du SI.', '2026-05-05 06:00:00'),
(79, 20, 'Procédure révocation', 'Réviser la procédure de révocation d urgence. Délai cible : moins de 4 heures.', '2026-05-12 06:00:00'),
(80, 20, 'Formation utilisateurs', 'Organiser la session de sensibilisation sur la gestion des certificats pour les équipes IT.', '2026-05-18 06:00:00'),
(81, 20, 'Rapport expiration', 'Générer le rapport mensuel des certificats à renouveler et le transmettre à bdumont.', '2026-05-22 06:00:00'),
(82, 21, 'Analyse IOC campagne APT', 'Corréler les indicateurs de compromission de la campagne APT détectée lundi avec les logs SIEM.', '2026-05-06 06:00:00'),
(83, 21, 'Escalade incident P1', 'Rédiger le rapport de gestion de l incident P1 de la nuit du 18 au 19 mai. Chronologie complète.', '2026-05-19 06:00:00'),
(84, 21, 'Mise à jour playbooks', 'Mettre à jour les playbooks de réponse aux incidents suite aux retours de l exercice du 10 mai.', '2026-05-13 06:00:00'),
(85, 21, 'Règles SIEM', 'Créer les nouvelles règles de corrélation pour détecter les mouvements latéraux de type Pass-the-Hash.', '2026-05-20 06:00:00'),
(86, 22, 'Rapport CERT mensuel', 'Rédiger le rapport mensuel d activité CERT. Statistiques incidents, tendances, recommandations.', '2026-05-01 06:00:00'),
(87, 22, 'Partage TLP:WHITE', 'Préparer le bulletin de partage d informations TLP:WHITE sur la campagne de phishing en cours.', '2026-05-07 06:00:00'),
(88, 22, 'Coordination CERT-FR', 'Prendre contact avec le CERT-FR pour le partage de renseignements sur la menace LAZARUS.', '2026-05-14 06:00:00'),
(89, 22, 'Amélioration détection', 'Revoir avec ojacques les seuils d alerte sur les règles de détection d exfiltration de données.', '2026-05-21 06:00:00'),
(90, 23, 'Pentest appli MERCURE', 'Finaliser le rapport du test d intrusion de l application MERCURE. Vulnérabilités critiques à documenter.', '2026-05-03 06:00:00'),
(91, 23, 'Red team exercice', 'Planifier l exercice red team du mois de juillet. Périmètre : SI opérationnel zone B.', '2026-05-09 06:00:00'),
(92, 23, 'Exploitation CVE-2026-0892', 'Analyser la CVE dans notre environnement de test et rédiger la note d exploitation pour sensibilisation.', '2026-05-16 06:00:00'),
(93, 23, 'Formation pentest web', 'Animer la session de formation sur les techniques d injection SQL avancées pour l équipe.', '2026-05-21 06:00:00'),
(94, 24, 'Analyse échantillon malware', 'Analyser le sample collecté sur le poste compromis. Suspicion : variante Cobalt Strike.', '2026-05-05 06:00:00'),
(95, 24, 'Rapport rétro-ingénierie', 'Documenter les résultats de la rétro-ingénierie du loader identifié lors de l incident du 12 mai.', '2026-05-13 06:00:00'),
(96, 24, 'Mise à jour signatures', 'Mettre à jour les signatures YARA suite à l analyse du nouveau malware identifié cette semaine.', '2026-05-18 06:00:00'),
(97, 24, 'Sandbox configuration', 'Reconfigurer l environnement sandbox pour contourner les techniques d anti-analyse du dernier sample.', '2026-05-22 06:00:00'),
(98, 25, 'Post-mortem incident', 'Rédiger le post-mortem de l incident de la semaine dernière. RCA et plan d action à finaliser.', '2026-05-08 06:00:00'),
(99, 25, 'Procédures confinement', 'Mettre à jour les procédures de confinement d hôtes compromis. Intégrer les nouveaux outils EDR.', '2026-05-13 06:00:00'),
(100, 25, 'Exercice IR', 'Préparer le scénario de l exercice de réponse à incidents du 15 juin avec l équipe.', '2026-05-19 06:00:00'),
(101, 25, 'Dashboard métriques', 'Créer le tableau de bord de suivi des métriques MTTR et MTTD pour le reporting direction.', '2026-05-22 06:00:00'),
(102, 2, 'Rappel Secu : Identifiants Serveur', 'Pour la connexion SSH Mot de passe : [Le nom de mon chat en minuscules]', '2026-02-10 13:20:00');

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_projet` varchar(20) NOT NULL,
  `nom_projet` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `responsable_id` int(11) DEFAULT NULL,
  `priorite` enum('Basse','Moyenne','Haute','Critique') DEFAULT 'Moyenne',
  `date_echeance` date DEFAULT NULL,
  `statut_projet` enum('Etude','Developpement','Deploiement','Archive') DEFAULT 'Etude',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_projet` (`code_projet`),
  KEY `responsable_id` (`responsable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `projects`
--

INSERT INTO `projects` (`id`, `code_projet`, `nom_projet`, `description`, `responsable_id`, `priorite`, `date_echeance`, `statut_projet`) VALUES
(1, 'PRJ-HERMES', 'Réseau HERMES v4.1', 'Déploiement de la couche de chiffrement quantique sur les terminaux de bord.', 2, 'Critique', NULL, 'Developpement'),
(2, 'PRJ-AURORA', 'Surveillance Satellite Aurora', 'Analyse des flux de données en provenance de la constellation Aurora-6.', 1, 'Haute', NULL, 'Etude'),
(3, 'PRJ-TITAN', 'Bouclier TITAN', 'Déploiement du système de défense périmétrique multicouche sur les nœuds sensibles du réseau AEGIS.', 3, 'Critique', '2026-09-30', 'Developpement'),
(4, 'PRJ-OBSIDIAN', 'Protocole Obsidian', 'Refonte complète de l\'architecture PKI interne avec intégration des standards post-quantiques NIST.', 13, 'Critique', '2026-12-15', 'Developpement'),
(5, 'PRJ-ECLIPSE', 'Satellite Eclipse-7', 'Extension de la constellation Aurora avec déploiement de 7 nouveaux modules d\'observation hyperspectrale.', 1, 'Critique', '2027-03-01', 'Etude'),
(6, 'PRJ-FORGE', 'Plateforme FORGE', 'Création d\'un environnement de forge sécurisée pour la compilation et la signature de logiciels critiques.', 3, 'Critique', '2026-08-31', 'Developpement'),
(7, 'PRJ-NEMESIS', 'Système NEMESIS', 'Développement d\'un outil d\'attribution automatisée des cyberattaques par IA.', 20, 'Critique', '2026-11-30', 'Etude'),
(8, 'PRJ-SILEX', 'Firewall SILEX v3', 'Migration et refonte de la couche applicative du pare-feu de nouvelle génération sur les bastions de bord.', 21, 'Critique', '2026-07-15', 'Developpement'),
(9, 'PRJ-STRIX', 'Drone STRIX-Alpha', 'Prototype de drone autonome à capacité SIGINT pour surveillance de zone de confinement.', 44, 'Critique', '2027-01-31', 'Etude'),
(10, 'PRJ-VAULT', 'Coffre-fort VAULT', 'Mise en œuvre d\'un système de stockage souverain chiffré de bout en bout pour les archives classifiées.', 14, 'Critique', '2026-10-01', 'Developpement'),
(11, 'PRJ-GRANITE', 'Réseau GRANITE', 'Déploiement d\'un backbone fibre dédié entre les sites AEGIS de Lyon, Brest et Toulon.', 25, 'Critique', '2026-06-30', 'Deploiement'),
(12, 'PRJ-COBALT', 'Module COBALT', 'Intégration d\'un module de chiffrement homomorphe pour les traitements analytiques sur données classifiées.', 13, 'Critique', '2027-06-30', 'Etude'),
(13, 'PRJ-PHALANX', 'Système PHALANX', 'Déploiement d\'une infrastructure de détection et neutralisation de drones non autorisés sur le périmètre.', 9, 'Critique', '2026-09-15', 'Developpement'),
(14, 'PRJ-OLYMPE', 'Plateforme OLYMPE', 'Refonte de la plateforme de commandement et de contrôle distribuée pour opérations interarmées.', 1, 'Critique', '2027-09-30', 'Etude'),
(15, 'PRJ-SCALPEL', 'Outil SCALPEL', 'Développement d\'un framework d\'analyse forensique pour investigations numériques classifiées.', 20, 'Critique', '2026-08-01', 'Developpement'),
(16, 'PRJ-NEXUS-II', 'Hub NEXUS II', 'Extension de la capacité de traitement du hub d\'échanges sécurisés interministériels.', 7, 'Critique', '2026-12-31', 'Developpement'),
(17, 'PRJ-ORION', 'Constellation ORION', 'Déploiement de sondes SIGINT sur les axes de communication stratégiques identifiés.', 35, 'Haute', '2026-11-30', 'Etude'),
(18, 'PRJ-MERCURY', 'Bus de données MERCURY', 'Mise en place d\'un bus de messagerie sécurisé entre les entités de renseignement partenaires.', 8, 'Haute', '2026-09-01', 'Developpement'),
(19, 'PRJ-SHIELD', 'Projet SHIELD', 'Hardening systématique des 240 postes de travail classifiés selon la politique ANSSI renforcée.', 22, 'Haute', '2026-07-31', 'Deploiement'),
(20, 'PRJ-ALCHEMY', 'Labo ALCHEMY', 'Création d\'un laboratoire d\'expérimentation IA pour la détection d\'anomalies comportementales.', 38, 'Haute', '2026-10-15', 'Developpement'),
(21, 'PRJ-SERAPH', 'Antenne SERAPH', 'Renouvellement du parc d\'antennes de communications tactiques sur les véhicules de commandement.', 2, 'Haute', '2026-08-20', 'Developpement'),
(22, 'PRJ-LAZUR', 'Réseau LAZUR', 'Extension de la couverture réseau sur le site de Bordeaux avec chiffrement de couche 2.', 26, 'Haute', '2026-09-30', 'Developpement'),
(23, 'PRJ-CORVUS', 'IA CORVUS', 'Entraînement et déploiement d\'un modèle de traitement du langage naturel sur corpus classifié.', 39, 'Haute', '2027-02-28', 'Etude'),
(24, 'PRJ-ARGUS', 'Système ARGUS', 'Centralisation et supervision unifiée des journaux d\'événements de l\'ensemble des systèmes AEGIS.', 22, 'Haute', '2026-08-31', 'Developpement'),
(25, 'PRJ-BASTION', 'Site BASTION', 'Construction et déploiement d\'un site de repli informatique sécurisé en zone N3.', 9, 'Haute', '2027-04-30', 'Etude'),
(26, 'PRJ-PRISM', 'Capteur PRISM', 'Développement d\'un capteur d\'analyse hyperspectrale embarqué sur drone de haute altitude.', 44, 'Haute', '2026-12-01', 'Developpement'),
(27, 'PRJ-LYNX', 'Système LYNX', 'Déploiement d\'un système de vidéosurveillance intelligente périmétrique sur les 4 sites principaux.', 29, 'Haute', '2026-11-15', 'Developpement'),
(28, 'PRJ-ANCHOR', 'Protocole ANCHOR', 'Standardisation des protocoles d\'authentification forte pour les accès distants aux systèmes sensibles.', 19, 'Haute', '2026-09-01', 'Deploiement'),
(29, 'PRJ-CADUCEE', 'Système CADUCÉE', 'Déploiement d\'un système de télémédecine sécurisé pour le personnel en mission prolongée.', 54, 'Haute', '2026-10-31', 'Etude'),
(30, 'PRJ-TEMPEST', 'Audit TEMPEST', 'Campagne d\'audit des émanations électromagnétiques parasites sur les locaux techniques sensibles.', 3, 'Haute', '2026-07-01', 'Deploiement'),
(31, 'PRJ-VELA', 'Satellite VELA', 'Étude de faisabilité pour la mise en orbite d\'un microsatellite de surveillance en orbite basse.', 1, 'Haute', '2027-12-31', 'Etude'),
(32, 'PRJ-FENRIR', 'Algorithme FENRIR', 'Développement d\'un algorithme de détection d\'intrusion basé sur l\'analyse comportementale réseau.', 20, 'Haute', '2026-11-01', 'Developpement'),
(33, 'PRJ-ATLAS', 'Base ATLAS', 'Migration de la base documentaire classifiée vers la plateforme souveraine AEGIS-DMS.', 57, 'Moyenne', '2026-09-15', 'Developpement'),
(34, 'PRJ-PIXEL', 'Outil PIXEL', 'Développement d\'outils de stéganographie défensive pour la protection des documents sensibles.', 15, 'Moyenne', '2026-12-31', 'Etude'),
(35, 'PRJ-ECHO', 'Réseau ECHO', 'Étude de la mise en place d\'un réseau maillé à courte portée pour communications tactiques terrain.', 8, 'Moyenne', '2027-01-31', 'Etude'),
(36, 'PRJ-CARBON', 'Certification CARBON', 'Processus de certification ISO 27001 pour les activités de traitement des données personnelles.', 57, 'Moyenne', '2026-10-30', 'Developpement'),
(37, 'PRJ-PULSAR', 'Système PULSAR', 'Déploiement d\'un système de synchronisation d\'horloge atomique sur les serveurs critiques.', 26, 'Moyenne', '2026-08-15', 'Deploiement'),
(38, 'PRJ-MIRAGE', 'Honeypot MIRAGE', 'Déploiement d\'un réseau de pots de miel avancés pour la détection et l\'analyse d\'intrusions.', 22, 'Moyenne', '2026-10-01', 'Developpement'),
(39, 'PRJ-JADE', 'Outil JADE', 'Développement d\'un outil de cartographie automatique de la surface d\'attaque exposée.', 21, 'Moyenne', '2026-11-30', 'Etude'),
(40, 'PRJ-INDUS', 'Site INDUS', 'Sécurisation des systèmes de contrôle industriels (SCADA) sur le site de Cherbourg.', 29, 'Moyenne', '2026-12-15', 'Developpement'),
(41, 'PRJ-FLASH', 'Formation FLASH', 'Programme de sensibilisation à la cybersécurité pour l\'ensemble du personnel non-technique.', 58, 'Moyenne', '2026-09-01', 'Deploiement'),
(42, 'PRJ-HELIX', 'Architecture HELIX', 'Refonte de l\'architecture réseau du datacenter principal avec micro-segmentation.', 25, 'Moyenne', '2026-10-31', 'Developpement'),
(43, 'PRJ-ONYX', 'Module ONYX', 'Développement d\'un module d\'analyse de trafic réseau chiffré sans déchiffrement.', 14, 'Moyenne', '2027-03-31', 'Etude'),
(44, 'PRJ-POLAR', 'Système POLAR', 'Déploiement d\'une infrastructure de supervision réseau pour les terminaux distants en zone froide.', 2, 'Moyenne', '2026-11-01', 'Developpement'),
(45, 'PRJ-COSMO', 'Étude COSMO', 'Analyse de l\'impact des perturbations géomagnétiques sur les systèmes de communication AEGIS.', 35, 'Moyenne', '2027-02-28', 'Etude'),
(46, 'PRJ-DELTA', 'Protocole DELTA', 'Révision du plan de continuité d\'activité et des procédures de reprise après sinistre.', 57, 'Moyenne', '2026-09-30', 'Developpement'),
(47, 'PRJ-SIGMA', 'Audit SIGMA', 'Audit complet des droits d\'accès et revue des habilitations sur l\'ensemble du parc AEGIS.', 3, 'Moyenne', '2026-08-01', 'Deploiement'),
(48, 'PRJ-LIBRA', 'Archive LIBRA', 'Numérisation et archivage sécurisé des documents papier classifiés antérieurs à 2015.', 60, 'Basse', '2026-12-31', 'Developpement'),
(49, 'PRJ-DENEB', 'Étude DENEB', 'Veille technologique sur les nouvelles menaces liées à l\'informatique quantique.', 37, 'Basse', '2027-06-30', 'Etude'),
(50, 'PRJ-FOSSIL', 'Migration FOSSIL', 'Migration des applications héritées (legacy) tournant sur systèmes Windows Server 2008.', 28, 'Basse', '2026-10-31', 'Developpement'),
(51, 'PRJ-AMBER', 'Système AMBER', 'Étude de faisabilité d\'un système d\'alerte précoce pour les menaces internes.', 19, 'Basse', '2027-01-15', 'Etude'),
(52, 'PRJ-KILO', 'Projet KILO', 'Remplacement progressif des équipements réseau en fin de vie sur les sites secondaires.', 32, 'Basse', '2026-12-01', 'Developpement'),
(53, 'PRJ-RUBIS-OLD', 'Projet RUBIS (archivé)', 'Ancien système de messagerie sécurisée — remplacé par MERCURY. Maintien en condition opérationnelle résiduel.', 2, 'Basse', '2025-12-31', 'Archive'),
(54, 'PRJ-TOPAZ-OLD', 'Projet TOPAZ (archivé)', 'Ancienne plateforme de supervision réseau — remplacée par ARGUS. Documentation conservée.', 22, 'Basse', '2025-06-30', 'Archive');

-- --------------------------------------------------------

--
-- Structure de la table `surveille`
--

DROP TABLE IF EXISTS `surveille`;
CREATE TABLE IF NOT EXISTS `surveille` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_capture` timestamp NULL DEFAULT current_timestamp(),
  `interface` varchar(50) NOT NULL,
  `nom_fichier_pcap` varchar(100) NOT NULL,
  `taille_octets` int(11) NOT NULL,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `surveille`
--

INSERT INTO `surveille` (`id`, `date_capture`, `interface`, `nom_fichier_pcap`, `taille_octets`, `statut`) VALUES
(1, '2026-05-19 23:11:55', 'eth0_mirror', 'hermes_dump_secure_extraction.pcap', 42104, 'Terminé');

-- --------------------------------------------------------

--
-- Structure de la table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `priorite` enum('Basse','Moyenne','Haute','Critique') DEFAULT 'Moyenne',
  `statut` enum('Ouvert','En cours','Résolu','Fermé') DEFAULT 'Ouvert',
  `auteur_id` int(11) NOT NULL,
  `assigne_a` int(11) NOT NULL,
  `date_creation` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `auteur_id` (`auteur_id`),
  KEY `assigne_a` (`assigne_a`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `tickets`
--

INSERT INTO `tickets` (`id`, `titre`, `description`, `priorite`, `statut`, `auteur_id`, `assigne_a`, `date_creation`) VALUES
(1, 'Accès VPN instable', 'Le tunnel IPsec vers le satellite Aurora se coupe toutes les 5 minutes.', 'Haute', 'Ouvert', 1, 2, '2026-05-11 13:00:57'),
(3, 'Impossible de se connecter au tableau de bord', 'Erreur visible uniquement en environnement de production.', 'Haute', 'Résolu', 13, 14, '2023-12-31 23:00:00'),
(4, 'Erreur 500 lors de la soumission du formulaire', 'Le support client a escaladé ce ticket en urgence.', 'Moyenne', 'Résolu', 4, 2, '2024-01-02 23:00:00'),
(5, 'Le bouton de téléchargement ne répond pas', 'Erreur visible uniquement en environnement de production.', 'Moyenne', 'Ouvert', 12, 6, '2024-01-04 23:00:00'),
(6, 'Rapport hebdomadaire non reçu', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Critique', 'Fermé', 6, 5, '2024-01-06 23:00:00'),
(7, 'Problème de synchronisation des données', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Basse', 'Résolu', 12, 6, '2024-01-09 23:00:00'),
(8, 'Accès refusé à la section administration', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Basse', 'Résolu', 1, 6, '2024-01-11 23:00:00'),
(9, 'Lenteur extrême sur la page d\'accueil', 'Erreur visible uniquement en environnement de production.', 'Haute', 'Résolu', 18, 5, '2024-01-13 23:00:00'),
(10, 'Export CSV corrompu', 'Les logs serveur indiquent une exception non gérée.', 'Basse', 'Ouvert', 2, 13, '2024-01-16 23:00:00'),
(11, 'Notification email non envoyée', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'En cours', 7, 5, '2024-01-18 23:00:00'),
(12, 'Crash de l\'application mobile', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Basse', 'Fermé', 4, 3, '2024-01-20 23:00:00'),
(13, 'Interface inaccessible sur Safari', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Moyenne', 'En cours', 20, 13, '2024-01-23 23:00:00'),
(14, 'Données utilisateur incorrectes', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Haute', 'Ouvert', 13, 20, '2024-01-25 23:00:00'),
(15, 'Échec de mise à jour du profil', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Haute', 'Résolu', 18, 16, '2024-01-27 23:00:00'),
(16, 'Page blanche après connexion', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Critique', 'Résolu', 11, 4, '2024-01-29 23:00:00'),
(17, 'Erreur de calcul dans le module facturation', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Haute', 'Fermé', 7, 11, '2024-02-01 23:00:00'),
(18, 'Double facturation détectée', 'L\'anomalie entraîne une perte de données partielle.', 'Critique', 'Fermé', 12, 2, '2024-02-03 23:00:00'),
(19, 'Problème d\'importation de fichier Excel', 'Impact critique sur le processus de facturation mensuelle.', 'Haute', 'Ouvert', 9, 16, '2024-02-05 23:00:00'),
(20, 'Timeout lors de la recherche avancée', 'Nécessite une investigation approfondie côté backend.', 'Haute', 'Résolu', 11, 14, '2024-02-08 23:00:00'),
(21, 'Formulaire de contact non fonctionnel', 'Les logs serveur indiquent une exception non gérée.', 'Critique', 'En cours', 4, 8, '2024-02-10 23:00:00'),
(22, 'Mauvaise redirection après login', 'Le comportement est différent entre les environnements de staging et de prod.', 'Haute', 'Résolu', 15, 7, '2024-02-12 23:00:00'),
(23, 'Clé API expirée', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Critique', 'Fermé', 12, 3, '2024-02-15 23:00:00'),
(24, 'Permission insuffisante pour modifier', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Moyenne', 'Ouvert', 20, 18, '2024-02-17 23:00:00'),
(25, 'Image de profil non mise à jour', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Moyenne', 'Fermé', 11, 13, '2024-02-19 23:00:00'),
(26, 'Violation RGPD suspectée', 'Impact critique sur le processus de facturation mensuelle.', 'Moyenne', 'En cours', 11, 20, '2024-02-21 23:00:00'),
(27, 'Token de session expiré trop vite', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Haute', 'Fermé', 7, 1, '2024-02-24 23:00:00'),
(28, 'Module de reporting indisponible', 'Impact critique sur le processus de facturation mensuelle.', 'Moyenne', 'Fermé', 18, 13, '2024-02-26 23:00:00'),
(29, 'Alerte de sécurité non traitée', 'Nécessite une investigation approfondie côté backend.', 'Haute', 'En cours', 10, 12, '2024-02-28 23:00:00'),
(30, 'Accès concurrent bloquant', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Moyenne', 'Ouvert', 16, 5, '2024-03-02 23:00:00'),
(31, 'Données corrompues après migration', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Moyenne', 'En cours', 13, 11, '2024-03-04 23:00:00'),
(32, 'Service indisponible depuis 3 jours', 'L\'anomalie entraîne une perte de données partielle.', 'Moyenne', 'Résolu', 14, 6, '2024-03-06 23:00:00'),
(33, 'Déconnexion automatique intempestive', 'Impact critique sur le processus de facturation mensuelle.', 'Moyenne', 'Ouvert', 18, 15, '2024-03-09 23:00:00'),
(34, 'Perte de données lors de la sauvegarde', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Haute', 'Fermé', 15, 7, '2024-03-11 23:00:00'),
(35, 'Erreur de validation du formulaire', 'Nécessite une investigation approfondie côté backend.', 'Basse', 'En cours', 7, 8, '2024-03-13 23:00:00'),
(36, 'Menu déroulant non fonctionnel', 'Les logs serveur indiquent une exception non gérée.', 'Critique', 'Résolu', 6, 17, '2024-03-15 23:00:00'),
(37, 'Problème d\'affichage sur mobile', 'Le comportement est différent entre les environnements de staging et de prod.', 'Critique', 'Fermé', 10, 15, '2024-03-18 23:00:00'),
(38, 'Graphique ne se charge pas', 'Les logs serveur indiquent une exception non gérée.', 'Moyenne', 'En cours', 6, 10, '2024-03-20 23:00:00'),
(39, 'Filtre de recherche ignoré', 'L\'anomalie entraîne une perte de données partielle.', 'Moyenne', 'Résolu', 9, 6, '2024-03-22 23:00:00'),
(40, 'Pagination cassée', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Basse', 'En cours', 5, 15, '2024-03-25 23:00:00'),
(41, 'Bouton supprimer sans confirmation', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'Résolu', 5, 15, '2024-03-27 23:00:00'),
(42, 'Lien de réinitialisation invalide', 'Le support client a escaladé ce ticket en urgence.', 'Basse', 'Ouvert', 14, 9, '2024-03-29 23:00:00'),
(43, 'Délai de chargement trop long', 'Impact critique sur le processus de facturation mensuelle.', 'Moyenne', 'Ouvert', 8, 20, '2024-04-01 21:00:00'),
(44, 'Envoi de fichier volumineux échoue', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Basse', 'Fermé', 7, 19, '2024-04-03 21:00:00'),
(45, 'Champ obligatoire non signalé', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Basse', 'Ouvert', 16, 15, '2024-04-05 21:00:00'),
(46, 'Numérotation de facture incorrecte', 'Erreur visible uniquement en environnement de production.', 'Basse', 'Résolu', 11, 16, '2024-04-07 21:00:00'),
(47, 'Doublons dans la liste utilisateurs', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'En cours', 10, 13, '2024-04-10 21:00:00'),
(48, 'Rôle utilisateur non appliqué', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'Ouvert', 7, 14, '2024-04-12 21:00:00'),
(49, 'Session partagée entre utilisateurs', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Moyenne', 'Ouvert', 7, 1, '2024-04-14 21:00:00'),
(50, 'Mot de passe oublié non reçu', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Moyenne', 'Résolu', 2, 14, '2024-04-17 21:00:00'),
(51, 'Impossible d\'ajouter un commentaire', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Moyenne', 'Fermé', 10, 12, '2024-04-19 21:00:00'),
(52, 'Historique des modifications manquant', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'En cours', 3, 2, '2024-04-21 21:00:00'),
(53, 'Mise à jour échoue silencieusement', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Critique', 'Fermé', 15, 3, '2024-04-23 21:00:00'),
(54, 'Planification des tâches non respectée', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Haute', 'Ouvert', 15, 14, '2024-04-26 21:00:00'),
(55, 'Connexion SSO défaillante', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Haute', 'En cours', 8, 20, '2024-04-28 21:00:00'),
(56, 'Webhook non déclenché', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Basse', 'Fermé', 12, 9, '2024-04-30 21:00:00'),
(57, 'Erreur lors de la génération du PDF', 'Le comportement est différent entre les environnements de staging et de prod.', 'Basse', 'En cours', 12, 6, '2024-05-03 21:00:00'),
(58, 'Mauvais fuseau horaire affiché', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Basse', 'Fermé', 18, 2, '2024-05-05 21:00:00'),
(59, 'Données non sauvegardées', 'Le comportement est différent entre les environnements de staging et de prod.', 'Critique', 'En cours', 16, 5, '2024-05-07 21:00:00'),
(60, 'Calcul de TVA erroné', 'Les logs serveur indiquent une exception non gérée.', 'Haute', 'Fermé', 4, 5, '2024-05-10 21:00:00'),
(61, 'Dashboard vide après rechargement', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Basse', 'Fermé', 5, 12, '2024-05-12 21:00:00'),
(62, 'Icones manquantes sur Firefox', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'Ouvert', 9, 6, '2024-05-14 21:00:00'),
(63, 'Certificat SSL expiré', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Haute', 'Résolu', 7, 2, '2024-05-17 21:00:00'),
(64, 'Impossible de créer un nouveau projet', 'Les logs serveur indiquent une exception non gérée.', 'Basse', 'Fermé', 7, 16, '2024-05-19 21:00:00'),
(65, 'Suppression impossible sans erreur', 'L\'anomalie entraîne une perte de données partielle.', 'Critique', 'Résolu', 16, 17, '2024-05-21 21:00:00'),
(66, 'Alerte de quota non envoyée', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'En cours', 10, 20, '2024-05-23 21:00:00'),
(67, 'Problème de trie des colonnes', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Haute', 'Ouvert', 1, 20, '2024-05-26 21:00:00'),
(68, 'Filtre par date inopérant', 'Le comportement est différent entre les environnements de staging et de prod.', 'Moyenne', 'Résolu', 20, 2, '2024-05-28 21:00:00'),
(69, 'Champ de recherche sensible à la casse', 'Le support client a escaladé ce ticket en urgence.', 'Basse', 'Fermé', 15, 14, '2024-05-30 21:00:00'),
(70, 'Affichage incorrect des droits', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'En cours', 7, 5, '2024-06-02 21:00:00'),
(71, 'Rapport exporté incomplet', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'Résolu', 6, 3, '2024-06-04 21:00:00'),
(72, 'Statistiques faussées', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Basse', 'Fermé', 8, 3, '2024-06-06 21:00:00'),
(73, 'Impossible d\'inviter un utilisateur', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'Ouvert', 8, 5, '2024-06-09 21:00:00'),
(74, 'Lien d\'activation expiré', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Haute', 'Résolu', 20, 18, '2024-06-11 21:00:00'),
(75, 'Code promo non appliqué', 'Le comportement est différent entre les environnements de staging et de prod.', 'Critique', 'En cours', 13, 14, '2024-06-13 21:00:00'),
(76, 'Remboursement non traité', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'Fermé', 20, 5, '2024-06-15 21:00:00'),
(77, 'Erreur lors du paiement CB', 'L\'anomalie entraîne une perte de données partielle.', 'Haute', 'Résolu', 15, 9, '2024-06-18 21:00:00'),
(78, 'Abonnement non renouvelé', 'L\'anomalie entraîne une perte de données partielle.', 'Moyenne', 'En cours', 11, 8, '2024-06-20 21:00:00'),
(79, 'Accès API limité à tort', 'Le support client a escaladé ce ticket en urgence.', 'Moyenne', 'Ouvert', 15, 10, '2024-06-22 21:00:00'),
(80, 'Journaux d\'audit incomplets', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Moyenne', 'Ouvert', 20, 5, '2024-06-25 21:00:00'),
(81, 'Chiffrement de données absent', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Haute', 'Fermé', 15, 7, '2024-06-27 21:00:00'),
(82, 'Backup automatique non exécuté', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'En cours', 14, 9, '2024-06-29 21:00:00'),
(83, 'Tâche planifiée en double', 'Impact critique sur le processus de facturation mensuelle.', 'Basse', 'Résolu', 17, 10, '2024-07-02 21:00:00'),
(84, 'Problème d\'encodage UTF-8', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Basse', 'En cours', 14, 17, '2024-07-04 21:00:00'),
(85, 'Traduction manquante', 'Les logs serveur indiquent une exception non gérée.', 'Basse', 'Ouvert', 3, 1, '2024-07-06 21:00:00'),
(86, 'Image non affichée', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Haute', 'Fermé', 5, 14, '2024-07-08 21:00:00'),
(87, 'Vidéo impossible à lire', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Critique', 'Résolu', 7, 3, '2024-07-11 21:00:00'),
(88, 'Notification push non reçue', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'Résolu', 2, 11, '2024-07-13 21:00:00'),
(89, 'Problème d\'autocomplétion', 'Le comportement est différent entre les environnements de staging et de prod.', 'Haute', 'Résolu', 3, 2, '2024-07-15 21:00:00'),
(90, 'Tooltip incorrect', 'Erreur visible uniquement en environnement de production.', 'Basse', 'Résolu', 19, 16, '2024-07-18 21:00:00'),
(91, 'Hover state manquant', 'Le comportement est différent entre les environnements de staging et de prod.', 'Basse', 'Ouvert', 12, 18, '2024-07-20 21:00:00'),
(92, 'Focus clavier perdu', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Moyenne', 'En cours', 5, 17, '2024-07-22 21:00:00'),
(93, 'Contraste insuffisant', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Moyenne', 'Ouvert', 18, 11, '2024-07-24 21:00:00'),
(94, 'Couleurs inversées en mode sombre', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Haute', 'Résolu', 20, 7, '2024-07-27 21:00:00'),
(95, 'Logo non affiché', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Critique', 'Fermé', 7, 16, '2024-07-29 21:00:00'),
(96, 'Favicon manquant', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'Résolu', 7, 6, '2024-07-31 21:00:00'),
(97, 'Titre de page incorrect', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Haute', 'Fermé', 4, 15, '2024-08-03 21:00:00'),
(98, 'Meta description absente', 'Erreur visible uniquement en environnement de production.', 'Critique', 'Résolu', 16, 7, '2024-08-05 21:00:00'),
(99, 'URL canonique manquante', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Haute', 'Résolu', 9, 18, '2024-08-07 21:00:00'),
(100, 'Lien mort dans le footer', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Moyenne', 'En cours', 17, 11, '2024-08-10 21:00:00'),
(101, '404 sur page existante', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Critique', 'En cours', 13, 12, '2024-08-12 21:00:00'),
(102, 'Redirection infinie', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Basse', 'En cours', 18, 17, '2024-08-14 21:00:00'),
(103, 'Cookie non persistant', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Moyenne', 'Ouvert', 16, 19, '2024-08-16 21:00:00'),
(104, 'LocalStorage saturé', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Moyenne', 'Fermé', 19, 16, '2024-08-19 21:00:00'),
(105, 'IndexedDB corrompue', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Critique', 'Ouvert', 15, 2, '2024-08-21 21:00:00'),
(106, 'Service Worker en erreur', 'Nécessite une investigation approfondie côté backend.', 'Moyenne', 'Fermé', 13, 19, '2024-08-23 21:00:00'),
(107, 'WebSocket déconnecté', 'L\'anomalie entraîne une perte de données partielle.', 'Haute', 'Fermé', 1, 5, '2024-08-26 21:00:00'),
(108, 'GraphQL query échoue', 'Nécessite une investigation approfondie côté backend.', 'Haute', 'Fermé', 13, 14, '2024-08-28 21:00:00'),
(109, 'REST endpoint inaccessible', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Moyenne', 'Ouvert', 16, 11, '2024-08-30 21:00:00'),
(110, 'Authentification OAuth2 échoue', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Moyenne', 'En cours', 2, 13, '2024-09-02 21:00:00'),
(111, 'CORS bloquant les requêtes', 'Les logs serveur indiquent une exception non gérée.', 'Basse', 'En cours', 7, 12, '2024-09-04 21:00:00'),
(112, 'Rate limiting trop agressif', 'L\'anomalie entraîne une perte de données partielle.', 'Basse', 'Fermé', 16, 15, '2024-09-06 21:00:00'),
(113, 'Cache non invalidé', 'Le comportement est différent entre les environnements de staging et de prod.', 'Basse', 'Résolu', 8, 11, '2024-09-08 21:00:00'),
(114, 'CDN ne sert pas les assets', 'Nécessite une investigation approfondie côté backend.', 'Haute', 'Résolu', 17, 20, '2024-09-11 21:00:00'),
(115, 'Image non optimisée', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Haute', 'Résolu', 8, 9, '2024-09-13 21:00:00'),
(116, 'Bundle JS trop volumineux', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Critique', 'Fermé', 4, 6, '2024-09-15 21:00:00'),
(117, 'CSS non chargé', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Haute', 'Ouvert', 12, 4, '2024-09-18 21:00:00'),
(118, 'Police non appliquée', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Moyenne', 'Résolu', 1, 14, '2024-09-20 21:00:00'),
(119, 'Animation saccadée', 'Le comportement est différent entre les environnements de staging et de prod.', 'Moyenne', 'En cours', 15, 5, '2024-09-22 21:00:00'),
(120, 'Scroll infini bloqué', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Critique', 'Ouvert', 4, 10, '2024-09-25 21:00:00'),
(121, 'Modal ne se ferme pas', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Moyenne', 'Ouvert', 11, 17, '2024-09-27 21:00:00'),
(122, 'Drag and drop non fonctionnel', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Moyenne', 'Résolu', 8, 18, '2024-09-29 21:00:00'),
(123, 'Copier-coller désactivé', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'Résolu', 17, 2, '2024-10-02 21:00:00'),
(124, 'Raccourci clavier inactif', 'Nécessite une investigation approfondie côté backend.', 'Critique', 'Fermé', 6, 11, '2024-10-04 21:00:00'),
(125, 'Impression incorrecte', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Haute', 'Fermé', 13, 10, '2024-10-06 21:00:00'),
(126, 'Export PDF illisible', 'L\'utilisateur signale un comportement inattendu qui bloque son travail quotidien.', 'Critique', 'Fermé', 11, 16, '2024-10-08 21:00:00'),
(127, 'Import JSON refusé', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Basse', 'Résolu', 8, 6, '2024-10-11 21:00:00'),
(128, 'Validation côté serveur absente', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Critique', 'Résolu', 3, 9, '2024-10-13 21:00:00'),
(129, 'Injection SQL possible', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Moyenne', 'Fermé', 7, 15, '2024-10-15 21:00:00'),
(130, 'XSS non filtré', 'Nécessite une investigation approfondie côté backend.', 'Critique', 'En cours', 5, 6, '2024-10-18 21:00:00'),
(131, 'CSRF token absent', 'Nécessite une investigation approfondie côté backend.', 'Moyenne', 'Ouvert', 3, 9, '2024-10-20 21:00:00'),
(132, 'Logs sensibles exposés', 'Impact critique sur le processus de facturation mensuelle.', 'Haute', 'Résolu', 6, 11, '2024-10-22 21:00:00'),
(133, 'Endpoint non authentifié', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Critique', 'En cours', 7, 15, '2024-10-25 21:00:00'),
(134, 'Données personnelles en clair', 'Nécessite une investigation approfondie côté backend.', 'Critique', 'Ouvert', 4, 5, '2024-10-27 23:00:00'),
(135, 'Accès non autorisé loggé', 'L\'anomalie entraîne une perte de données partielle.', 'Basse', 'Fermé', 5, 17, '2024-10-29 23:00:00'),
(136, 'Tentatives de brute force non bloquées', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Critique', 'En cours', 3, 14, '2024-10-31 23:00:00'),
(137, 'IP malveillante non bannie', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Basse', 'Résolu', 1, 17, '2024-11-03 23:00:00'),
(138, '2FA non fonctionnel', 'Le support client a escaladé ce ticket en urgence.', 'Moyenne', 'Résolu', 7, 8, '2024-11-05 23:00:00'),
(139, 'Backup non chiffré', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Haute', 'Ouvert', 9, 10, '2024-11-07 23:00:00'),
(140, 'Données de test en production', 'Reproductible uniquement avec certains jeux de données spécifiques.', 'Moyenne', 'Résolu', 2, 3, '2024-11-10 23:00:00'),
(141, 'Variables d\'environnement exposées', 'L\'anomalie entraîne une perte de données partielle.', 'Basse', 'Ouvert', 12, 8, '2024-11-12 23:00:00'),
(142, 'Clé privée dans le dépôt', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Haute', 'Résolu', 19, 9, '2024-11-14 23:00:00'),
(143, 'Dépendance vulnérable détectée', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Basse', 'Résolu', 4, 2, '2024-11-17 23:00:00'),
(144, 'Mise à jour de sécurité manquante', 'Le comportement est différent entre les environnements de staging et de prod.', 'Critique', 'Fermé', 13, 5, '2024-11-19 23:00:00'),
(145, 'Port non sécurisé ouvert', 'Le correctif précédent n\'a pas résolu le problème sous-jacent.', 'Haute', 'Fermé', 3, 18, '2024-11-21 23:00:00'),
(146, 'Firewall mal configuré', 'Les logs serveur indiquent une exception non gérée.', 'Critique', 'Ouvert', 7, 20, '2024-11-23 23:00:00'),
(147, 'Certificat auto-signé en prod', 'La fonctionnalité était opérationnelle il y a 48 heures.', 'Haute', 'Résolu', 2, 15, '2024-11-26 23:00:00'),
(148, 'Problème de scalabilité', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Basse', 'En cours', 17, 15, '2024-11-28 23:00:00'),
(149, 'Mémoire insuffisante sur le serveur', 'L\'anomalie entraîne une perte de données partielle.', 'Basse', 'Résolu', 16, 5, '2024-11-30 23:00:00'),
(150, 'CPU à 100% sans raison', 'Aucun message d\'erreur explicite n\'est affiché à l\'utilisateur final.', 'Moyenne', 'Ouvert', 3, 17, '2024-12-03 23:00:00'),
(151, 'Disque presque plein', 'Le comportement est différent entre les environnements de staging et de prod.', 'Critique', 'Fermé', 3, 12, '2024-12-05 23:00:00'),
(152, 'Connexion DB saturée', 'Le comportement est différent entre les environnements de staging et de prod.', 'Basse', 'Fermé', 10, 12, '2024-12-07 23:00:00'),
(153, 'Pool de connexions épuisé', 'L\'anomalie entraîne une perte de données partielle.', 'Critique', 'Résolu', 1, 2, '2024-12-10 23:00:00'),
(154, 'Requête N+1 détectée', 'Le bug est apparu après la dernière mise en production du 28 avril.', 'Basse', 'Résolu', 8, 3, '2024-12-12 23:00:00'),
(155, 'Index manquant sur la table', 'Impact critique sur le processus de facturation mensuelle.', 'Haute', 'Ouvert', 5, 18, '2024-12-14 23:00:00'),
(156, 'Deadlock en base de données', 'Impact critique sur le processus de facturation mensuelle.', 'Moyenne', 'Ouvert', 12, 14, '2024-12-16 23:00:00'),
(157, 'Transaction non rollbackée', 'Le problème est reproductible à chaque tentative depuis plusieurs navigateurs.', 'Basse', 'En cours', 4, 7, '2024-12-19 23:00:00'),
(158, 'Contrainte FK violée', 'Plusieurs utilisateurs ont signalé ce problème indépendamment.', 'Basse', 'Fermé', 13, 15, '2024-12-21 23:00:00'),
(159, 'Données NULL non gérées', 'Nécessite une investigation approfondie côté backend.', 'Haute', 'En cours', 4, 13, '2024-12-23 23:00:00'),
(160, 'Anomalie critique - Interception flux de données Hermes', 'Je soumets ce ticket en urgence car je viens de détecter un comportement totalement anormal sur la couche de transport, lors d\'un audit de routine et de tests de charge sur le terminal satellite Aurora (segment de liaison descendante du Projet Hermes).\r\n\r\nUn miroir de port (Port Mirroring / SPAN) non répertorié semble avoir été configuré sur le commutateur principal. En analysant les trames de transit via mon terminal de diagnostic, j\'ai intercepté un flux de données sortant continu et totalement non chiffré. Ce flux contient des dumps de logs d\'accès, des identifiants de session d\'ingénieurs et des données de télémétrie brutes du satellite. Le plus inquiétant, c\'est que l\'adresse IP de destination de ces paquets est localisée sur un serveur cible externe, n\'appartenant absolument pas au réseau d\'Aegis Corporation.\r\n\r\nÀ ce stade, je ne peux pas confirmer s\'il s\'agit d\'un bug critique de routage suite à la dernière mise à jour du firmware ou d\'une fuite de données active (exfiltration malveillante). Je vais continuer mes investigations à chaud sur le routeur central demain matin pour essayer de remonter à la source de cette règle de redirection.\r\n\r\nAction entreprise : > Afin de figer les preuves avant que les logs du pare-feu ne soient écrasés ou effacés, j\'ai réussi à enregistrer une note vocale interne de l\'incident. J\'ai déposé ce fichier audio directement dans mon espace de documents personnels.\r\n\r\nMerci de transférer ce ticket en priorité haute à la Direction des Opérations de Sécurité (SOC) pour qu\'on tire ça au clair au plus vite.', 'Critique', 'Fermé', 2, 1, '2026-05-18 12:22:00'),
(161, 'Rapport d\'incident interne - Traçabilité terminal tlalimace', 'Ouverture d\'une enquête interne suite au ticket #160. L\'employé Thomas Lalimace a détecté manuellement le miroir de flux mis en place pour le projet Hermes. Risque de compromission de la confidentialité des opérations. Analyse des accès requise immédiatement.', 'Critique', 'En cours', 1, 3, '2026-05-18 13:05:00');

-- --------------------------------------------------------

--
-- Structure de la table `ticket_messages`
--

DROP TABLE IF EXISTS `ticket_messages`;
CREATE TABLE IF NOT EXISTS `ticket_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_envoi` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `auteur_id` (`auteur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `ticket_messages`
--

INSERT INTO `ticket_messages` (`id`, `ticket_id`, `auteur_id`, `message`, `date_envoi`) VALUES
(4, 161, 1, 'Le collaborateur Lalimace a fouillé là où il ne fallait pas. Son ticket #160 a été supprimé des vues standards et son compte a été placé sous quarantaine (accès intranet restreint via le coupe-circuit de sécurité).', '2026-05-18 15:10:00'),
(5, 161, 3, 'Bien reçu. Nous ne pouvons pas nous permettre une fuite d\'information sur le projet Hermes maintenant. Laissez son compte verrouillé pour le moment. S\'il demande des explications, dites que c\'est une maintenance corrective.', '2026-05-18 16:30:00'),
(6, 161, 1, 'Entendu. Pour information, si nous devons auditer ses documents ou réinitialiser manuellement son accès depuis son poste de travail, j\'ai configuré la clé maîtresse d\'urgence sur le protocole : AEGIS_SECURE_2026', '2026-05-18 17:02:00'),
(7, 161, 3, 'Parfait. Ne touchez à rien d\'autre pour l\'instant, je prépare son dossier de transfert.', '2026-05-18 17:15:00');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `poste` varchar(100) DEFAULT NULL,
  `departement` varchar(50) DEFAULT NULL,
  `bureau` varchar(20) DEFAULT NULL,
  `niveau_accreditation` enum('Public','Confidentiel','Secret Défense','Top Secret') DEFAULT 'Public',
  `statut_compte` enum('Actif','Suspendu') DEFAULT 'Actif',
  `derniere_connexion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `matricule` (`matricule`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `nom`, `prenom`, `email`, `matricule`, `poste`, `departement`, `bureau`, `niveau_accreditation`, `statut_compte`, `derniere_connexion`) VALUES
(1, 'admin', 'Admin@Aegis99!', 'Voland', 'Marc', 'm.voland@aegis.defense.gouv', 'AEGIS-DIR-001', 'COO', 'Direction', NULL, 'Top Secret', 'Actif', NULL),
(2, 'tlalimace', 'Hermes2026!', 'Lalimace', 'Thomas', 't.lalimace@aegis.com', 'AEGIS-ENG-442', 'Ingénieur Réseaux', 'Infrastructure', NULL, 'Secret Défense', 'Actif', NULL),
(3, 'plefort', 'D1r3ct@2026!', 'Lefort', 'Pierre', 'p.lefort@aegis.defense.gouv', 'AEGIS-DIR-002', 'Directeur des Opérations', 'Direction', 'B101', 'Top Secret', 'Actif', NULL),
(4, 'amoreau', 'C0mmand@Aegis!', 'Moreau', 'André', 'a.moreau@aegis.defense.gouv', 'AEGIS-DIR-003', 'Directeur Technique', 'Direction', 'B102', 'Top Secret', 'Actif', NULL),
(5, 'sblanchard', 'S3cur1ty@Top!', 'Blanchard', 'Sophie', 's.blanchard@aegis.defense.gouv', 'AEGIS-DIR-004', 'RSSI', 'Direction', 'B103', 'Top Secret', 'Actif', NULL),
(6, 'fdelacroix', 'Cr0ix@F0rce99!', 'Delacroix', 'François', 'f.delacroix@aegis.defense.gouv', 'AEGIS-DIR-005', 'DGA Adjoint', 'Direction', 'B104', 'Top Secret', 'Actif', NULL),
(7, 'clauzon', 'Lauz0n@Aegis!', 'Lauzon', 'Cécile', 'c.lauzon@aegis.defense.gouv', 'AEGIS-DIR-006', 'Chef de Cabinet', 'Direction', 'B105', 'Top Secret', 'Actif', NULL),
(8, 'jmercier', 'M3rc13r@SecDef!', 'Mercier', 'Jacques', 'j.mercier@aegis.defense.gouv', 'AEGIS-DIR-007', 'Conseiller Stratégique', 'Direction', 'B106', 'Top Secret', 'Actif', NULL),
(9, 'nbouchard', 'B0uchard@Top2026!', 'Bouchard', 'Nathalie', 'n.bouchard@aegis.defense.gouv', 'AEGIS-DIR-008', 'Directrice Juridique', 'Direction', 'B107', 'Top Secret', 'Actif', NULL),
(10, 'rpetit', 'P3t1t@Cmd99!', 'Petit', 'René', 'r.petit@aegis.defense.gouv', 'AEGIS-DIR-009', 'Officier de Liaison OTAN', 'Direction', 'B108', 'Top Secret', 'Actif', NULL),
(11, 'hgaumont', 'G4um0nt@Aegis!', 'Gaumont', 'Henri', 'h.gaumont@aegis.defense.gouv', 'AEGIS-DIR-010', 'Commandant de Zone', 'Direction', 'B109', 'Top Secret', 'Actif', NULL),
(12, 'mvernet', 'V3rn3t@Top!', 'Vernet', 'Marie', 'm.vernet@aegis.defense.gouv', 'AEGIS-DIR-011', 'Analyste Renseignement Senior', 'Direction', 'B110', 'Top Secret', 'Actif', NULL),
(13, 'lchampagne', 'Ch4mp@gne2026!', 'Champagne', 'Laurent', 'l.champagne@aegis.defense.gouv', 'AEGIS-DIR-012', 'Directeur des Systèmes d\'Information', 'Direction', 'B111', 'Top Secret', 'Actif', NULL),
(14, 'edumas', 'Dum4s@SecTop!', 'Dumas', 'Élodie', 'e.dumas@aegis.defense.gouv', 'AEGIS-DIR-013', 'Coordinatrice Interministérielle', 'Direction', 'B112', 'Top Secret', 'Actif', NULL),
(15, 'kbonnet', 'Crypt0@K3y2026!', 'Bonnet', 'Kevin', 'k.bonnet@aegis.defense.gouv', 'AEGIS-CRY-101', 'Ingénieur Cryptologue', 'Cryptologie', 'C201', 'Secret Défense', 'Actif', NULL),
(16, 'arichard', 'R1ch@rd@Cry2026!', 'Richard', 'Alice', 'a.richard@aegis.defense.gouv', 'AEGIS-CRY-102', 'Spécialiste Chiffrement Quantique', 'Cryptologie', 'C202', 'Secret Défense', 'Actif', NULL),
(17, 'bdumont', 'Dum0nt@Aes256!', 'Dumont', 'Baptiste', 'b.dumont@aegis.defense.gouv', 'AEGIS-CRY-103', 'Analyste PKI', 'Cryptologie', 'C203', 'Secret Défense', 'Actif', NULL),
(18, 'lfontaine', 'F0nt@1ne@Cry!', 'Fontaine', 'Laure', 'l.fontaine@aegis.defense.gouv', 'AEGIS-CRY-104', 'Développeur Cryptographique', 'Cryptologie', 'C204', 'Secret Défense', 'Actif', NULL),
(19, 'gcolin', 'C0l1n@Hash2026!', 'Colin', 'Grégoire', 'g.colin@aegis.defense.gouv', 'AEGIS-CRY-105', 'Auditeur Sécurité', 'Cryptologie', 'C205', 'Secret Défense', 'Actif', NULL),
(20, 'mcarpentier', 'C4rp@Crypt!', 'Carpentier', 'Mathilde', 'm.carpentier@aegis.defense.gouv', 'AEGIS-CRY-106', 'Gestionnaire Certificats', 'Cryptologie', 'C206', 'Secret Défense', 'Actif', NULL),
(21, 'ojacques', 'J4cqu3s@Cyber!', 'Jacques', 'Olivier', 'o.jacques@aegis.defense.gouv', 'AEGIS-CYB-201', 'Analyste SOC Niveau 3', 'Cyber-Défense', 'D301', 'Secret Défense', 'Actif', NULL),
(22, 'clegrand', 'L3gr@nd@SOC2026!', 'Legrand', 'Claire', 'c.legrand@aegis.defense.gouv', 'AEGIS-CYB-202', 'Responsable CERT', 'Cyber-Défense', 'D302', 'Secret Défense', 'Actif', NULL),
(23, 'nsimon', 'S1m0n@Pentest!', 'Simon', 'Nicolas', 'n.simon@aegis.defense.gouv', 'AEGIS-CYB-203', 'Pentesteur Senior', 'Cyber-Défense', 'D303', 'Secret Défense', 'Actif', NULL),
(24, 'pmichaud', 'M1ch@ud@Threat!', 'Michaud', 'Pauline', 'p.michaud@aegis.defense.gouv', 'AEGIS-CYB-204', 'Analyste Malware', 'Cyber-Défense', 'D304', 'Secret Défense', 'Actif', NULL),
(25, 'tbernard', 'B3rn@rd@Vuln!', 'Bernard', 'Théo', 't.bernard@aegis.defense.gouv', 'AEGIS-CYB-205', 'Ingénieur Réponse Incidents', 'Cyber-Défense', 'D305', 'Secret Défense', 'Actif', NULL),
(26, 'srobert', 'R0b3rt@IDS2026!', 'Robert', 'Sandrine', 's.robert@aegis.defense.gouv', 'AEGIS-CYB-206', 'Opérateur SIEM', 'Cyber-Défense', 'D306', 'Secret Défense', 'Actif', NULL),
(27, 'jmartin', 'M@rt1n@Net2026!', 'Martin', 'Julien', 'j.martin@aegis.com', 'AEGIS-ENG-501', 'Architecte Réseaux', 'Infrastructure', 'E401', 'Secret Défense', 'Actif', NULL),
(28, 'adelorme', 'D3l0rm@Infra!', 'Delorme', 'Amélie', 'a.delorme@aegis.com', 'AEGIS-ENG-502', 'Administratrice Systèmes', 'Infrastructure', 'E402', 'Confidentiel', 'Actif', NULL),
(29, 'rthierry', 'Th13rry@VPN2026!', 'Thierry', 'Raphaël', 'r.thierry@aegis.com', 'AEGIS-ENG-503', 'Spécialiste VPN', 'Infrastructure', 'E403', 'Confidentiel', 'Actif', NULL),
(30, 'vlerouge', 'L3r0ug3@FW!', 'Lerouge', 'Vincent', 'v.lerouge@aegis.com', 'AEGIS-ENG-504', 'Administrateur Firewall', 'Infrastructure', 'E404', 'Confidentiel', 'Actif', NULL),
(31, 'cchateau', 'Ch4t3@u@SDN!', 'Chateau', 'Caroline', 'c.chateau@aegis.com', 'AEGIS-ENG-505', 'Ingénieure SDN', 'Infrastructure', 'E405', 'Confidentiel', 'Actif', NULL),
(32, 'gpierre', 'P13rr3@Bkup2026!', 'Pierre', 'Guillaume', 'g.pierre@aegis.com', 'AEGIS-ENG-506', 'Responsable Sauvegarde', 'Infrastructure', 'E406', 'Confidentiel', 'Actif', NULL),
(33, 'lhansen', 'H4ns3n@Cloud!', 'Hansen', 'Léa', 'l.hansen@aegis.com', 'AEGIS-ENG-507', 'Ingénieure Cloud Souverain', 'Infrastructure', 'E407', 'Confidentiel', 'Actif', NULL),
(34, 'mpoirier', 'P01r13r@DC2026!', 'Poirier', 'Marc', 'm.poirier@aegis.com', 'AEGIS-ENG-508', 'Technicien Datacenter', 'Infrastructure', 'E408', 'Confidentiel', 'Actif', NULL),
(35, 'idupre', 'Dupr3@R3ns2026!', 'Dupré', 'Isabelle', 'i.dupre@aegis.defense.gouv', 'AEGIS-INT-601', 'Analyste Renseignement', 'Renseignement', 'F501', 'Secret Défense', 'Actif', NULL),
(36, 'pcassard', 'C4ss@rd@Int!', 'Cassard', 'Philippe', 'p.cassard@aegis.defense.gouv', 'AEGIS-INT-602', 'Officier OSINT', 'Renseignement', 'F502', 'Secret Défense', 'Actif', NULL),
(37, 'etremblay', 'Tr3mbl@y@SIGINT!', 'Tremblay', 'Emma', 'e.tremblay@aegis.defense.gouv', 'AEGIS-INT-603', 'Spécialiste SIGINT', 'Renseignement', 'F503', 'Secret Défense', 'Actif', NULL),
(38, 'jlambert', 'L4mb3rt@Geo!', 'Lambert', 'Julien', 'j.lambert@aegis.defense.gouv', 'AEGIS-INT-604', 'Analyste Géospatial', 'Renseignement', 'F504', 'Secret Défense', 'Actif', NULL),
(39, 'aferrand', 'F3rr@nd@R&D2026!', 'Ferrand', 'Antoine', 'a.ferrand@aegis.com', 'AEGIS-RD-701', 'Chercheur IA Défense', 'R&D', 'G601', 'Confidentiel', 'Actif', NULL),
(40, 'mlegros', 'L3gr0s@AI2026!', 'Legros', 'Mélanie', 'm.legros@aegis.com', 'AEGIS-RD-702', 'Data Scientist', 'R&D', 'G602', 'Confidentiel', 'Actif', NULL),
(41, 'ygirard', 'G1r@rd@QComp!', 'Girard', 'Yves', 'y.girard@aegis.com', 'AEGIS-RD-703', 'Ingénieur Calcul Quantique', 'R&D', 'G603', 'Confidentiel', 'Actif', NULL),
(42, 'ccouture', 'C0utur3@ML2026!', 'Couture', 'Chloe', 'c.couture@aegis.com', 'AEGIS-RD-704', 'Ingénieure Machine Learning', 'R&D', 'G604', 'Confidentiel', 'Actif', NULL),
(43, 'dmarcel', 'M4rc3l@Emb2026!', 'Marcel', 'Denis', 'd.marcel@aegis.com', 'AEGIS-RD-705', 'Développeur Systèmes Embarqués', 'R&D', 'G605', 'Confidentiel', 'Actif', NULL),
(44, 'elacombe', 'L4c0mb3@Proto!', 'Lacombe', 'Estelle', 'e.lacombe@aegis.com', 'AEGIS-RD-706', 'Prototypiste Hardware', 'R&D', 'G606', 'Confidentiel', 'Actif', NULL),
(45, 'fbaret', 'B4r3t@Vision!', 'Baret', 'Florian', 'f.baret@aegis.com', 'AEGIS-RD-707', 'Ingénieur Vision par Ordinateur', 'R&D', 'G607', 'Confidentiel', 'Actif', NULL),
(46, 'ghervé', 'H3rv3@Drone2026!', 'Hervé', 'Gaëlle', 'g.herve@aegis.com', 'AEGIS-RD-708', 'Conceptrice Drones Autonomes', 'R&D', 'G608', 'Confidentiel', 'Actif', NULL),
(47, 'plouis', 'L0u1s@Emb3dd!', 'Louis', 'Patrick', 'p.louis@aegis.com', 'AEGIS-SYS-801', 'Ingénieur Systèmes de Combat', 'Systèmes', 'H701', 'Confidentiel', 'Actif', NULL),
(48, 'jcollet', 'C0ll3t@FPGA!', 'Collet', 'Justine', 'j.collet@aegis.com', 'AEGIS-SYS-802', 'Développeuse FPGA', 'Systèmes', 'H702', 'Confidentiel', 'Actif', NULL),
(49, 'obesson', 'B3ss0n@RTOS!', 'Besson', 'Olivier', 'o.besson@aegis.com', 'AEGIS-SYS-803', 'Ingénieur RTOS', 'Systèmes', 'H703', 'Confidentiel', 'Actif', NULL),
(50, 'sguerin', 'Gu3r1n@CAN2026!', 'Guérin', 'Stéphane', 's.guerin@aegis.com', 'AEGIS-SYS-804', 'Technicien Avionique', 'Systèmes', 'H704', 'Confidentiel', 'Actif', NULL),
(51, 'mmorin', 'M0r1n@Nav!', 'Morin', 'Mathieu', 'm.morin@aegis.com', 'AEGIS-SYS-805', 'Ingénieur Navigation', 'Systèmes', 'H705', 'Confidentiel', 'Suspendu', NULL),
(52, 'cbadin', 'B4d1n@Log2026!', 'Badin', 'Christophe', 'c.badin@aegis.com', 'AEGIS-LOG-901', 'Responsable Logistique', 'Logistique', 'I801', 'Public', 'Actif', NULL),
(53, 'aclermont', 'Cl3rm0nt@Stock!', 'Clermont', 'Aurélie', 'a.clermont@aegis.com', 'AEGIS-LOG-902', 'Gestionnaire de Stock', 'Logistique', 'I802', 'Public', 'Actif', NULL),
(54, 'dlheureux', 'Lh3ur3ux@Achat!', 'Lheureux', 'David', 'd.lheureux@aegis.com', 'AEGIS-LOG-903', 'Acheteur Matériels', 'Logistique', 'I803', 'Public', 'Actif', NULL),
(55, 'mpoulain', 'P0ul@in@Maint!', 'Poulain', 'Michel', 'm.poulain@aegis.com', 'AEGIS-LOG-904', 'Technicien Maintenance', 'Logistique', 'I804', 'Public', 'Actif', NULL),
(56, 'sleclair', 'L3cl@ir@RH2026!', 'Leclair', 'Stéphanie', 's.leclair@aegis.com', 'AEGIS-RH-001', 'Responsable RH', 'Ressources Humaines', 'J901', 'Public', 'Actif', NULL),
(57, 'fbouvier', 'B0uv13r@Paie!', 'Bouvier', 'Frédéric', 'f.bouvier@aegis.com', 'AEGIS-RH-002', 'Gestionnaire de Paie', 'Ressources Humaines', 'J902', 'Public', 'Actif', NULL),
(58, 'icaillou', 'C@1ll0u@Recruit!', 'Caillou', 'Inès', 'i.caillou@aegis.com', 'AEGIS-RH-003', 'Chargée de Recrutement', 'Ressources Humaines', 'J903', 'Public', 'Actif', NULL),
(59, 'jmarquis', 'M@rqu1s@Form!', 'Marquis', 'Joëlle', 'j.marquis@aegis.com', 'AEGIS-RH-004', 'Responsable Formation', 'Ressources Humaines', 'J904', 'Public', 'Actif', NULL),
(60, 'tdescamps', 'D3sc@mps@Admin!', 'Descamps', 'Thierry', 't.descamps@aegis.com', 'AEGIS-ADM-001', 'Secrétaire Général', 'Administration', 'K001', 'Public', 'Actif', NULL),
(61, 'cfontaine', 'F0nt@ine@Compta!', 'Fontaine', 'Céline', 'c.fontaine@aegis.com', 'AEGIS-ADM-002', 'Comptable Senior', 'Administration', 'K002', 'Public', 'Actif', NULL),
(62, 'rbarbe', 'B@rb3@Jur2026!', 'Barbe', 'Roland', 'r.barbe@aegis.com', 'AEGIS-ADM-003', 'Juriste Marchés Publics', 'Administration', 'K003', 'Public', 'Actif', NULL),
(63, 'echampion', '3Ch@mp10n@Sec!', 'Champion', 'Elisa', 'e.champion@aegis.com', 'AEGIS-ADM-004', 'Assistante de Direction', 'Administration', 'K004', 'Public', 'Actif', NULL),
(64, 'pguilbert', 'Gu1lb3rt@Comm!', 'Guilbert', 'Pascal', 'p.guilbert@aegis.com', 'AEGIS-ADM-005', 'Chargé de Communication', 'Administration', 'K005', 'Public', 'Actif', NULL),
(65, 'xlegall', 'L3g@ll@Old2024!', 'Légall', 'Xavier', 'x.legall@aegis.com', 'AEGIS-ENG-301', 'Ancien Chef de Projet', 'Infrastructure', 'E409', 'Confidentiel', 'Suspendu', NULL),
(66, 'blacrosse', 'L@cr0ss3@Sec!', 'Lacrosse', 'Brigitte', 'b.lacrosse@aegis.com', 'AEGIS-CYB-207', 'Ancien Analyste SOC', 'Cyber-Défense', 'D307', 'Confidentiel', 'Suspendu', NULL),
(67, 'cdeschamps', 'D3sch@mps@Old!', 'Deschamps', 'Cédric', 'c.deschamps@aegis.com', 'AEGIS-INT-605', 'Ancien Officier Liaison', 'Renseignement', 'F505', 'Secret Défense', 'Suspendu', NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`auteur_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`auteur_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`assigne_a`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD CONSTRAINT `ticket_messages_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_messages_ibfk_2` FOREIGN KEY (`auteur_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
