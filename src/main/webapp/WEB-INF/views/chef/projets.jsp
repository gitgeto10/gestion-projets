<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.mycompany.gestion.projets.model.Project" %>
<%@ page import="com.mycompany.gestion.projets.model.Equipe" %>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>
<%@ page import="com.mycompany.gestion.projets.service.EquipeService" %>
<%@ page import="com.mycompany.gestion.projets.service.UtilisateurService" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>

<%
    List<Project> projets = (List<Project>) request.getAttribute("projets");
    if (projets == null) {
        projets = new java.util.ArrayList<>();
    }

    WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
    EquipeService equipeService = context.getBean(EquipeService.class);
    UtilisateurService utilisateurService = context.getBean(UtilisateurService.class);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Projets</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #393258;
            --secondary-color: #8382b4;
            --accent-color: #7badc9;
            --light-bg: #f8f9fa;
            --dark-text: #183357;
            --danger: #d90429;
            --success: #6cc556;
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

        /* Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.8rem;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-add {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(57, 50, 88, 0.3);
        }

        /* Table */
        .projects-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .projects-table th {
            background: linear-gradient(to right, #96bbcf, #8382b4);
            color: white;
            padding: 1.2rem 1.5rem;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        .projects-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            color: #555;
        }

        .projects-table tr:last-child td {
            border-bottom: none;
        }

        .projects-table tr:hover {
            background-color: rgba(123, 173, 201, 0.05);
        }

        /* Status badges */
        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-en-cours {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-termine {
            background-color: #d4edda;
            color: #155724;
        }

        .status-a-faire {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-retard {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Action buttons */
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            padding: 0.5rem;
            border-radius: 8px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            width: 34px;
            height: 34px;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-view {
            background-color: var(--accent-color);
        }

        .btn-edit {
            background-color: var(--success);
        }

        .btn-delete {
            background-color: var(--danger);
        }

        /* Responsive */
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

            .projects-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-project-diagram"></i>
        <span>Chef de Projet</span>
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
        <li><a href="/chef/dashboard"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/chef/taches"><i class="fas fa-tasks"></i><span>Tâches</span></a></li>
        <li><a href="/chef/projets" class="active"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/chef/profil"><i class="fas fa-user-circle"></i><span>Profil</span></a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-project-diagram"></i>
            Liste des Projets
        </h1>
    </div>

    <table class="projects-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Date Début</th>
            <th>Date Fin</th>
            <th>Statut</th>
            <th>Équipe</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Project projet : projets) {
                Equipe equipe = equipeService.findById(projet.getEquipeId());
                Utilisateur chefProjet = utilisateurService.findById(projet.getChefProjetId());

                String nomEquipe = (equipe != null) ? equipe.getNom() : "Non assignée";
                String nomChef = (chefProjet != null) ? chefProjet.getNom() : "Non assigné";

                // Déterminer la classe CSS pour le statut
                String statusClass = "";
                if (projet.getStatut() != null) {
                    switch (projet.getStatut().toLowerCase()) {
                        case "en cours":
                            statusClass = "status-en-cours";
                            break;
                        case "terminé":
                            statusClass = "status-termine";
                            break;
                        case "en retard":
                            statusClass = "status-retard";
                            break;
                        default:
                            statusClass = "status-a-faire";
                    }
                }
        %>
        <tr>
            <td><%= projet.getId() %></td>
            <td><strong><%= projet.getNom() %></strong></td>
            <td><%= projet.getDescription() != null ? projet.getDescription() : "-" %></td>
            <td><%= projet.getDateDebut() != null ? projet.getDateDebut() : "-" %></td>
            <td><%= projet.getDateFin() != null ? projet.getDateFin() : "-" %></td>
            <td>
                <% if (projet.getStatut() != null && !projet.getStatut().isEmpty()) { %>
                <span class="status-badge <%= statusClass %>">
                            <%= projet.getStatut() %>
                        </span>
                <% } else { %>
                -
                <% } %>
            </td>
            <td><%= nomEquipe %></td>

        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>