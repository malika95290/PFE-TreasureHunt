<?php
    $dbname = 'aegis_core';
    $host = 'localhost';
    $user = 'aegis_app';
    $pass = 'Aeg1s@App2026!';   

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        die("Erreur de connexion local : " . $e->getMessage());
    }
?>