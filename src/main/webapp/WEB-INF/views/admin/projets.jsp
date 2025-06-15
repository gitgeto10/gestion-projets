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

    // Récupération des services pour afficher les noms
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
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
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

        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;
        }

        h1 {
            margin-bottom: 30px;
            color: #183357;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .btn-ajouter {
            background: linear-gradient(to right, #393258, #8382b4);
            color: white;
            padding: 0.9rem 1.8rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-ajouter:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(57, 50, 88, 0.3);
        }

        .card-container {
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            padding: 1.2rem;
            text-align: left;
            border-bottom: 1px solid #f0f2f5;
        }

        th {
            background-color: #f8f9fa;
            color: #393258;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f8fafc;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            text-align: center;
            min-width: 100px;
        }

        .status-en_attente {
            background-color: #FF9800;
            color: white;
        }

        .status-en_cours {
            background-color: #2196F3;
            color: white;
        }

        .status-termine {
            background-color: #4CAF50;
            color: white;
        }

        .status-annule {
            background-color: #F44336;
            color: white;
        }

        .status-suspendu {
            background-color: #9E9E9E;
            color: white;
        }

        .action-btns {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 0.6rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 36px;
            height: 36px;
        }

        .edit-btn {
            background-color: #6cc556;
            color: white;
        }

        .edit-btn:hover {
            background-color: #5cb34c;
            transform: translateY(-2px);
        }

        .delete-btn {
            background-color: #d90429;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c00424;
            transform: translateY(-2px);
        }

        .no-projects {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .no-projects i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #7badc9;
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
            .header-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            table {
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
        <li><a href="/admin/dashboard"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/admin/utilisateurs"><i class="fas fa-users"></i><span>Utilisateurs</span></a></li>
        <li><a href="/admin/projets" class="active"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/admin/equipes"><i class="fas fa-user-friends"></i><span>Equipes</span></a></li>
        <li><a href="/admin/profil"><i class="fas fa-user-circle"></i><span>Profile</span></a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="header-container">
        <h1>
            <i class="fas fa-folder-open"></i>
            Liste des Projets
        </h1>
        <a href="${pageContext.request.contextPath}/admin/projets/ajouter" class="btn-ajouter">
            <i class="fas fa-plus"></i>
            Ajouter un projet
        </a>
    </div>

    <div class="card-container">
        <% if (projets.isEmpty()) { %>
        <div class="no-projects">
            <i class="fas fa-folder-open"></i>
            <h3>Aucun projet disponible</h3>
            <p>Commencez par ajouter un nouveau projet</p>
        </div>
        <% } else { %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Description</th>
                <th>Date Début</th>
                <th>Date Fin</th>
                <th>Statut</th>
                <th>Équipe</th>
                <th>Chef de Projet</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Project projet : projets) {
                    // Récupération des noms des entités liées
                    Equipe equipe = equipeService.findById(projet.getEquipeId());
                    Utilisateur chefProjet = utilisateurService.findById(projet.getChefProjetId());

                    String nomEquipe = (equipe != null) ? equipe.getNom() : "Non assignée";
                    String nomChef = (chefProjet != null) ? chefProjet.getNom() : "Non assigné";

                    // Détermination de la classe CSS en fonction du statut
                    String statut = projet.getStatut();
                    String statutClass = "status-badge ";

                    if (statut != null) {
                        switch(statut.toLowerCase()) {
                            case "en attente":
                                statutClass += "status-en_attente";
                                break;
                            case "en cours":
                                statutClass += "status-en_cours";
                                break;
                            case "terminé":
                                statutClass += "status-termine";
                                break;
                            case "annulé":
                                statutClass += "status-annule";
                                break;
                            case "suspendu":
                                statutClass += "status-suspendu";
                                break;
                            default:
                                statutClass += "status-en_attente";
                        }
                    } else {
                        statut = "Non défini";
                        statutClass += "status-en_attente";
                    }
            %>
            <tr>
                <td><strong><%= projet.getId() %></strong></td>
                <td><%= projet.getNom() %></td>
                <td><%= projet.getDescription() != null ? projet.getDescription() : "" %></td>
                <td><%= projet.getDateDebut() != null ? projet.getDateDebut() : "" %></td>
                <td><%= projet.getDateFin() != null ? projet.getDateFin() : "" %></td>
                <td><span class="<%= statutClass %>"><%= statut %></span></td>
                <td><%= nomEquipe %></td>
                <td><%= nomChef %></td>
                <td>
                    <div class="action-btns">
                        <a href="${pageContext.request.contextPath}/admin/projets/modifier?id=<%= projet.getId() %>"
                           class="action-btn edit-btn" title="Modifier">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/projets/supprimer?id=<%= projet.getId() %>"
                           class="action-btn delete-btn"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce projet ?');" title="Supprimer">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

</body>
</html>
