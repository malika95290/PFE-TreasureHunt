<?php
session_start();
require_once 'db_config.php';

// 1. Sécurité : Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$user_nom = $_SESSION['prenom'] . " " . $_SESSION['nom'];
$success_msg = "";
$error_msg = "";

// --- LOGIQUE DE CRÉATION DE TICKET ---
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['create_ticket'])) {
    $titre = $_POST['titre'];
    $desc = $_POST['description'];
    $prio = $_POST['priorite'];
    $auteur_id = $_SESSION['user_id']; // L'ID de celui qui écrit
    $assigne_a = 1; // L'ID de l'admin (assure-toi que l'ID 1 existe en BDD !)

    // ON A 5 POINTS D'INTERROGATION
    $sql_ins = "INSERT INTO tickets (titre, description, priorite, auteur_id, assigne_a) VALUES (?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($sql_ins);
    
    // ON DOIT DONC PASSER 5 VARIABLES DANS LE TABLEAU
    if ($stmt->execute([$titre, $desc, $prio, $auteur_id, $assigne_a])) {
        $success_msg = "Le ticket #" . $pdo->lastInsertId() . " a été ouvert avec succès.";
    } else {
        $error_msg = "Erreur lors de la création du ticket.";
    }
}

// 3. Gestion des onglets (Filtre de vue)
$view = isset($_GET['view']) ? $_GET['view'] : 'assigned';

if ($view === 'my_tickets') {
    $sql_list = "SELECT * FROM tickets WHERE auteur_id = ? ORDER BY date_creation DESC";
    $view_title = "Mes demandes émises";
} else {
    $sql_list = "SELECT * FROM tickets WHERE assigne_a = ? ORDER BY date_creation DESC";
    $view_title = "Tickets à traiter";
}

$stmt_l = $pdo->prepare($sql_list);
$stmt_l->execute([$user_id]);
$tickets = $stmt_l->fetchAll();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>AEGIS CORE - Tickets</title>
    <style>
        :root {
            --aegis-blue: #003366;
            --aegis-light-blue: #0056b3;
            --bg-gray: #f4f7f9;
            --border: #e1e4e8;
            --text-dark: #333;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #fff;
            color: var(--text-dark);
        }

        /* BARRE DE NAVIGATION EN HAUT */
        .navbar {
            background-color: var(--aegis-blue);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            height: 70px;
        }
        
        .navbar-header {
            font-size: 1.4rem;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .nav-container {
            display: flex;
            align-items: center;
            height: 100%;
        }

        .nav-links { 
            list-style: none; 
            padding: 0; 
            margin: 0; 
            display: flex;
            height: 100%;
        }
        
        .nav-links li {
            height: 100%;
        }

        .nav-links li a {
            display: flex;
            align-items: center;
            padding: 0 25px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: 0.3s;
            height: 100%;
            box-sizing: border-box;
        }
        
        .nav-links li a:hover, .nav-links li a.active {
            background-color: var(--aegis-light-blue);
            color: white;
        }

        .logout-section {
            display: flex;
            align-items: center;
            padding-left: 25px;
            border-left: 1px solid rgba(255,255,255,0.1);
            height: 50%;
        }

        /* CONTENU PRINCIPAL */
        .main-wrapper {
            display: flex;
            flex-direction: column;
            height: calc(100vh - 70px);
            overflow: hidden;
        }
        
        .top-nav {
            padding: 15px 30px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fff;
        }

        /* SPLIT VIEW (GAUCHE / DROITE) */
        .split-view {
            display: flex;
            flex-grow: 1;
            overflow: hidden;
        }

        /* Panneau de gauche : Liste */
        .panel-list {
            width: 60%;
            background-color: var(--bg-gray);
            border-right: 1px solid var(--border);
            padding: 25px;
            overflow-y: auto;
        }

        /* Panneau de droite : Formulaire */
        .panel-form {
            width: 40%;
            padding: 40px;
            overflow-y: auto;
        }

        /* ONGLETS (TABS) */
        .tabs {
            display: flex;
            background: #e1e4e8;
            padding: 4px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .tab-link {
            flex: 1;
            text-align: center;
            padding: 8px;
            text-decoration: none;
            color: #586069;
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 6px;
            transition: 0.2s;
        }
        .tab-link.active {
            background: white;
            color: var(--aegis-blue);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* CARTES TICKETS */
        .ticket-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            transition: 0.2s;
        }
        .ticket-card:hover { border-color: var(--aegis-light-blue); }
        .t-id { font-size: 0.75rem; color: #888; font-weight: bold; }
        .t-title { display: block; margin: 8px 0; font-weight: bold; color: var(--aegis-blue); }
        
        .badge {
            font-size: 0.7rem;
            padding: 3px 10px;
            border-radius: 12px;
            text-transform: uppercase;
            font-weight: bold;
        }
        .prio-Critique { background: #ffeef0; color: #d73a49; }
        .prio-Haute { background: #fff5b1; color: #735c0f; }
        .prio-Moyenne { background: #dbedff; color: #0366d6; }
        .prio-Basse { background: #dcffe4; color: #28a745; }

        /* FORMULAIRE */
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; }
        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        .btn-submit {
            background-color: var(--aegis-blue);
            color: white;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-submit:hover { background-color: #002244; }

        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
        .alert-success { background: #dafbe1; color: #1e4620; border: 1px solid #bbe5c5; }
    </style>
</head>
<body>

    <nav class="navbar">
        <div class="navbar-header">AEGIS CORE</div>
        
        <div class="nav-container">
            <ul class="nav-links">
                <li><a href="dashboard.php">Accueil</a></li>
                <li><a href="tickets.php" class="active">Tickets</a></li>
                <li><a href="documents.php">Documents</a></li>
                <li><a href="notes.php">Notes</a></li>
            </ul>
            
            <div class="logout-section">
                <a href="logout.php" style="color: #ff7b72; text-decoration: none; font-size: 0.9rem; font-weight: bold;">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="main-wrapper">
        <header class="top-nav">
            <h2 style="margin:0;">Support Technique</h2>
            <div style="font-size: 0.9rem;">Collaborateur : <strong><?php echo htmlspecialchars($user_nom); ?></strong></div>
        </header>

        <div class="split-view">
            <div class="panel-list">
                <div class="tabs">
                    <a href="?view=assigned" class="tab-link <?php echo ($view === 'assigned') ? 'active' : ''; ?>">📥 À traiter</a>
                    <a href="?view=my_tickets" class="tab-link <?php echo ($view === 'my_tickets') ? 'active' : ''; ?>">📤 Mes tickets</a>
                </div>

                <h3 style="margin-top:0;"><?php echo $view_title; ?></h3>

                <?php if (count($tickets) > 0): ?>
                    <?php foreach ($tickets as $t): ?>
                        <div class="ticket-card">
                            <span class="t-id">#<?php echo $t['id']; ?> — <?php echo date('d/m/Y', strtotime($t['date_creation'])); ?></span>
                            <span class="t-title"><?php echo htmlspecialchars($t['titre']); ?></span>
                            <div style="display:flex; justify-content: space-between; align-items: center;">
                                <span class="badge prio-<?php echo $t['priorite']; ?>"><?php echo $t['priorite']; ?></span>
                                <span style="font-size: 0.75rem; color: #666;"><?php echo $t['statut']; ?></span>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p style="color: #666; font-style: italic;">Aucun ticket à afficher.</p>
                <?php endif; ?>
            </div>

            <div class="panel-form">
                <h3 style="margin-top:0;">Ouvrir un nouveau ticket</h3>
                <p style="color: #666; margin-bottom: 30px;">Veuillez détailler l'incident rencontré. Un technicien Aegis prendra en charge votre demande.</p>

                <?php if($success_msg): ?>
                    <div class="alert alert-success"><?php echo $success_msg; ?></div>
                <?php endif; ?>

                <form action="" method="POST">
                    <div class="form-group">
                        <label>Sujet de l'incident</label>
                        <input type="text" name="titre" required placeholder="Ex: Panne de terminal satellite Aurora">
                    </div>

                    <div class="form-group">
                        <label>Description détaillée</label>
                        <textarea name="description" rows="8" required placeholder="Expliquez ici les circonstances de l'incident..."></textarea>
                    </div>

                    <div class="form-group">
                        <label>Urgence perçue</label>
                        <select name="priorite">
                            <option value="Basse">Basse (Simple demande)</option>
                            <option value="Moyenne" selected>Moyenne (Standard)</option>
                            <option value="Haute">Haute (Impact opérationnel)</option>
                            <option value="Critique">Critique (Urgence Sécurité)</option>
                        </select>
                    </div>

                    <button type="submit" name="create_ticket" class="btn-submit">ENVOYER LA DEMANDE</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>