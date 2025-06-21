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
    <meta charset="UTF-8" />
    <title>Modifier une Équipe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f5f7fa;
            min-height: 100vh;
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
        .sidebar ul li a:hover, .sidebar ul li a.active {
            background: linear-gradient(to right, rgba(123,173,201,0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }
        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;

            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        h1 {
            margin-bottom: 30px;
            color: #183357;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
            justify-content: center;
        }
        .form-container {
            max-width: 600px;
            width: 100%;
            padding: 2.5rem;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-left: 6px solid #7badc9;
        }
        .form-group {
            margin-bottom: 1.8rem;
        }
        label {
            font-weight: 600;
            color: #183357;
            display: block;
            margin-bottom: 0.6rem;
        }
        input[type="text"] {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border-radius: 10px;
            border: 1px solid #ddd;
            font-size: 1rem;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
            transition: border-color 0.3s;
        }
        input[type="text"]:focus {
            border-color: #7badc9;
            outline: none;
            box-shadow: 0 0 0 3px rgba(123,173,201,0.25);
        }
        .btn-container {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }
        .btn {
            padding: 0.9rem 2rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            color: white;
            background: linear-gradient(to right, #393258, #8382b4);
            transition: background-color 0.3s;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn:hover {
            background: linear-gradient(to right, #504575, #a2a5cb);
        }
        .btn-secondary {
            background: #f0f2f5;
            color: #555;
            padding: 0.9rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }
        .btn-secondary:hover {
            background: #e4e6e9;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-users-cog"></i>
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
        <li><a href="/admin/equipes" class="active"><i class="fas fa-user-friends"></i><span>Équipes</span></a></li>
        <li><a href="/admin/profil"><i class="fas fa-user-circle"></i><span>Profil</span></a></li>
    </ul>
</div>

<!-- Formulaire centré -->
<div class="main-content">
    <div class="form-container">
        <h1><i class="fas fa-user-edit"></i> Modifier une Équipe</h1>

        <form:form modelAttribute="equipe" method="post" action="${pageContext.request.contextPath}/admin/equipes/modifier">
            <input type="hidden" name="id" value="${equipe.id}" />

            <div class="form-group">
                <label for="nom">Nom de l'équipe :</label>
                <input type="text" id="nom" name="nom" required autocomplete="off" value="${equipe.nom}" />
            </div>

            <div class="btn-container">
                <button type="submit" class="btn">
                    <i class="fas fa-edit"></i> Modifier
                </button>
                <a href="${pageContext.request.contextPath}/admin/equipes" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
            </div>
        </form:form>
    </div>
</div>

</body>
</html>
