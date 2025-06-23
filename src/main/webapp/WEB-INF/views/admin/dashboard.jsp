<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8" />
<title>Dashboard Admin</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<style>
    * {
        margin:0; padding:0; box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    body {
        background-color: #f5f7fa;
    }
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
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        flex-wrap: wrap;
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
        background: rgba(255,255,255,0.15);
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
        box-shadow: 0 2px 4px rgba(0,0,0,0.3);
    }
    .btn-logout:hover {
        background: rgba(255,255,255,0.25);
        transform: translateY(-2px);
    }

    /* Sidebar */
    .sidebar {
        position: fixed;
        top: 70px;
        left: 0;
        width: 250px;
        height: calc(100% - 70px);
        background-color: #201b36;
        padding-top: 1.5rem;
        box-shadow: 3px 0 10px rgba(0,0,0,0.1);
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
        font-size: 1.1rem;
    }
    .sidebar ul li a i {
        width: 24px;
        text-align: center;
        font-size: 1.1rem;
    }
    .sidebar ul li a:hover, .sidebar ul li a.active {
        background: linear-gradient(to right, rgba(123,173,201,0.3), transparent);
        border-left: 4px solid #7badc9;
        color: white;
    }

    /* Main content */
    .main-content {
        margin-left: 250px;
        padding: 100px 40px 40px 40px;
        min-height: 100vh;
        background-color: #f2f7f8;
        color: #183357;
    }

    h1 {
        margin-bottom: 40px;
        font-weight: 700;
        font-size: 2rem;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    h1 i {
        color: #8382b4;
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
        color: #183357;
        transition: transform 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
    .card:hover {
        transform: translateY(-6px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }
    .card h3 {
        font-weight: 700;
        font-size: 1.4rem;
        display: flex;
        align-items: center;
        gap: 10px;
        color: #394867;
    }
    .card h3 i {
        color: #7badc9;
        font-size: 1.6rem;
    }
    .card p {
        font-size: 1.2rem;
        font-weight: 600;
        color: #555;
    }

    /* Responsive */
    @media(max-width: 768px) {
        .sidebar {
            position: relative;
            width: 100%;
            height: auto;
            top: 0;
            box-shadow: none;
        }
        .main-content {
            margin-left: 0;
            padding-top: 120px;
        }
        .navbar {
            flex-wrap: wrap;
        }
        .dashboard-container {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-tachometer-alt"></i>
        <span>AdminPanel</span>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/admin/dashboard" class="active"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/admin/utilisateurs"><i class="fas fa-users"></i><span>Utilisateurs</span></a></li>
        <li><a href="/admin/projets"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/admin/equipes"><i class="fas fa-user-friends"></i><span>Equipes</span></a></li>
        <li><a href="/admin/profil"><i class="fas fa-user-circle"></i><span>Profile</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <h1><i class="fas fa-tachometer-alt"></i> Tableau de bord Admin</h1>

    <div class="dashboard-container">
        <div class="card">
            <h3><i class="fas fa-users"></i> Utilisateurs</h3>
            <p>Nombre total : ${totalUtilisateurs}</p>
        </div>
        <div class="card">
            <h3><i class="fas fa-project-diagram"></i> Projets</h3>
            <p>Nombre total : ${totalProjets}</p>
        </div>
        <div class="card">
            <h3><i class="fas fa-user-friends"></i> Equipes</h3>
            <p>Nombre total : ${totalEquipes}</p>
        </div>
            <div class="card">
                <h3><i class="fas fa-tasks"></i> Aujourd'hui</h3>
                <div class="card-footer" id="date-time">Chargement...</div>
            </div>
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
