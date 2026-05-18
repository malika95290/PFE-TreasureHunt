<?php
    session_start();
    require_once 'db_config.php';

    $error = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $user = $_POST['username'];
        $pass = $_POST['password'];

        /** * ⚠️ VULNÉRABILITÉ VOLONTAIRE (Injection SQL)
         * On utilise directement la variable $user dans la requête sans protection.
         * Payload exemple : admin' OR '1'='1
         */
        $sql = "SELECT * FROM users WHERE username = '$user'";
        
        try {
            $query = $pdo->query($sql);
            $result = $query->fetch();

            if ($result) {
                // Dans un CTF, on simule souvent que si l'user existe via l'injection, 
                // on ne vérifie pas le mot de passe pour laisser passer l'attaquant.
                $_SESSION['user_id'] = $result['id'];
                $_SESSION['nom'] = $result['nom'];
                $_SESSION['prenom'] = $result['prenom'];
                $_SESSION['role'] = $result['poste'];
                $_SESSION['acc'] = $result['niveau_accreditation'];

                header("Location: dashboard.php");
                exit();
            } else {
                $error = "Accès refusé. Identifiants inconnus ou compte désactivé.";
            }
        } catch (PDOException $e) {
            // On affiche l'erreur SQL : très utile pour l'étudiant qui fait son injection !
            $error = "Erreur SQL système : " . $e->getMessage();
        }
    }
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AEGIS CORE - Authentification</title>
    <style>
        * {
            box-sizing: border-box;
        }
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            height: 100vh;
            background-color: #ffffff;
        }

        /* --- SECTION GAUCHE : LOGO & TITRE --- */
        .left-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            background-color: #ffffff;
            position: relative;
        }

        .logo-container {
            text-align: center;
            max-width: 400px;
        }

        .logo-img {
            width: 80px;
            height: auto;
            margin-bottom: 15px;
            display: inline-block;
        }

        .logo-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #003366; /* Bleu AEGIS */
            margin: 0;
            letter-spacing: 1px;
        }

        .logo-title span {
            font-weight: 300;
        }

        .logo-subtitle {
            font-size: 1.1rem;
            color: #555555;
            margin: 15px 0 5px 0;
            font-weight: 600;
        }

        .logo-link {
            font-size: 1.1rem;
            color: #0056b3;
            text-decoration: none;
            font-weight: 500;
        }

        /* --- SECTION DROITE : FORMULAIRE DE CONNEXION --- */
        .right-panel {
            flex: 1;
            background: linear-gradient(135deg, #1e5ab3 0%, #002244 100%);
            /* Forme biseautée calquée sur l'exemple MOLISAC */
            clip-path: polygon(12% 0, 100% 0, 100% 100%, 0 100%);
            margin-left: -6%; 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px 40px 40px 14%;
            color: #ffffff;
            position: relative;
        }

        /* Ajout d'effets de cercles translucides en arrière-plan */
        .right-panel::before {
            content: '';
            position: absolute;
            top: -20%;
            right: -10%;
            width: 600px;
            height: 600px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.03);
            pointer-events: none;
        }

        .login-box {
            width: 100%;
            max-width: 380px;
            z-index: 2;
        }

        .login-box h2 {
            font-size: 2rem;
            font-weight: 400;
            margin: 0 0 25px 0;
            text-align: center;
            letter-spacing: 0.5px;
        }

        .login-box p {
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
            width: 100%;
        }

        .form-group input {
            width: 100%;
            padding: 14px 20px;
            background-color: #ffffff;
            border: none;
            border-radius: 30px; /* Inputs arrondis type pilule */
            font-size: 0.95rem;
            color: #333333;
            outline: none;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group input::placeholder {
            color: #999999;
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            border: none;
            color: white;
            font-size: 0.95rem;
            font-weight: bold;
            letter-spacing: 1px;
            cursor: pointer;
            border-radius: 30px;
            transition: background 0.2s, transform 0.1s;
            background-color: #00a8ff;
            box-shadow: 0 4px 12px rgba(0, 168, 255, 0.3);
            text-transform: uppercase;
        }

        .btn-login:hover {
            background-color: #0086cc;
        }

        .btn-login:active {
            transform: scale(0.98);
        }

        /* Liens d'assistance en bas à droite */
        .footer-help {
            margin-top: 40px;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.7);
            text-align: center;
        }

        .footer-help a {
            color: #ff8533;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-help a:hover {
            text-decoration: underline;
        }

        /* Encadré d'erreur SQL / Injection */
        .error-box {
            background: rgba(248, 81, 73, 0.15);
            border: 1px solid #f85149;
            color: #ff8580;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 0.85rem;
            border-radius: 8px;
            text-align: left;
        }

        /* Pied de page discret pour les mentions légales côté blanc */
        .left-footer {
            position: absolute;
            bottom: 15px;
            left: 25px;
            color: #aaaaaa;
            font-size: 0.65rem;
        }

        /* --- RESPONSIVE MOBILE --- */
        @media (max-width: 850px) {
            body {
                flex-direction: column;
                height: auto;
                min-height: 100vh;
            }
            .left-panel {
                padding: 40px 20px;
                flex: none;
            }
            .right-panel {
                flex: 1;
                clip-path: none;
                margin-left: 0;
                padding: 40px 20px;
            }
            .left-footer {
                position: relative;
                bottom: 0;
                left: 0;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="left-panel">
        <div class="logo-container">
            <img src="./assets/img/logo-aegis.png" alt="Logo AEGIS" class="logo-img">
            <h1 class="logo-title">AEGIS <span>Technologies </span></h1>
            <p class="logo-subtitle">Système Central d'Authentification</p>
            <a href="#" class="logo-link">Intranet</a>
        </div>

        <div class="left-footer">
            © Aegis S.A.C. Inc. 2026
        </div>
    </div>

    <div class="right-panel">
        <div class="login-box">
            <h2>Connexion</h2>
            <p>Connectez-vous à votre compte</p>

            <?php if ($error): ?>
                <div class="error-box">
                    <strong>ALERTE SYSTÈME :</strong> <?php echo $error; ?>
                </div>
            <?php endif; ?>

            <form action="" method="POST">
                <div class="form-group">
                    <input type="text" id="username" name="username" required placeholder="Identifiant ou adresse e-mail">
                </div>
                
                <div class="form-group">
                    <input type="password" id="password" name="password" required placeholder="Mot de passe">
                </div>


                <button type="submit" class="btn-login">Se connecter</button>
            </form>

            <div class="footer-help">
                Contactez-nous en cas de difficultés de connexion<br>
                <a href="#">Aide &amp; Support</a>
            </div>
        </div>
    </div>

</body>
</html>