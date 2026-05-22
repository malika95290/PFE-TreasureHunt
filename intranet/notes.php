<?php
session_start();
require_once 'db_config.php'; // Ton fichier PDO existant

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$error_msg = "";
$success_msg = "";

// --- ACTIONS CRUD ---

// 1. AJOUTER UNE NOTE
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] === 'create') {
    $titre = trim($_POST['titre']);
    $description = trim($_POST['description']);
    
    if (!empty($titre) && !empty($description)) {
        $stmt = $pdo->prepare("INSERT INTO notes (user_id, titre, description) VALUES (?, ?, ?)");
        $stmt->execute([$user_id, $titre, $description]);
        $success_msg = "Note créée avec succès.";
    } else {
        $error_msg = "Veuillez remplir tous les champs.";
    }
}

// 2. SUPPRIMER UNE NOTE
if (isset($_GET['delete'])) {
    $note_id = intval($_GET['delete']);
    // Sécurité : On vérifie que la note appartient bien à l'utilisateur connecté
    $stmt = $pdo->prepare("DELETE FROM notes WHERE id = ? AND user_id = ?");
    $stmt->execute([$note_id, $user_id]);
    $success_msg = "Note supprimée.";
}

// 3. RECUPERER LES NOTES DE L'UTILISATEUR
$stmt_get = $pdo->prepare("SELECT * FROM notes WHERE user_id = ? ORDER BY date_creation DESC");
$stmt_get->execute([$user_id]);
$user_notes = $stmt_get->fetchAll();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>AEGIS CORE - Bloc-notes Sécurisé</title>
    <style>
        :root { 
            --aegis-blue: #003366; 
            --aegis-light-blue: #0056b3; 
            --bg-gray: #f4f7f9;
            --card-shadow: rgba(0, 0, 0, 0.08) 0px 4px 12px;
        }
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background: var(--bg-gray); color: #333; }
        
        .navbar { background-color: var(--aegis-blue); color: white; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; height: 70px; }
        .navbar a { color: rgba(255,255,255,0.7); text-decoration: none; padding: 0 20px; height: 100%; display: inline-flex; align-items: center; }
        .navbar a.active, .navbar a:hover { background: var(--aegis-light-blue); color: white; }

        .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
        
        /* Formulaire de création de note (style épuré du haut de l'exemple) */
        .note-creator { background: white; max-width: 500px; margin: 0 auto 40px auto; padding: 15px; border-radius: 8px; box-shadow: var(--card-shadow); border: 1px solid #e1e4e8; }
        .note-creator input, .note-creator textarea { width: 100%; border: none; outline: none; font-family: inherit; box-sizing: border-box; }
        .note-creator input { font-size: 1.1rem; font-weight: bold; margin-bottom: 10px; }
        .note-creator textarea { font-size: 0.95rem; resize: none; min-height: 60px; }
        .note-creator-footer { display: flex; justify-content: flex-end; margin-top: 10px; }
        .btn-create { background: var(--aegis-blue); color: white; border: none; padding: 8px 16px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .btn-create:hover { background: var(--aegis-light-blue); }

        /* Grille de notes (Style Google Keep / Pinterest) */
        .notes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; align-items: start; }
        
        /* Carte de Note */
        .note-card { background: #fffdeb; /* Teinte jaune pastel par défaut */ border: 1px solid #e2db9a; border-radius: 8px; padding: 20px; position: relative; box-shadow: var(--card-shadow); transition: transform 0.2s; min-height: 120px; display: flex; flex-direction: column; justify-content: space-between; }
        .note-card:hover { transform: translateY(-2px); }
        .note-title { font-weight: bold; font-size: 1.1rem; margin: 0 0 10px 0; color: #222; word-wrap: break-word; }
        .note-desc { font-size: 0.95rem; line-height: 1.4; color: #444; white-space: pre-line; margin-bottom: 20px; word-wrap: break-word; }
        
        .note-footer { display: flex; justify-content: space-between; align-items: center; font-size: 0.8rem; color: #777; }
        .btn-delete { color: #e53e3e; text-decoration: none; font-weight: bold; transition: color 0.2s; }
        .btn-delete:hover { color: #c53030; }

        /* Couleurs alternatives aléatoires ou fixes pour le design */
        .note-card:nth-child(2n) { background: #e8f0fe; border-color: #c4d7f5; } /* Bleu */
        .note-card:nth-child(3n) { background: #e6fffa; border-color: #b2f5ea; } /* Vert */
    </style>
</head>
<body>

    <nav class="navbar">
        <div style="font-size: 1.4rem; font-weight: bold; letter-spacing: 1px;">AEGIS CORE</div>
        <div style="display:flex; height:100%;">
            <a href="dashboard.php">Accueil</a>
            <a href="tickets.php">Tickets</a>
            <a href="documents.php">Documents</a>
            <a href="notes.php" class="active">Notes</a>
            <a href="logout.php" style="color: #ff7b72;">Déconnexion</a>
        </div>
    </nav>

    <div class="container">
        
        <form action="notes.php" method="POST" class="note-creator">
            <input type="hidden" name="action" value="create">
            <input type="text" name="titre" placeholder="Créer une note..." required autocomplete="off">
            <textarea name="description" placeholder="Ajouter un mémo textuel..." required></textarea>
            <div class="note-creator-footer">
                <button type="submit" class="btn-create">Créer</button>
            </div>
        </form>

        <?php if($success_msg): ?>
            <div style="background: #dafbe1; color: #1e4620; padding:12px; border-radius:6px; margin-bottom:20px; font-size:0.9rem; font-weight:bold; max-width:500px; margin: 0 auto 20px auto;"><?php echo $success_msg; ?></div>
        <?php endif; ?>

        <div class="notes-grid">
            <?php if (count($user_notes) > 0): ?>
                <?php foreach ($user_notes as $note): ?>
                    <div class="note-card">
                        <div>
                            <div class="note-title"><?php echo htmlspecialchars($note['titre']); ?></div>
                            <div class="note-desc"><?php echo htmlspecialchars($note['description']); ?></div>
                        </div>
                        <div class="note-footer">
                            <span>📅 <?php echo date('d/m/Y', strtotime($note['date_creation'])); ?></span>
                            <a href="notes.php?delete=<?php echo $note['id']; ?>" class="btn-delete" onclick="return confirm('Supprimer ce mémo ?');">Supprimer</a>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div style="grid-column: 1 / -1; text-align: center; color: #718096; font-style: italic; padding: 40px;">
                    Aucun mémo ou note dans votre espace personnel.
                </div>
            <?php endif; ?>
        </div>

    </div>

</body>
</html>