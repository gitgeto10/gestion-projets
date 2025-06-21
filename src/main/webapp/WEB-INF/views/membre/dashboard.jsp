<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Dashboard Membre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f4ef;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, #96bbcf, #8382b4);
            padding: 1rem 2rem;
            color: white;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .logo {
            font-weight: 700;
            font-size: 1.6rem;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            font-size: 1.8rem;
        }

        .btn-logout {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            border-radius: 30px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        .sidebar {
            position: fixed;
            top: 70px;
            left: 0;
            width: 250px;
            height: calc(100% - 70px);
            background-color: #201b36;
            padding-top: 1.5rem;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }

        .sidebar ul li {
            margin: 1rem 0;
        }

        .sidebar ul li a {
            color: #e0e0ff;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            font-weight: 500;
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
            gap: 12px;
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background: linear-gradient(to right, rgba(123, 173, 201, 0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }

        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;
        }

        h1 {
            color: #183357;
            font-size: 2rem;
            margin-bottom: 2rem;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .card {
            background-color: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            background-color: #f0f4ff;
        }

        .card h3 {
            margin-bottom: 1rem;
            font-weight: 700;
            font-size: 1.4rem;
            color: #615544;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card p {
            font-size: 1.2rem;
            font-weight: 500;
            color: #1b1b2f;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="logo"><i class="bi bi-person-badge"></i> Espace Membre</div>
        <form action="/logout" method="post" style="display:inline;">
            <button type="submit" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Déconnexion
            </button>
        </form>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="/membre/dashboard" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="/membre/mesTaches"><i class="bi bi-list-check"></i> Mes Tâches</a></li>
            <li><a href="/membre/profil"><i class="bi bi-person-circle"></i> Profil</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1><i class="bi bi-house-door-fill"></i> Tableau de bord Membre</h1>

        <div class="dashboard-container">
            <div class="card">
                <h3><i class="bi bi-clipboard-check"></i> Tâches attribuées</h3>
                <p>Vous avez <strong><c:out value="${tacheCount}" /></strong> tâches à réaliser.</p>
            </div>
            <div class="card">
                <h3><i class="bi bi-folder-check"></i> Projets actifs</h3>
                <p>Vous participez à <strong><c:out value="${projetCount}" /></strong> projets.</p>
            </div>
            <div class="card">
                <h3><i class="bi bi-calendar-event"></i> Aujourd'hui</h3>
                <p id="date-time">Chargement...</p>
            </div>
        </div>
    </div>

    <script>
        // Affiche la date/heure actuelles en français
        const dtElement = document.getElementById("date-time");
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        dtElement.innerText = now.toLocaleDateString('fr-FR', options) + " - " + now.toLocaleTimeString('fr-FR');
    </script>

</body>
</html>
