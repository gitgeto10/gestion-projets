<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Soumettre un Livrable</title>
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
