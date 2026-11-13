<?php
$user = "admin";
$password = "ShD6rz877wqX";
$database = "flightdata";
$table = "planes";

try {
    $db = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
    echo "<h2>Planes</h2><ol>";
    foreach($db->query("SELECT type FROM $table") as $row) {
        echo "<li>" . $row['type'] . "</li>";
    }
    echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}