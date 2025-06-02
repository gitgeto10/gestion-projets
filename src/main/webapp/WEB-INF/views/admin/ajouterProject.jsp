<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.gestion.projets.model.Equipe" %>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>

<%
    List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
    List<Utilisateur> chefsProjets = (List<Utilisateur>) request.getAttribute("chefsProjets");
    if (equipes == null) equipes = new java.util.ArrayList<>();
    if (chefsProjets == null) chefsProjets = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Projet</title>
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
        }

        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 220px;
            height: calc(100% - 60px);
            background-color: #201b36;
            padding-top: 1.5rem;
        }

        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }

        .sidebar ul li a {
            color: #caf0f8;
            text-decoration: none;
            display: block;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            border-left: 5px solid transparent;
            transition: background-color 0.3s ease;
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

        .form-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 800px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        input[type="text"], input[type="date"], select, textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        .btn-submit {
            background-color: #393258;
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            font-size: 1rem;
            margin-right: 1rem;
        }

        .btn-submit:hover {
            background-color: #006f4f;
        }

        .btn-cancel {
            background-color: #6c757d;
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            font-weight: 600;
        }

        .btn-cancel:hover {
            background-color: #5a6268;
        }

        h1 {
            color: #183357;
            margin-bottom: 2rem;
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
    <h1>Ajouter un Projet</h1>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/admin/projets/ajouter" method="post">

            <div class="form-group">
                <label for="nom">Nom du projet *</label>
                <input type="text" id="nom" name="nom" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" placeholder="Description du projet..."></textarea>
            </div>

            <div class="form-group">
                <label for="dateDebut">Date de début</label>
                <input type="date" id="dateDebut" name="dateDebut">
            </div>

            <div class="form-group">
                <label for="dateFin">Date de fin</label>
                <input type="date" id="dateFin" name="dateFin">
            </div>

            <div class="form-group">
                <label for="statut">Statut</label>
                <select id="statut" name="statut">
                    <option value="">Sélectionnez un statut</option>
                    <option value="En préparation">En préparation</option>
                    <option value="En cours">En cours</option>
                    <option value="En pause">En pause</option>
                    <option value="Terminé">Terminé</option>
                    <option value="Annulé">Annulé</option>
                </select>
            </div>

            <div class="form-group">
                <label for="equipeId">Équipe assignée *</label>
                <select id="equipeId" name="equipeId" required>
                    <option value="">Sélectionnez une équipe</option>
                    <%
                        for (Equipe equipe : equipes) {
                    %>
                    <option value="<%= equipe.getId() %>"><%= equipe.getNom() %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="chefProjetId">Chef de projet *</label>
                <select id="chefProjetId" name="chefProjetId" required>
                    <option value="">Sélectionnez un chef de projet</option>
                    <%
                        for (Utilisateur utilisateur : chefsProjets) {
                            // Filtrer pour afficher seulement les chefs de projet et administrateurs
                            if ("ChefProjet".equals(utilisateur.getRole()) || "Administrateur".equals(utilisateur.getRole())) {
                    %>
                    <option value="<%= utilisateur.getId() %>"><%= utilisateur.getNom() %> (<%= utilisateur.getRole() %>)</option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <button type="submit" class="btn-submit">Ajouter le projet</button>
                <a href="${pageContext.request.contextPath}/admin/projets" class="btn-cancel">Annuler</a>
            </div>

        </form>
    </div>
</div>

</body>
</html>