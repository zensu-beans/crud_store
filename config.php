<?php

// ── Database credentials (Railway + Local) ──
$host = getenv('MYSQLHOST') ?: 'localhost';
$user = getenv('MYSQLUSER') ?: 'root';
$pass = getenv('MYSQLPASSWORD') ?: '';
$dbname = getenv('MYSQLDATABASE') ?: 'crud_store';
$port = getenv('MYSQLPORT') ?: '3306';

// ── Session ──
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// ── Database Connection ──
function db(): mysqli {
    global $host, $user, $pass, $dbname, $port;

    static $conn = null;

    if ($conn === null) {
        $conn = new mysqli(
            $host,
            $user,
            $pass,
            $dbname,
            (int)$port
        );

        if ($conn->connect_error) {
            http_response_code(500);

            die(json_encode([
                'error' => 'Database connection failed',
                'details' => $conn->connect_error
            ]));
        }

        $conn->set_charset('utf8mb4');
    }

    return $conn;
}

// ── Auth Guard ──
function require_login(): void {
    if (empty($_SESSION['admin_id'])) {
        http_response_code(401);

        echo json_encode([
            'error' => 'Unauthorized'
        ]);

        exit;
    }
}

// ── JSON Helper ──
function json_out(array $data, int $status = 200): void {
    http_response_code($status);

    header('Content-Type: application/json');

    echo json_encode($data);

    exit;
}