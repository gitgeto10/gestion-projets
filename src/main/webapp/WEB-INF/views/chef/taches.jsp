<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mycompany.gestion.projets.model.Tache"%>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur"%>
<%@ page import="com.mycompany.gestion.projets.model.Project"%>
<%@ page import="com.mycompany.gestion.projets.service.ProjectService"%>
<%@ page import="com.mycompany.gestion.projets.service.UtilisateurService"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    List<Tache> taches = (List<Tache>) request.getAttribute("taches");
    if (taches == null) taches = new java.util.ArrayList<>();

    WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProjectService projectService = ctx.getBean(ProjectService.class);
    UtilisateurService utilisateurService = ctx.getBean(UtilisateurService.class);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Liste des Tâches</title>
    <!-- Styles similaires à ta page Projets -->
</head>

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
        background-color: #caf0f8;
        min-height: 100vh;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #000000;
    }

    /* Dashboard Cards */
    .dashboard-container {
        display: grid;
        grid-template-columns: repeat(auto-fit,minmax(280px,1fr));
        gap: 2.5rem;
    }
</style>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">Chef de projet</div>
    <div class="nav-links">
        <form action="/logout" method="post" style="display:inline;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/chef/dashboard">Dashboard</a></li>
        <li><a href="/chef/taches" class="active">Taches</a></li>
        <li><a href="/chef/projets" >Projets</a></li>
        <li><a href="/chef/profil" >Profile</a></li>
    </ul>
</div>

<!-- Navbar & sidebar identiques -->

<div class="main-content">
    <h1>Liste des Tâches</h1>
    <div class="ajouter-container">
        <a href="${pageContext.request.contextPath}/chef/taches/ajouter" class="btn-ajouter">Ajouter une tâche</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th><th>Nom</th><th>Durée</th><th>État</th><th>Projet</th><th>Membre</th><th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Tache t : taches) {
                Project p = projectService.findById(t.getProjetId());
                Utilisateur u = utilisateurService.findById(t.getMembreId());
                String nomProjet = (p != null ? p.getNom() : "Non défini");
                String nomMembre = (u != null ? u.getNom() : "Non assigné");
        %>
        <tr>
            <td><%= t.getId() %></td>
            <td><%= t.getNom() %></td>
            <td><%= t.getDureeEstimee() != null ? (t.getDureeEstimee()+" j") : "-" %></td>
            <td><%= t.getEtat() %></td>
            <td><%= nomProjet %></td>
            <td><%= nomMembre %></td>
            <td>
                <a href="${pageContext.request.contextPath}/chef/taches/modifier?id=<%=t.getId()%>" class="action-btn edit-btn">Modifier</a>
                <a href="${pageContext.request.contextPath}/chef/taches/supprimer?id=<%=t.getId()%>" class="action-btn delete-btn"
                   onclick="return confirm('Supprimer cette tâche ?');">Supprimer</a>
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
