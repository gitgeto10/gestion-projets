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
    <style>
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

        .sidebar {
            position: fixed;
            top: 60px;
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
        .main-content {
            margin-left: 240px;
            padding: 90px 40px 40px 40px;
        }

        h1 {
            margin-bottom: 20px;
            color: #183357;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        th {
            background-color: #7badc9;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-btn {
            padding: 0.4rem 0.8rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            margin-right: 5px;
            text-decoration: none;
            display: inline-block;
        }

        .edit-btn {
            background-color: #6cc556;
            color: white;
        }

        .delete-btn {
            background-color: #d90429;
            color: white;
        }

        .view-btn {
            background-color: #0077be;
            color: white;
        }

        .ajouter-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        .btn-ajouter {
            background-color: #393258;
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn-ajouter:hover {
            background-color: #006f4f;
        }

    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">AdminPanel</div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">Déconnexion</button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/admin/dashboard">Dashboard</a></li>
        <li><a href="/admin/utilisateurs">Utilisateurs</a></li>
        <li><a href="/admin/projets" class="active">Projets</a></li>
        <li><a href="/admin/equipes">Equipes</a></li>
        <li><a href="/admin/profil">Profile</a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <h1>Liste des Projets</h1>
    <div class="ajouter-container">
        <a href="${pageContext.request.contextPath}/admin/projets/ajouter" class="btn-ajouter">Ajouter un projet</a>
    </div>

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
        %>
        <tr>
            <td><%= projet.getId() %></td>
            <td><%= projet.getNom() %></td>
            <td><%= projet.getDescription() != null ? projet.getDescription() : "" %></td>
            <td><%= projet.getDateDebut() != null ? projet.getDateDebut() : "" %></td>
            <td><%= projet.getDateFin() != null ? projet.getDateFin() : "" %></td>
            <td><%= projet.getStatut() != null ? projet.getStatut() : "" %></td>
            <td><%= nomEquipe %></td>
            <td><%= nomChef %></td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/projets/details?id=<%= projet.getId() %>" class="action-btn view-btn">Voir</a>
                <a href="${pageContext.request.contextPath}/admin/projets/modifier?id=<%= projet.getId() %>" class="action-btn edit-btn">Modifier</a>
                <a href="${pageContext.request.contextPath}/admin/projets/supprimer?id=<%= projet.getId() %>" class="action-btn delete-btn" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>