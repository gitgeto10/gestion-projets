<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.mycompany.gestion.projets.model.Project" %>
<%@ page import="com.mycompany.gestion.projets.model.Equipe" %>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur" %>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Modifier Projet</title>
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
      margin-bottom: 30px;
      color: #183357;
    }

    .form-container {
      background-color: white;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      max-width: 600px;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 600;
      color: #183357;
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

    select {
      cursor: pointer;
    }

    .btn-container {
      display: flex;
      gap: 1rem;
      margin-top: 2rem;
    }

    .btn {
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      text-align: center;
    }

    .btn-primary {
      background-color: #393258;
      color: white;
    }

    .btn-primary:hover {
      background-color: #2a2440;
    }

    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
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
  <h1>Modifier Projet</h1>

  <div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/projets/modifier" method="post">
      <input type="hidden" name="id" value="${project.id}" />

      <div class="form-group">
        <label for="nom">Nom du projet *</label>
        <input type="text" id="nom" name="nom" value="${project.nom}" required />
      </div>

      <div class="form-group">
        <label for="description">Description</label>
        <textarea id="description" name="description" placeholder="Description du projet...">${project.description}</textarea>
      </div>

      <div class="form-group">
        <label for="dateDebut">Date de début</label>
        <input type="date" id="dateDebut" name="dateDebut"
               value="${project.dateDebut != null ? String.valueOf(project.dateDebut).substring(0,10) : ''}" />
      </div>

      <div class="form-group">
        <label for="dateFin">Date de fin</label>
        <input type="date" id="dateFin" name="dateFin"
               value="${project.dateFin != null ? String.valueOf(project.dateFin).substring(0,10) : ''}" />
      </div>

      <div class="form-group">
        <label for="statut">Statut</label>
        <select id="statut" name="statut">
          <option value="">-- Sélectionner un statut --</option>
          <option value="En attente" ${project.statut == 'En attente' ? 'selected' : ''}>En attente</option>
          <option value="En cours" ${project.statut == 'En cours' ? 'selected' : ''}>En cours</option>
          <option value="Terminé" ${project.statut == 'Terminé' ? 'selected' : ''}>Terminé</option>
          <option value="Annulé" ${project.statut == 'Annulé' ? 'selected' : ''}>Annulé</option>
        </select>
      </div>

      <div class="form-group">
        <label for="equipeId">Équipe *</label>
        <select id="equipeId" name="equipeId" required>
          <option value="">-- Sélectionner une équipe --</option>
          <c:forEach var="equipe" items="${equipes}">
            <option value="${equipe.id}" ${project.equipeId == equipe.id ? 'selected' : ''}>
                ${equipe.nom}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="chefProjetId">Chef de projet *</label>
        <select id="chefProjetId" name="chefProjetId" required>
          <option value="">-- Sélectionner un chef de projet --</option>
          <c:forEach var="chef" items="${chefsProjets}">
            <option value="${chef.id}" ${project.chefProjetId == chef.id ? 'selected' : ''}>
                ${chef.nom} (${chef.role})
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="btn-container">
        <button type="submit" class="btn btn-primary">Modifier le projet</button>
        <a href="${pageContext.request.contextPath}/admin/projets" class="btn btn-secondary">Annuler</a>
      </div>
    </form>
  </div>
</div>

</body>
</html>