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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #393258;
      --secondary-color: #6d67a5;
      --accent-color: #7badc9;
      --light-bg: #f8f9fa;
      --dark-text: #183357;
      --success: #4CAF50;
      --danger: #d90429;
      --warning: #FF9800;
      --info: #2196F3;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: #f5f7fa;
      color: #333;
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
      background-color:  #201b36;
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
      border-left: 4px solid var(--accent-color);
      color: white;
    }

    .main-content {
      margin-left: 250px;
      padding: 100px 40px 40px 40px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center; /* Centrage horizontal */
    }

    .page-title {
      margin-bottom: 30px;
      color: var(--dark-text);
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 12px;
      width: 100%;
      max-width: 700px; /* Largeur cohérente avec le formulaire */
    }

    .form-container {
      background: linear-gradient(145deg, #ffffff, #f8f9fa);
      padding: 2.5rem;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      max-width: 700px;
      width: 100%;
      border: 1px solid rgba(0, 0, 0, 0.05);
      position: relative;
      overflow: hidden;
    }

    .form-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 6px;
      height: 100%;
      background: linear-gradient(to bottom, var(--accent-color), var(--secondary-color));
    }

    .form-header {
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    }

    .form-header h2 {
      color: var(--primary-color);
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .form-group {
      margin-bottom: 1.8rem;
      position: relative;
    }

    label {
      display: block;
      margin-bottom: 0.6rem;
      font-weight: 600;
      color: var(--dark-text);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    label i {
      color: var(--accent-color);
    }

    input[type="text"], input[type="date"], select, textarea {
      width: 100%;
      padding: 0.9rem 1.2rem;
      border: 1px solid #ddd;
      border-radius: 10px;
      font-size: 1rem;
      background-color: #fff;
      transition: all 0.3s;
      box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    input[type="text"]:focus, input[type="date"]:focus, select:focus, textarea:focus {
      border-color: var(--accent-color);
      outline: none;
      box-shadow: 0 0 0 3px rgba(123, 173, 201, 0.25);
    }

    textarea {
      height: 120px;
      resize: vertical;
    }

    select {
      appearance: none;
      background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
      background-repeat: no-repeat;
      background-position: right 1rem center;
      background-size: 1rem;
      padding-right: 2.5rem;
      cursor: pointer;
    }

    .required-field::after {
      content: " *";
      color: var(--danger);
    }

    .btn-container {
      display: flex;
      gap: 1.2rem;
      margin-top: 2.5rem;
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

    .btn-secondary {
      background: #f0f2f5;
      color: #555;
    }

    .btn-secondary:hover {
      background: #e4e6e9;
      transform: translateY(-3px);
    }

    .status-indicator {
      display: inline-block;
      padding: 0.5rem 1.2rem;
      border-radius: 20px;
      font-weight: 600;
      margin-left: 1rem;
      background-color: rgba(0, 0, 0, 0.05);
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
      .form-container {
        padding: 1.5rem;
      }
      .btn-container {
        flex-direction: column;
      }
      .btn {
        width: 100%;
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
  <h1 class="page-title">
    <i class="fas fa-edit"></i>
    Modifier Projet
    <span class="status-indicator">ID: ${project.id}</span>
  </h1>

  <div class="form-container">
    <div class="form-header">
      <h2>
        <i class="fas fa-pencil-alt"></i>
        Modifier les détails du projet
      </h2>
    </div>

    <form action="${pageContext.request.contextPath}/admin/projets/modifier" method="post">
      <input type="hidden" name="id" value="${project.id}" />

      <div class="form-group">
        <label for="nom">
          <i class="fas fa-tag"></i>
          <span class="required-field">Nom du projet</span>
        </label>
        <input type="text" id="nom" name="nom" value="${project.nom}" required />
      </div>

      <div class="form-group">
        <label for="description">
          <i class="fas fa-align-left"></i>
          <span>Description</span>
        </label>
        <textarea id="description" name="description" placeholder="Description du projet...">${project.description}</textarea>
      </div>

      <div class="form-group">
        <label for="dateDebut">
          <i class="fas fa-calendar-alt"></i>
          <span>Date de début</span>
        </label>
        <input type="date" id="dateDebut" name="dateDebut"
               value="${project.dateDebut != null ? String.valueOf(project.dateDebut).substring(0,10) : ''}" />
      </div>

      <div class="form-group">
        <label for="dateFin">
          <i class="fas fa-calendar-check"></i>
          <span>Date de fin</span>
        </label>
        <input type="date" id="dateFin" name="dateFin"
               value="${project.dateFin != null ? String.valueOf(project.dateFin).substring(0,10) : ''}" />
      </div>

      <div class="form-group">
        <label for="statut">
          <i class="fas fa-chart-line"></i>
          <span>Statut</span>
        </label>
        <select id="statut" name="statut">
          <option value="">-- Sélectionner un statut --</option>
          <option value="En attente" ${project.statut == 'En attente' ? 'selected' : ''}>En attente</option>
          <option value="En cours" ${project.statut == 'En cours' ? 'selected' : ''}>En cours</option>
          <option value="Terminé" ${project.statut == 'Terminé' ? 'selected' : ''}>Terminé</option>
          <option value="Annulé" ${project.statut == 'Annulé' ? 'selected' : ''}>Annulé</option>
        </select>
      </div>

      <div class="form-group">
        <label for="equipeId">
          <i class="fas fa-users"></i>
          <span class="required-field">Équipe</span>
        </label>
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
        <label for="chefProjetId">
          <i class="fas fa-user-tie"></i>
          <span class="required-field">Chef de projet</span>
        </label>
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
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-save"></i>
          Modifier le projet
        </button>
        <a href="${pageContext.request.contextPath}/admin/projets" class="btn btn-secondary">
          <i class="fas fa-times"></i>
          Annuler
        </a>
      </div>
    </form>
  </div>
</div>

</body>
</html>