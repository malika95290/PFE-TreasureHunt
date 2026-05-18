<?php
session_start();
require_once 'db_config.php';

// Sécurité : redirection si non connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_nom = $_SESSION['prenom'] . " " . $_SESSION['nom'];
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AEGIS CORE - Dashboard</title>
    <style>
        :root {
            --aegis-blue: #003366; /* Bleu profond type Thales/Défense */
            --aegis-light-blue: #0056b3;
            --text-main: #333333;
            --bg-content: #f8f9fa;
            
            /* Teintes bleues pour les icônes d'outils */
            --tool-blue-dark: #002244;
            --tool-blue-medium: #0056b3;
            --tool-blue-light: #4a90e2;
        }

        body {
            margin: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-content);
        }

        /* --- BARRE DE NAVIGATION SUPÉRIEURE --- */
        .top-navbar {
            height: 60px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            z-index: 100;
            flex-shrink: 0;
        }

        .navbar-brand {
            font-size: 1.4rem;
            font-weight: bold;
            color: var(--aegis-blue);
            letter-spacing: 0.5px;
        }

        .top-nav-links {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .top-nav-links li a {
            display: block;
            padding: 8px 16px;
            color: #555555;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .top-nav-links li a:hover {
            background-color: #f0f4f8;
            color: var(--aegis-light-blue);
        }

        .top-nav-links li a.active {
            background-color: #e6effa;
            color: var(--aegis-blue);
            font-weight: 600;
        }

        .top-logout-btn {
            margin-left: 15px;
            padding: 8px 16px;
            background-color: #fff0f0;
            color: #d9534f;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .top-logout-btn:hover {
            background-color: #d9534f;
            color: white;
        }

        /* --- CONTENEUR GLOBAL (Rendu scrollable pour inclure le footer) --- */
        .main-container {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            overflow-y: auto; /* Le défilement global se fait ici désormais */
        }

        /* --- Bannière d'En-tête Intranet --- */
        .intranet-header {
            width: 100%;
            background-color: var(--aegis-blue);
            background-image: url('./assets/img/hex-pattern.png');
            background-repeat: repeat;
            background-position: center;
            color: white;
            padding: 25px 0;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            position: relative;
            overflow: hidden;
            flex-shrink: 0;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 40px;
            display: flex;
            align-items: center;
            position: relative;
        }

        .header-people {
            display: flex;
            align-items: flex-end;
            position: absolute;
            bottom: -25px;
            left: 40px;
            height: calc(100% + 25px);
        }

        .employee-img {
            height: 100%;
            object-fit: contain;
        }

        .woman-yellow {
            margin-right: -15px;
            position: relative;
            z-index: 1;
        }

        .man-helmet {
            position: relative;
            z-index: 2;
        }

        .header-content-center {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            padding-left: 320px; /* Laisse de l'espace pour les images d'employés */
        }

        .welcome-title {
            font-size: 2rem;
            font-weight: bold;
            margin: 0 0 5px 0;
        }

        .welcome-subtitle {
            font-size: 1rem;
            font-weight: 300;
            margin: 0 0 15px 0;
            color: rgba(255,255,255,0.9);
        }

        /* --- Zone de Contenu Interne --- */
        .main-content {
            padding: 40px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-top: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 10px;
        }

        /* --- Alignement Côte à Côte : Événements & Outils --- */
        .dashboard-row {
            display: flex;
            gap: 30px;
            margin-bottom: 20px;
        }

        .events-column {
            flex: 1;
        }

        .tools-column {
            flex: 1;
        }

        /* --- Conteneurs Communs Blancs --- */
        .events-container, .tools-container {
            background: #ffffff;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            min-height: 290px;
        }

        .events-container {
            display: flex;
            gap: 25px;
        }

        /* --- Module Événements --- */
        .calendar-wrapper {
            flex: 1.1;
            max-width: 280px;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            color: var(--aegis-blue);
            margin-bottom: 15px;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 6px;
            text-align: center;
            font-size: 0.85rem;
        }

        .day-name {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.75rem;
            margin-bottom: 5px;
        }

        .day-num {
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: #495057;
        }

        .day-num.muted {
            color: #ced4da;
        }

        .day-num.event-dot {
            background-color: var(--aegis-blue);
            color: #ffffff;
            font-weight: bold;
        }

        .day-num.today {
            border: 2px solid var(--aegis-light-blue);
            font-weight: bold;
        }

        .events-list-wrapper {
            flex: 1.4;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .events-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .event-card {
            background: #ffffff;
            border: 1px solid #e9ecef;
            border-left: 5px solid var(--aegis-blue);
            border-radius: 8px;
            padding: 10px 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        }

        .event-card-title {
            font-weight: bold;
            font-size: 0.9rem;
            margin: 0 0 5px 0;
            color: #212529;
        }

        .event-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            font-size: 0.78rem;
            color: #6c757d;
        }

        .see-all-link {
            text-align: right;
            margin-top: 10px;
        }

        .see-all-link a {
            color: var(--aegis-light-blue);
            text-decoration: none;
            font-weight: bold;
            font-size: 0.85rem;
        }

        .see-all-link a:hover {
            color: var(--aegis-blue);
            text-decoration: underline;
        }

        /* --- Mes Outils --- */
        .tools-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            text-align: center;
        }

        .tool-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }

        .tool-item:hover {
            transform: translateY(-2px);
        }

        .tool-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.4rem;
            margin-bottom: 8px;
            box-shadow: 0 4px 8px rgba(0, 86, 179, 0.15);
        }

        /* Variantes de teintes bleues harmonisées */
        .tool-icon.blue-dark { background-color: var(--tool-blue-dark); }
        .tool-icon.blue-medium { background-color: var(--tool-blue-medium); }
        .tool-icon.blue-light { background-color: var(--tool-blue-light); }

        .tool-label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #495057;
        }

        /* --- Grille d'Actualités --- */
        .news-grid {
            display: flex;
            gap: 25px;
            margin-bottom: 20px;
        }

        .news-card {
            flex: 1;
            text-decoration: none;
            color: inherit;
        }

        .img-wrapper {
            position: relative;
            width: 100%;
            aspect-ratio: 16 / 9;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .news-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .category-tag {
            position: absolute;
            bottom: 12px;
            left: 12px;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .news-title {
            font-size: 1.1rem;
            font-weight: bold;
            color: var(--aegis-blue);
            line-height: 1.4;
            margin: 0;
        }

        /* --- PIED DE PAGE EN BAS DE FLUX --- */
        .main-footer {
            background-color: #ffffff;
            border-top: 1px solid #e9ecef;
            padding: 20px 40px;
            text-align: center;
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: auto; /* Pousse le footer vers le bas si le contenu est court */
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: var(--aegis-light-blue);
        }

        /* --- Repositions adaptatives --- */
        @media (max-width: 1300px) {
            .dashboard-row {
                flex-direction: column;
            }
        }

        @media (max-width: 950px) {
            .header-people {
                display: none;
            }
            .header-content-center {
                padding-left: 0;
            }
            .news-grid {
                flex-direction: column;
            }
            .footer-content {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>

    <div class="top-navbar">
        <div class="navbar-brand">MyIntranet</div>
        <ul class="top-nav-links">
            <li><a href="dashboard.php" class="active">Accueil</a></li>
            <li><a href="tickets.php">Tickets</a></li>
            <li><a href="documents.php">Documents</a></li>
            <li><a href="notes.php">Notes</a></li>
            <li><a href="logout.php" class="top-logout-btn">Déconnexion</a></li>
        </ul>
    </div>

    <div class="main-container">
        
        <header class="intranet-header">
            <div class="header-container">
                <div class="header-people">
                    <img src="./assets/img/woman.png" alt="Employée" class="employee-img woman-yellow">
                    <img src="./assets/img/man.png" alt="Employé" class="employee-img man-helmet">
                </div>

                <div class="header-content-center">
                    <h1 class="welcome-title">Bonjour <?php echo htmlspecialchars($_SESSION['prenom']); ?> ! <span class="wave-emoji">👋</span></h1>
                    <p class="welcome-subtitle">Bienvenue sur votre espace personnel</p>
                </div>
            </div>
        </header>

        <main class="main-content">

            <div class="dashboard-row">
                
                <div class="events-column">
                    <div class="section-title">Événements Groupe AEGIS</div>
                    
                    <div class="events-container">
                        <div class="calendar-wrapper">
                            <div class="calendar-header">
                                <span>&lt;</span>
                                <span>Juin 2026</span>
                                <span>&gt;</span>
                            </div>
                            <div class="calendar-grid">
                                <div class="day-name">Lu</div><div class="day-name">Ma</div><div class="day-name">Me</div><div class="day-name">Je</div><div class="day-name">Ve</div><div class="day-name">Sa</div><div class="day-name">Di</div>

                                <div class="day-num today">1</div><div class="day-num">2</div><div class="day-num">3</div><div class="day-num">4</div><div class="day-num event-dot">5</div><div class="day-num">6</div><div class="day-num">7</div>
                                <div class="day-num">8</div><div class="day-num event-dot">9</div><div class="day-num">10</div><div class="day-num">11</div><div class="day-num">12</div><div class="day-num event-dot">13</div><div class="day-num">14</div>
                                <div class="day-num">15</div><div class="day-num">16</div><div class="day-num">17</div><div class="day-num">18</div><div class="day-num event-dot">19</div><div class="day-num">20</div><div class="day-num">21</div>
                                <div class="day-num">22</div><div class="day-num">23</div><div class="day-num">24</div><div class="day-num event-dot">25</div><div class="day-num">26</div><div class="day-num">27</div><div class="day-num">28</div>
                                <div class="day-num">29</div><div class="day-num">30</div>
                                <div class="day-num muted">1</div><div class="day-num muted">2</div><div class="day-num muted">3</div><div class="day-num muted">4</div><div class="day-num muted">5</div>
                            </div>
                        </div>

                        <div class="events-list-wrapper">
                            <div class="events-list">
                                <div class="event-card">
                                    <p class="event-card-title">Réunion collaborateur</p>
                                    <div class="event-meta"><span>📅 05/06</span> <span>🕒 09:30</span></div>
                                </div>
                                <div class="event-card">
                                    <p class="event-card-title">Aegis Tech Talk</p>
                                    <div class="event-meta"><span>📅 09/06</span> <span>🕒 14:00</span></div>
                                </div>
                                <div class="event-card">
                                    <p class="event-card-title">Session Q/R</p>
                                    <div class="event-meta"><span>📅 13/06</span> <span>🕒 11:00</span></div>
                                </div>
                            </div>
                            <div class="see-all-link"><a href="#">→ Voir tout</a></div>
                        </div>
                    </div>
                </div>

                <div class="tools-column">
                    <div class="section-title">Mes applications utiles</div>
                    
                    <div class="tools-container">
                        <div class="tools-grid">
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-dark">👥</div>
                                <div class="tool-label">Mes Infos RH</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-medium">⚙️</div>
                                <div class="tool-label">Mon outil SIRH</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-light">💬</div>
                                <div class="tool-label">Messenger</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-medium">✉️</div>
                                <div class="tool-label">Mes mails</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-dark">📁</div>
                                <div class="tool-label">Mes documents</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-light">📹</div>
                                <div class="tool-label">Mon outil de visio</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-dark">📇</div>
                                <div class="tool-label">Mes contacts</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-medium">📅</div>
                                <div class="tool-label">Mon calendrier</div>
                            </a>
                            <a href="#" class="tool-item">
                                <div class="tool-icon blue-light">💬</div>
                                <div class="tool-label">Slack</div>
                            </a>
                        </div>
                    </div>
                </div>

            </div>

            <div class="section-title">Actualités</div>

            <div class="news-grid">
                <a href="#" class="news-card">
                    <div class="img-wrapper">
                        <img src="./assets/img/news1.jpg" class="news-img">
                        <span class="category-tag">Espace</span>
                    </div>
                    <p class="news-title">Aegis Space signe un contrat stratégique avec l'ESA pour la mission LISA</p>
                </a>

                <a href="#" class="news-card">
                    <div class="img-wrapper">
                        <img src="./assets/img/news2.jpg" class="news-img">
                        <span class="category-tag">Cybersécurité</span>
                    </div>
                    <p class="news-title">Rapport Bad Bot 2026 : Les attaques par IA ont augmenté de 1200%</p>
                </a>

                <a href="#" class="news-card">
                    <div class="img-wrapper">
                        <img src="./assets/img/news3.jpg" class="news-img">
                        <span class="category-tag">Groupe</span>
                    </div>
                    <p class="news-title">Vision4Rescue : Exercice de grande ampleur avec la BSPP</p>
                </a>
            </div>
        </main>

        <footer class="main-footer">
            <div class="footer-content">
                <div>© <?php echo date('Y'); ?> AEGIS CORE - Tous droits réservés.</div>
                <div class="footer-links">
                    <a href="#">Assistance IT</a>
                    <a href="#">Charte Informatique</a>
                    <a href="#">Mentions légales</a>
                </div>
            </div>
        </footer>

    </div>

</body>
</html>