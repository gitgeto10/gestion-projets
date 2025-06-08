<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.gestion.projets.model.Project" %>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>

<%
    List<Project> projets = (List<Project>) request.getAttribute("projets");
    List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("membres");

    if (projets == null) projets = new java.util.ArrayList<>();
    if (utilisateurs == null) utilisateurs = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Tâche</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 2rem; }
        .form-container {
            max-width: 600px;
            margin: auto;
            background-color: #f7f7f7;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 1.5rem; }
        label { font-weight: bold; display: block; margin-bottom: 0.5rem; }
        input, select {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 0.7rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn:hover { background-color: #45a049; }
    </style>
</head>
<body>

<h1>Ajouter une Tâche</h1>

<div class="form-container">
    <form action="${pageContext.request.contextPath}/chef/taches/ajouter" method="post">

        <div class="form-group">
            <label for="nom">Nom de la tâche *</label>
            <input type="text" id="nom" name="nom" required>
        </div>

        <div class="form-group">
            <label for="dureeEstimee">Durée estimée (en jours)</label>
            <input type="number" id="dureeEstimee" name="dureeEstimee" min="1">
        </div>

        <div class="form-group">
            <label for="etat">État</label>
            <select id="etat" name="etat">
                <option value="">Sélectionnez un état</option>
                <option value="À faire">À faire</option>
                <option value="En cours">En cours</option>
                <option value="Terminée">Terminée</option>
            </select>
        </div>

        <div class="form-group">
            <label for="projetId">Projet associé *</label>
            <select id="projetId" name="projetId" required>
                <option value="">Sélectionnez un projet</option>
                <%
                    for (Project projet : projets) {
                %>
                <option value="<%= projet.getId() %>"><%= projet.getNom() %></option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label for="membreId">Membre assigné *</label>
            <select id="membreId" name="membreId" required>
                <option value="">Sélectionnez un utilisateur</option>
                <%
                    for (Utilisateur utilisateur : utilisateurs) {
                %>
                <option value="<%= utilisateur.getId() %>"><%= utilisateur.getNom() %></option>
                <%
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn">Ajouter la tâche</button>

    </form>
</div>

</body>
</html>
