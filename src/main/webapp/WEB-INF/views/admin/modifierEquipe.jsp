<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("equipes.jsp");
        return;
    }

    // Exemple fictif : récupérer les infos de l'équipe par id
    // Equipe equipe = equipeDao.getEquipeById(id);
    // String nomEquipe = equipe.getNom();
    // String description = equipe.getDescription();
    // String chefEquipe = equipe.getChefEquipe();

    // Pour l’instant tu peux utiliser les paramètres GET (moins sûr)
    String nomEquipe = request.getParameter("nom");
    String description = request.getParameter("description");
    String chefEquipe = request.getParameter("chefEquipe");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier une Équipe</title>
    <style>
        /* Copie le style de ta page utilisateur pour garder cohérence */
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
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 70px);
        }
        .form-box {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        input, textarea, select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        textarea {
            resize: vertical;
            height: 80px;
        }
        .btn-submit {
            width: 100%;
            padding: 0.7rem;
            border: none;
            background-color: #393258;
            color: white;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 1rem;
        }
        .btn-submit:hover {
            background-color: #2a2442;
        }
        .back-link {
            display: block;
            margin-top: 1rem;
            text-align: center;
            color: #444;
            text-decoration: none;
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
        <li><a href="/admin/projets">Projets</a></li>
        <li><a href="/admin/equipes" class="active">Équipes</a></li>
        <li><a href="/admin/profil">Profil</a></li>
    </ul>
</div>

<div class="container">
    <div class="form-box">
        <h1>Modifier une Équipe</h1>

        <form:form modelAttribute="equipe" method="post" action="${pageContext.request.contextPath}/admin/equipes/modifier">
            <!-- Champ caché pour l'id -->
            <input type="hidden" name="id" value="${equipe.id}" />

            <div class="form-group">
                <label for="nom">Nom de l'équipe :</label>
                <input type="text" id="nom" name="nom" required autocomplete="off" value="${equipe.nom}" />
            </div>

            

            <button type="submit" class="btn-submit">Modifier</button>
        </form:form>

        <a href="${pageContext.request.contextPath}/admin/equipes" class="back-link">← Retour</a>
    </div>
</div>

</body>
</html>
