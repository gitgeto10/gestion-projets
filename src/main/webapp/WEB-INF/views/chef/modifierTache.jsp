<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.mycompany.gestion.projets.model.Tache" %>
<%@ page import="com.mycompany.gestion.projets.model.Project" %>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>
<%@ page import="java.util.List" %>

<%
  Tache tache = (Tache) request.getAttribute("tache");
  List<Project> projets = (List<Project>) request.getAttribute("projets");
  List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("membres");

  if (tache == null) tache = new Tache();
  if (projets == null) projets = new java.util.ArrayList<>();
  if (utilisateurs == null) utilisateurs = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Modifier une Tâche</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 2rem; }
    .form-container {
      max-width: 600px;
      margin: auto;
      background-color: #f9f9f9;
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
      background-color: #007bff;
      color: white;
      padding: 0.7rem 2rem;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }
    .btn:hover { background-color: #0069d9; }

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
</head>
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

<h1>Modifier la Tâche</h1>

<div class="form-container">
  <form action="${pageContext.request.contextPath}/chef/taches/modifier?id=${tache.id}" method="post">

    <div class="form-group">
      <label for="nom">Nom de la tâche *</label>
      <input type="text" id="nom" name="nom" value="<%= tache.getNom() %>" required>
    </div>

    <div class="form-group">
      <label for="dureeEstimee">Durée estimée (en jours)</label>
      <input type="number" id="dureeEstimee" name="dureeEstimee" min="1" value="<%= tache.getDureeEstimee() %>">
    </div>

    <div class="form-group">
      <label for="etat">État</label>
      <select id="etat" name="etat">
        <option value="">Sélectionnez un état</option>
        <option value="À faire" <%= "À faire".equals(tache.getEtat()) ? "selected" : "" %>>À faire</option>
        <option value="En cours" <%= "En cours".equals(tache.getEtat()) ? "selected" : "" %>>En cours</option>
        <option value="Terminée" <%= "Terminée".equals(tache.getEtat()) ? "selected" : "" %>>Terminée</option>
      </select>
    </div>

    <div class="form-group">
      <label for="projetId">Projet associé *</label>
      <select id="projetId" name="projetId" required>
        <option value="">Sélectionnez un projet</option>
        <%
          for (Project projet : projets) {
            String selected = (projet.getId() == tache.getProjetId()) ? "selected" : "";
        %>
        <option value="<%= projet.getId() %>" <%= selected %>><%= projet.getNom() %></option>
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
            String selected = (utilisateur.getId() == tache.getMembreId()) ? "selected" : "";
        %>
        <option value="<%= utilisateur.getId() %>" <%= selected %>><%= utilisateur.getNom() %></option>
        <%
          }
        %>
      </select>
    </div>

    <button type="submit" class="btn">Modifier la tâche</button>

  </form>
</div>

</body>
</html>
