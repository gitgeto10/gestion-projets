<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    String nom = utilisateur != null ? utilisateur.getNom() : "";
    String email = utilisateur != null ? utilisateur.getEmail() : "";
    String role = utilisateur != null ? utilisateur.getRole() : "";

    if (nom == null || email == null || role == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Profil Chef</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #393258;
            --secondary-color: #8382b4;
            --accent-color: #7badc9;
            --light-bg: #f8f9fa;
            --dark-text: #183357;
            --danger: #d90429;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
        }

        /* Navbar - Identique à votre code */
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

        /* Sidebar - Identique à votre code */
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

        .sidebar ul li a i {
            width: 24px;
            text-align: center;
            font-size: 1.1rem;
        }

        .sidebar ul li a:hover, .sidebar ul li a.active {
            background: linear-gradient(to right, rgba(123, 173, 201, 0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }

        /* Contenu principal */
        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;
        }

        /* Styles spécifiques au profil */
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 2.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .profile-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, #7badc9, #8382b4);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.08);
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #96bbcf, #8382b4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            margin-right: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-title {
            font-size: 1.8rem;
            color: var(--dark-text);
            margin: 0;
        }

        .profile-role {
            color: var(--secondary-color);
            font-weight: 500;
            margin-top: 0.5rem;
        }

        .profile-section {
            margin-bottom: 2rem;
        }

        .profile-section-title {
            font-size: 1.3rem;
            color: var(--dark-text);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .profile-field {
            margin-bottom: 1.5rem;
        }

        .profile-label {
            font-weight: 600;
            color: var(--secondary-color);
            display: block;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .profile-label i {
            color: var(--accent-color);
            width: 20px;
        }

        .profile-value {
            padding: 0.9rem 1.2rem;
            background-color: #fff;
            border-radius: 10px;
            border: 1px solid #eee;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .btn-container {
            display: flex;
            gap: 1.2rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.08);
        }

        .btn {
            padding: 0.9rem 1.8rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
            font-size: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(57, 50, 88, 0.3);
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 200px;
            }
            .main-content {
                margin-left: 200px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }
            .sidebar ul li a span {
                display: none;
            }
            .sidebar ul li a {
                justify-content: center;
                padding: 1rem;
            }
            .main-content {
                margin-left: 70px;
                padding: 90px 20px 20px 20px;
            }

            .profile-grid {
                grid-template-columns: 1fr;
            }

            .profile-header {
                flex-direction: column;
                text-align: center;
            }

            .profile-avatar {
                margin-right: 0;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo">
        <i class="fas fa-user-tie"></i>
        <span>Chef de Projet</span>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </button>
    </form>
</div>

<div class="sidebar">
    <ul>
        <li><a href="/chef/dashboard"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/chef/taches"><i class="fas fa-tasks"></i><span>Tâches</span></a></li>
        <li><a href="/chef/projets"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/chef/profil" class="active"><i class="fas fa-user-circle"></i><span>Profil</span></a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-avatar">
                <%= nom.substring(0, 1).toUpperCase() %>
            </div>
            <div>
                <h1 class="profile-title"><%= nom %></h1>
                <div class="profile-role"><%= role %></div>
            </div>
        </div>

        <div class="profile-section">
            <h2 class="profile-section-title">
                <i class="fas fa-id-card"></i>
                Informations personnelles
            </h2>

            <div class="profile-grid">
                <div class="profile-field">
                    <span class="profile-label">
                        <i class="fas fa-user"></i>
                        Nom complet
                    </span>
                    <div class="profile-value"><%= nom %></div>
                </div>

                <div class="profile-field">
                    <span class="profile-label">
                        <i class="fas fa-envelope"></i>
                        Email
                    </span>
                    <div class="profile-value"><%= email %></div>
                </div>

                <div class="profile-field">
                    <span class="profile-label">
                        <i class="fas fa-user-tag"></i>
                        Rôle
                    </span>
                    <div class="profile-value"><%= role %></div>
                </div>

            
            </div>
        </div>

    </div>
</div>

</body>
</html>