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

// --- LOGIQUE DE CRÉATION DE TICKET (PANNEAU PAR DÉFAUT) ---
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['create_ticket'])) {
    $titre = $_POST['titre'];
    $desc = $_POST['description'];
    $prio = $_POST['priorite'];
    $auteur_id = $_SESSION['user_id']; 
    $assigne_a = 1; // ID de l'admin par défaut

    $sql_ins = "INSERT INTO tickets (titre, description, priorite, auteur_id, assigne_a, statut) VALUES (?, ?, ?, ?, ?, 'Ouvert')";
    $stmt = $pdo->prepare($sql_ins);
    
    if ($stmt->execute([$titre, $desc, $prio, $auteur_id, $assigne_a])) {
        $success_msg = "Le ticket #" . $pdo->lastInsertId() . " a été ouvert avec succès.";
    } else {
        $error_msg = "Erreur lors de la création du ticket.";
    }
}

// --- LOGIQUE D'AJOUT DE MESSAGE (DANS UN TICKET EXISTANT) ---
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['post_message'])) {
    $ticket_id = (int)$_POST['ticket_id'];
    $msg_text = trim($_POST['reply_message']);

    if (!empty($msg_text)) {
        $sql_msg_ins = "INSERT INTO ticket_messages (ticket_id, auteur_id, message) VALUES (?, ?, ?)";
        $stmt_m_ins = $pdo->prepare($sql_msg_ins);
        
        if ($stmt_m_ins->execute([$ticket_id, $user_id, $msg_text])) {
            // Optionnel : On peut changer le statut du ticket si nécessaire au moment de la réponse
            $success_msg = "Message ajouté au fil de discussion.";
        } else {
            $error_msg = "Impossible d'envoyer le message.";
        }
    }
}

// 2. Gestion des onglets (Filtre de vue de la liste)
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

// 3. RECUPERATION DU TICKET SÉLECTIONNÉ ET DE SES MESSAGES
$selected_ticket = null;
$messages = [];

if (isset($_GET['ticket_id'])) {
    $ticket_id = (int)$_GET['ticket_id'];
    
    // Récupérer les détails du ticket sélectionné
    $stmt_t = $pdo->prepare("SELECT t.*, u.prenom as aut_prenom, u.nom as aut_nom FROM tickets t JOIN users u ON t.auteur_id = u.id WHERE t.id = ?");
    $stmt_t->execute([$ticket_id]);
    $selected_ticket = $stmt_t->fetch();
    
    if ($selected_ticket) {
        // Récupérer le fil de discussion associé à ce ticket
        $sql_msg = "SELECT m.*, u.prenom, u.nom, u.poste 
                    FROM ticket_messages m 
                    JOIN users u ON m.auteur_id = u.id 
                    WHERE m.ticket_id = ? 
                    ORDER BY m.date_envoi ASC";
        $stmt_msg = $pdo->prepare($sql_msg);
        $stmt_msg->execute([$ticket_id]);
        $messages = $stmt_msg->fetchAll();
    }
}
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
            width: 45%;
            background-color: var(--bg-gray);
            border-right: 1px solid var(--border);
            padding: 25px;
            overflow-y: auto;
        }

        /* Panneau de droite : Formulaire ou Détails */
        .panel-form {
            width: 55%;
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
            cursor: pointer;
            text-decoration: none;
            display: block;
            color: inherit;
        }
        .ticket-card:hover, .ticket-card.selected { border-color: var(--aegis-light-blue); background-color: #f0f7ff; }
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
        .prio-Supprimé { background: #333; color: #fff; }
        .prio-Haute { background: #fff5b1; color: #735c0f; }
        .prio-Moyenne { background: #dbedff; color: #0366d6; }
        .prio-Basse { background: #dcffe4; color: #28a745; }

        /* DISCUSSION / MESSAGES */
        .chat-container {
            margin-top: 20px;
            border-top: 2px dashed var(--border);
            padding-top: 20px;
        }
        .msg-bubble {
            background: #f1f3f5;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid var(--aegis-blue);
        }
        .msg-bubble.admin-reply {
            border-left-color: #28a745;
            background: #edf7ed;
        }
        .msg-bubble.direction-reply {
            border-left-color: #d73a49;
            background: #fff0f1;
        }
        .msg-header {
            font-size: 0.85rem;
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            display: flex;
            justify-content: space-between;
        }

        /* REPLYS ZONE */
        .reply-box {
            margin-top: 25px;
            background: #f8f9fa;
            border: 1px solid var(--border);
            padding: 20px;
            border-radius: 8px;
        }

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

        .btn-reply {
            background-color: #555;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            float: right;
            transition: 0.2s;
        }
        .btn-reply:hover { background-color: var(--aegis-light-blue); }

        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
        .alert-success { background: #dafbe1; color: #1e4620; border: 1px solid #bbe5c5; }
        .alert-danger { background: #ffeef0; color: #d73a49; border: 1px solid #ffccd1; }
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

                <?php if($error_msg): ?>
                    <div class="alert alert-danger"><?php echo $error_msg; ?></div>
                <?php endif; ?>

                <?php if (count($tickets) > 0): ?>
                    <?php foreach ($tickets as $t): ?>
                        <?php 
                            $isSelected = (isset($_GET['ticket_id']) && $_GET['ticket_id'] == $t['id']) ? 'selected' : ''; 
                        ?>
                        <a href="?view=<?php echo $view; ?>&ticket_id=<?php echo $t['id']; ?>" class="ticket-card <?php echo $isSelected; ?>">
                            <span class="t-id">#<?php echo $t['id']; ?> — <?php echo date('d/m/Y', strtotime($t['date_creation'])); ?></span>
                            <span class="t-title"><?php echo htmlspecialchars($t['titre']); ?></span>
                            <div style="display:flex; justify-content: space-between; align-items: center;">
                                <span class="badge prio-<?php echo $t['priorite']; ?>"><?php echo $t['priorite']; ?></span>
                                <span style="font-size: 0.75rem; color: #666;"><?php echo htmlspecialchars($t['statut']); ?></span>
                            </div>
                        </a>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p style="color: #666; font-style: italic;">Aucun ticket à afficher.</p>
                <?php endif; ?>
            </div>

            <div class="panel-form">
                <?php if ($selected_ticket): ?>
                    <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                        <h3 style="margin-top:0; color:var(--aegis-blue);">Ticket #<?php echo $selected_ticket['id']; ?> : <?php echo htmlspecialchars($selected_ticket['titre']); ?></h3>
                        <a href="tickets.php?view=<?php echo $view; ?>" style="font-size:0.85rem; color:var(--aegis-light-blue); text-decoration:none; font-weight:bold;">[ Nouveau Ticket ]</a>
                    </div>
                    
                    <div style="background:#f8f9fa; padding:15px; border-radius:6px; margin-bottom:20px; font-size:0.95rem;">
                        <strong>Description initiale (émanant de <?php echo htmlspecialchars($selected_ticket['aut_prenom'] . ' ' . $selected_ticket['aut_nom']); ?>) :</strong><br>
                        <p style="white-space: pre-wrap; margin-top:10px; color:#444;"><?php echo htmlspecialchars($selected_ticket['description']); ?></p>
                    </div>

                    <div class="chat-container">
                        <h4 style="margin-top:0; color:#555;">Fil de discussion sécurisé :</h4>
                        
                        <?php if (count($messages) > 0): ?>
                            <?php foreach ($messages as $msg): ?>
                                <?php 
                                    // Distinction stylistique des bulles selon l'auteur
                                    $bubble_class = "";
                                    if ($msg['auteur_id'] == 1) { $bubble_class = "admin-reply"; }
                                    elseif ($msg['auteur_id'] == 3) { $bubble_class = "direction-reply"; }
                                ?>
                                <div class="msg-bubble <?php echo $bubble_class; ?>">
                                    <div class="msg-header">
                                        <span>👤 <?php echo htmlspecialchars($msg['prenom'] . ' ' . $msg['nom'] . ' (' . $msg['poste'] . ')'); ?></span>
                                        <span>📅 <?php echo date('d/m/Y H:i', strtotime($msg['date_envoi'])); ?></span>
                                    </div>
                                    <div style="white-space: pre-wrap; font-size:0.95rem; line-height:1.4;"><?php echo htmlspecialchars($msg['message']); ?></div>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <p style="color: #888; font-style: italic; font-size:0.9rem; margin-bottom:20px;">Aucun message enregistré dans ce fil.</p>
                        <?php endif; ?>
                    </div>

                    <div class="reply-box">
                        <form action="" method="POST">
                            <input type="hidden" name="ticket_id" value="<?php echo $selected_ticket['id']; ?>">
                            <div class="form-group" style="margin-bottom:10px;">
                                <label for="reply_message" style="font-size:0.9rem; color:#555;">Ajouter une réponse au fil :</label>
                                <textarea name="reply_message" id="reply_message" rows="3" required placeholder="Tapez votre message chiffré ici..."></textarea>
                            </div>
                            <button type="submit" name="post_message" class="btn-reply">TRANSMETTRE</button>
                            <div style="clear:both;"></div>
                        </form>
                    </div>

                <?php else: ?>
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
                <?php endif; ?>
            </div>
        </div>
    </div>

</body>
</html>