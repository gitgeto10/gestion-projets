<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Dashboard Membre</title>
    <style>
    /* Navbar */
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
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          box-shadow: 0 2px 6px rgba(0,0,0,0.3);
          flex-wrap: wrap;
       }
        .logo {
            font-weight: 700;
            font-size: 1.6rem;
            letter-spacing: 2px;
        }

        /* Bouton déconnexion */
        .btn-logout {
            background-color: #0c0c0c;
            color: white;
            padding: 0.5rem 1rem;
            font-weight: 600;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .btn-logout:hover {
            background-color: #d90429;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 60px; /* hauteur navbar */
            left: 0;
            width: 220px;
            height: calc(100% - 60px);
            background-color: #201b36;
            padding-top: 1.5rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }

        .sidebar ul li {
            margin: 1.2rem 0;
        }

        .sidebar ul li a {
            color: #caf0f8;
            text-decoration: none;
            display: block;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            border-left: 5px solid transparent;
            transition: background-color 0.3s ease, border-left 0.3s ease;
            font-size: 1.1rem;
        }

        .sidebar ul li a:hover, .sidebar ul li a.active {
            background-color: #7badc9;
            border-left: 5px solid #0a024d;
            color: white;
        }


/* Main Content */
.main-content {
    margin-left: 240px;
    padding: 90px 40px 40px 40px;
    background-color: #F0F4EF;
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #1B1B2F;
}

/* Dashboard Cards */
.dashboard-container {
    display: grid;
    grid-template-columns: repeat(auto-fit,minmax(280px,1fr));
    gap: 2.5rem;
}
.card {
    background-color: white;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}
.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}
.card h3 {
    margin-bottom: 1rem;
    font-weight: 700;
    font-size: 1.4rem;
    color: #615544;
}
.card p {
    font-size: 1.2rem;
    font-weight: 600;
    color: #1B1B2F;
}

    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="logo">Espace Membre</div>
        <div class="nav-links">
            <form action="/logout" method="post" style="display:inline;">
                <button type="submit" class="btn-logout">Déconnexion</button>
            </form>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="/membre/dashboard" class="active">Dashboard</a></li>
            <li><a href="/membre/mesTaches">Mes Tâches</a></li>
            <li><a href="/membre/profil">Profil</a></li>
        </ul>
    </div>

<!-- Main Content -->
<div class="main-content">
    <h1>Tableau de bord Membre</h1>

    <div class="dashboard-container">
        <div class="card">
            <h3>Tâches attribuées</h3>
            <p>Vous avez <strong><c:out value="${tacheCount}" /></strong> tâches à réaliser.</p>
        </div>
        <div class="card">
            <h3>Projets actifs</h3>
            <p>Vous participez à <strong><c:out value="${projetCount}" /></strong> projets.</p>
        </div>
    </div>
</div>

</body>
</html>
