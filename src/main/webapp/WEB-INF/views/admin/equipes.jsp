<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.mycompany.gestion.projets.model.Equipe" %>

<%
    List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
    if (equipes == null) {
        equipes = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Gestion des Équipes</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
        }

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
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
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
            background: rgba(255,255,255,0.15);
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
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 70px;
            left: 0;
            width: 250px;
            height: calc(100% - 70px);
            background-color: #201b36;
            padding-top: 1.5rem;
            box-shadow: 3px 0 10px rgba(0,0,0,0.1);
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
            background: linear-gradient(to right, rgba(123,173,201,0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }

        /* Main content */
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

        /* Bouton Ajouter */
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
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .btn-ajouter:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(57,50,88,0.3);
        }

        .card-container {
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
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

        /* Actions boutons */
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar { width: 200px; }
            .main-content { margin-left: 200px; }
        }
        @media (max-width: 768px) {
            .sidebar { width: 70px; }
            .sidebar ul li a span { display: none; }
            .sidebar ul li a { justify-content: center; padding: 1rem; }
            .main-content { margin-left: 70px; padding: 90px 20px 20px 20px; }
            h1 { font-size: 1.5rem; }
            table { display: block; overflow-x: auto; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-users"></i>
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
        <li><a href="/admin/projets"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/admin/equipes" class="active"><i class="fas fa-user-friends"></i><span>Equipes</span></a></li>
        <li><a href="/admin/profil"><i class="fas fa-user-circle"></i><span>Profile</span></a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="header-container" style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 30px;">
        <h1><i class="fas fa-user-friends"></i> Liste des Équipes</h1>
        <a href="${pageContext.request.contextPath}/admin/equipes/ajouter" class="btn-ajouter">
            <i class="fas fa-plus"></i> Ajouter une équipe
        </a>
    </div>

    <div class="card-container">
        <c:choose>
            <c:when test="${empty equipes}">
                <div style="text-align:center; padding: 3rem; color: #666;">
                    <i class="fas fa-user-friends" style="font-size:3rem; margin-bottom:1rem; color:#7badc9;"></i>
                    <h3>Aucune équipe disponible</h3>
                    <p>Commencez par ajouter une nouvelle équipe</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="equipe" items="${equipes}">
                            <tr>
                                <td><strong>${equipe.id}</strong></td>
                                <td>${equipe.nom}</td>
                                <td>
                                    <div class="action-btns">
                                        <a href="${pageContext.request.contextPath}/admin/equipes/modifier?id=${equipe.id}"
                                           class="action-btn edit-btn" title="Modifier">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/equipes/supprimer?id=${equipe.id}"
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette équipe ?');"
                                           title="Supprimer">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
