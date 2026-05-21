<?php
session_start();
require_once 'db_config.php'; // On garde ton fichier qui fonctionne !

// 1. Sécurité : Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$error_msg = "";
$success_msg = "";

// 2. SCÉNARIO : Est-ce que l'utilisateur connecté est Thomas Lalimace ?
$is_restricted_user = ($user_id == 2);

// 3. Traitement du formulaire de déblocage (si Thomas soumet le code master)
if ($is_restricted_user && $_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['unlock_access'])) {
    $code_saisi = trim($_POST['admin_code']);
    
    if ($code_saisi === "AEGIS_SECURE_2026") {
        $_SESSION['thomas_unlocked'] = true;
        $success_msg = "Accès restreint réautorisé par le protocole AEGIS_SECURE.";
    } else {
        $error_msg = "ÉCHEC DE L'AUTORISATION : Code administrateur invalide. Incident consigné.";
    }
}

// 4. Déterminer si l'accès doit être bloqué ou non
$access_blocked = $is_restricted_user && !isset($_SESSION['thomas_unlocked']);

// 5. Récupération de la recherche si elle existe
$recherche = isset($_POST['search']) ? trim($_POST['search']) : '';

// 6. FILTRE DE CONFIDENTIALITÉ ET BARRE DE RECHERCHE VULNÉRABLE
$documents = [];
if (!$access_blocked) {
    if (!empty($recherche)) {
        // LA FAILLE INJECTION SQL (PDO style non sécurisé)
        // On utilise ->query() avec une concaténation directe pour permettre l'UNION SELECT
        try {
            $query = "SELECT d.id, d.titre, d.nom_fichier, d.date_depot, u.prenom, u.nom 
                      FROM documents d 
                      JOIN users u ON d.auteur_id = u.id 
                      WHERE d.titre = '" . $recherche . "'";
            
            $stmt_docs = $pdo->query($query);
            $documents = $stmt_docs->fetchAll();
        } catch (Exception $e) {
            // Optionnel : afficher l'erreur SQL aide les étudiants à build leur injection
            $error_msg = "Erreur SQL rencontrée : " . $e->getMessage();
        }
    } else {
        // Si pas de recherche, on charge le comportement par défaut de ton script
        if ($user_id == 1) {
            $stmt_docs = $pdo->query("SELECT d.id, d.titre, d.nom_fichier, d.date_depot, u.prenom, u.nom 
                                      FROM documents d 
                                      JOIN users u ON d.auteur_id = u.id 
                                      ORDER BY d.date_depot DESC");
            $documents = $stmt_docs->fetchAll();
        } else {
            $stmt_docs = $pdo->prepare("SELECT d.id, d.titre, d.nom_fichier, d.date_depot, u.prenom, u.nom 
                                        FROM documents d 
                                        JOIN users u ON d.auteur_id = u.id 
                                        WHERE d.auteur_id = ? 
                                        ORDER BY d.date_depot DESC");
            $stmt_docs->execute([$user_id]);
            $documents = $stmt_docs->fetchAll();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>AEGIS CORE - Coffre-fort Documentaire</title>
    <style>
        :root { 
            --aegis-blue: #003366; 
            --aegis-light-blue: #0056b3; 
            --border: #e1e4e8; 
            --bg-gray: #f4f7f9;
        }
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background: var(--bg-gray); }
        .navbar { background-color: var(--aegis-blue); color: white; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; height: 70px; }
        .navbar a { color: rgba(255,255,255,0.7); text-decoration: none; padding: 0 20px; height: 100%; display: inline-flex; align-items: center; }
        .navbar a.active, .navbar a:hover { background: var(--aegis-light-blue); color: white; }
        .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
        
        /* Style de la barre de recherche */
        .search-container { margin-bottom: 25px; display: flex; gap: 10px; }
        .search-input { flex: 1; padding: 12px; border: 1px solid #cbd5e0; border-radius: 4px; font-size: 1rem; }
        .btn-search { background: var(--aegis-blue); color: white; border: none; padding: 12px 25px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-search:hover { background: var(--aegis-light-blue); }

        .blocked-screen { background: #fff5f5; border: 2px solid #e53e3e; border-radius: 8px; padding: 40px; text-align: center; max-width: 600px; margin: 50px auto; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .blocked-title { color: #c53030; font-size: 1.8rem; margin-top: 0; font-weight: bold; }
        .code-input { padding: 12px; width: 80%; border: 1px solid #cbd5e0; border-radius: 4px; font-size: 1.1rem; text-align: center; letter-spacing: 2px; font-family: monospace; }
        .btn-unlock { background: #c53030; color: white; border: none; padding: 12px 30px; margin-top: 15px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        
        .doc-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .doc-table th, .doc-table td { padding: 15px 20px; text-align: left; border-bottom: 1px solid var(--border); }
        .doc-table th { background: #eaedf1; font-weight: 600; color: #4a5568; }
        .btn-download { color: var(--aegis-light-blue); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

    <nav class="navbar">
        <div style="font-size: 1.4rem; font-weight: bold; letter-spacing: 1px;">AEGIS CORE</div>
        <div style="display:flex; height:100%;">
            <a href="dashboard.php">Accueil</a>
            <a href="tickets.php">Tickets</a>
            <a href="documents.php" class="active">Documents</a>
            <a href="notes.php">Notes</a>
            <a href="logout.php" style="color: #ff7b72;">Déconnexion</a>
        </div>
    </nav>

    <div class="container">
        <h2>Espace Documentaire Sécurisé</h2>

        <?php if ($access_blocked): ?>
            <div class="blocked-screen">
                <div class="blocked-title">⚠️ ACCÈS COUPE-CIRCUIT ACTIVÉ</div>
                <p style="color: #4a5568; font-size: 1.05rem; line-height: 1.5;">
                    En application du protocole <strong>Secret Défense - Projet Hermes</strong>, vos privilèges d'accès à l'espace intranet ont été suspendus par la Direction des Opérations.
                </p>
                <form action="" method="POST">
                    <input type="text" name="admin_code" class="code-input" placeholder="••••••••••••••••" required autocomplete="off">
                    <br>
                    <button type="submit" name="unlock_access" class="btn-unlock">FORCER LE DÉBLOCAGE</button>
                </form>
            </div>

        <?php else: ?>
            <form action="documents.php" method="POST" class="search-container">
                <input type="text" name="search" class="search-input" value="<?php echo htmlspecialchars($recherche); ?>" placeholder="Rechercher un document par son titre exact...">
                <button type="submit" class="btn-search">Rechercher</button>
            </form>

            <?php if($success_msg): ?>
                <div style="background: #dafbe1; color: #1e4620; padding:15px; border-radius:6px; margin-bottom:20px; font-size:0.9rem; font-weight:bold;"><?php echo $success_msg; ?></div>
            <?php endif; ?>
            <?php if($error_msg): ?>
                <div style="background: #fff5f5; color: #c53030; padding:15px; border-radius:6px; margin-bottom:20px; font-size:0.9rem; font-weight:bold;"><?php echo $error_msg; ?></div>
            <?php endif; ?>

            <table class="doc-table">
                <thead>
                    <tr>
                        <th>Nom du document</th>
                        <th>Déposé par</th>
                        <th>Date de téléversement</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (count($documents) > 0): ?>
                        <?php foreach ($documents as $doc): ?>
                            <tr>
                                <td>📄 <strong><?php echo htmlspecialchars($doc['titre']); ?></strong></td>
                                <td style="color:#666;"><?php echo htmlspecialchars(($doc['prenom'] ?? 'Système') . ' ' . ($doc['nom'] ?? '')); ?></td>
                                <td style="font-size:0.9rem; color:#888;"><?php echo isset($doc['date_depot']) ? date('d/m/Y H:i', strtotime($doc['date_depot'])) : 'N/A'; ?></td>
                                <td><a href="files/<?php echo $doc['nom_fichier'] ?? '#'; ?>" class="btn-download" download>Télécharger</a></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="4" style="text-align:center; color:#999; font-style:italic; padding: 30px;">Aucun document trouvé.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>
</body>
</html>