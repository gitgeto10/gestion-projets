<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Soumettre un Livrable</title>
<style>
        
        body {
            margin: 0; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #F0F4EF;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, #b17949, #b1825b);
            padding: 1rem 2rem;
            color: white;
            position: fixed;
            width: 100vw;
            top: 0;
            left: 0;
            z-index: 9999;
            box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        }
        .logo {
            font-weight: 700;
            font-size: 1.6rem;
            letter-spacing: 2px;
        }
        .btn-logout {
            background-color: #38200a;
            color: white;
            padding: 0.5rem 1rem;
            font-weight: 600;
            border-radius: 5px;
            margin-right: 50px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1rem;
        }
        .btn-logout:hover {
            background-color: #388E3C;
        }
        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 220px;
            height: calc(100% - 60px);
            background-color: #68370f;
            padding-top: 1.5rem;
        }
        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }
        .sidebar ul li {
            margin: 1.2rem 0;
        }
        .sidebar ul li a {
            color: #f8f8f8;
            text-decoration: none;
            display: block;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            border-left: 5px solid transparent;
            transition: background-color 0.3s ease, border-left 0.3s ease;
            font-size: 1.1rem;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #996b4d;
            border-left: 5px solid #ffffff;
        }
        .container {
            max-width: 600px;
            margin: 80px auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        h1 {
            color: #615544;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .date-depot {
            text-align: center;
            font-weight: 600;
            color: #444;
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: .5rem;
            font-weight: 600;
            color: #2B2B2B;
        }
        select, input[type="text"], input[type="file"] {
            width: 100%;
            padding: .6rem;
            margin-bottom: 1.2rem;
            border-radius: 5px;
            border: 1px solid #bbb;
            font-size: 1rem;
        }
        button {
            background-color: #7c6934;
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 700;
            width: 100%;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #2e7d32;
        }
        .message {
            margin: 1rem auto;
            padding: 1rem;
            background-color: #e0dfcb;
            color: #2e6e4c;
            border-radius: 6px;
            border: 1px solid #c3e6cb;
            text-align: center;
            max-width: 500px;
        }
    </style>
</head>
<body>

<!-- Navbar et sidebar inchangés -->
    <!-- Navbar -->
    <div class="navbar">
        <div class="logo">Espace Membre</div>
        <div class="nav-links">
            <form action="/logout" method="post" style="display:inline;">
                <button type="submit" class="btn-logout">Déconnexion</button>
            </form>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="/membre/dashboard">Dashboard</a></li>
            <li><a href="/membre/mesTaches" class="active">Mes Tâches</a></li>
            <li><a href="/membre/profil">Profil</a></li>
        </ul>
    </div>

<div class="container">
    <h1>Modifier un Livrable</h1>
        
<form action="${pageContext.request.contextPath}/membre/modifierLivrable" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${livrable.id}" />
    <input type="hidden" name="tacheId" value="${livrable.tacheId}" />

    <label>Nom du livrable :</label>
    <input type="text" name="nom" value="${livrable.nom}" required />

    <br/>

    <label>Fichier actuel :</label>
    <c:if test="${not empty livrable.fichierNom}">
        <p>${livrable.fichierNom}</p>
    </c:if>
    <c:if test="${empty livrable.fichierNom}">
    </c:if>

    <label>Nouveau fichier (facultatif) :</label>
    <input type="file" name="fichier" />
    <br/>
    <button type="submit">Modifier</button>
</form>
    <br/>
    <a href="${pageContext.request.contextPath}/membre/mesTaches">Retour aux tâches</a>
</div>
    </body>
</html>
