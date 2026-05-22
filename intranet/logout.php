<?php
// 1. Initialiser la session pour pouvoir la manipuler
session_start();

// 2. Vider toutes les variables de session
$_SESSION = array();

// 3. Si on souhaite détruire complètement la session, on efface aussi le cookie de session.
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// 4. Détruire la session sur le serveur
session_destroy();

// 5. Rediriger l'utilisateur vers la page de login
header("Location: login.php");
exit();
?>