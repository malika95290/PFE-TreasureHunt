<?php
$msg = "";
$status_class = "";

// Quand l'étudiant soumet son flag
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['validate_mission'])) {
    $equipe = htmlspecialchars(trim($_POST['team_name']));
    $flag_saisi = trim($_POST['flag_code']);
    
    // Le flag extrait de Wireshark
    $vrai_flag = "FLAG{S1L3NT_W1R3_TL_2026}";
    
    if ($flag_saisi === $vrai_flag) {
        $msg = "🟢 **MISSION VALIDÉE POUR L'ÉQUIPE [" . $equipe . "]**<br><br>
                Le flag est correct. Les preuves d'interception du satellite Aurora ont été transmises à notre cellule d'analyse. 
                L'infrastructure illégale d'Aegis Corporation va être démantelée. Beau travail, agent.";
        $status_class = "success";
    } else {
        $msg = "🔴 **ÉCHEC DE VALIDATION**<br><br>
                La clé de chiffrement soumise est invalide. Le flux réseau intercepté n'a pas pu être décodé. 
                Retournez sur Wireshark et analysez plus précisément les flux suspects.";
        $status_class = "error";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>CENTRALE DE SOUUMISSION - OPS HERMES</title>
    <style>
        body { 
            font-family: 'Courier New', Courier, monospace; 
            background: #05070a; 
            color: #00ff66; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        .hq-container { 
            background: #0a0f18; 
            border: 2px solid #00ff66; 
            border-radius: 4px; 
            padding: 40px; 
            width: 100%; 
            max-width: 500px; 
            box-shadow: 0 0 20px rgba(0, 255, 102, 0.2); 
        }
        h2 { 
            text-align: center; 
            margin-top: 0; 
            letter-spacing: 2px;
            color: #ffffff;
            border-bottom: 1px solid #00ff66;
            padding-bottom: 10px;
        }
        .form-group { margin: 20px 0; }
        label { display: block; margin-bottom: 8px; font-size: 0.9rem; uppercase; font-weight: bold;}
        input { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid #00ff66; 
            background: #000000; 
            color: #00ff66; 
            border-radius: 2px; 
            box-sizing: border-box; 
            font-size: 1rem; 
        }
        input:focus { outline: none; box-shadow: 0 0 8px rgba(0, 255, 102, 0.5); }
        .btn-submit { 
            background: #00ff66; 
            color: #000000; 
            border: none; 
            padding: 14px; 
            width: 100%; 
            font-weight: bold; 
            cursor: pointer; 
            font-size: 1rem; 
            letter-spacing: 1px;
            transition: all 0.2s;
        }
        .btn-submit:hover { background: #ffffff; color: #000000; box-shadow: 0 0 10px #ffffff; }
        .terminal-msg { 
            padding: 15px; 
            border-radius: 2px; 
            margin-top: 25px; 
            font-size: 0.95rem; 
            line-height: 1.5; 
        }
        .success { border: 1px solid #00ff66; background: rgba(0, 255, 102, 0.05); color: #00ff66; }
        .error { border: 1px solid #ff3333; background: rgba(255, 51, 51, 0.05); color: #ff3333; }
    </style>
</head>
<body>

<div class="hq-container">
    <h2>[ PORTAIL DE L'AGENCE ]</h2>
    <p style="color: #8899a6; text-align: center; font-size: 0.85rem; margin-bottom: 30px;">Liaison sécurisée cryptée - Rapport de fin d'opération</p>
    
    <form action="" method="POST">
        <div class="form-group">
            <label>Identifiant d'opérateur (Nom / Équipe) :</label>
            <input type="text" name="team_name" placeholder="Ex: Agent_Alpha" required autocomplete="off">
        </div>
        
        <div class="form-group">
            <label>Clé d'exfiltration réseau (FLAG) :</label>
            <input type="text" name="flag_code" placeholder="FLAG{...}" required autocomplete="off">
        </div>
        
        <button type="submit" name="validate_mission" class="btn-submit">TRANSMETTRE LE RAPPORT</button>
    </form>

    <?php if($msg): ?>
        <div class="terminal-msg <?php echo $status_class; ?>"><?php echo $msg; ?></div>
    <?php endif; ?>
</div>

</body>
</html>