<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter Temps de Travail</title>
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
        .main-content {
            margin-left: 240px;
            padding: 100px 40px 40px;
            min-height: 100vh;
        }
        h1 {
            margin-bottom: 30px;
            color: #183357;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-weight: 600;
            color: #1B1B2F;
        }
        th {
            background-color: #7badc9;
            color: white;
        }
        a.livrable-btn {
            background-color: #388E3C;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        a.livrable-btn:hover {
            background-color: #2e7d32;
        }
        @media(max-width: 600px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                padding: 120px 20px 20px;
            }
}
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">Espace Membre</div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">Déconnexion</button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/membre/dashboard">Dashboard</a></li>
        <li><a href="/membre/mesTaches">Mes Tâches</a></li>
        <li><a href="/membre/profil">Profil</a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <h1>Ajouter un temps de travail</h1>

    <c:if test="${not empty info}">
        <div style="color: red;">${info}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/membre/temps/ajouter" method="post">
        <input type="hidden" name="tacheId" value="${temps.tacheId}" />

        <div class="form-group mt-3">
            <label>Tâche :</label>
            <p>
                <c:forEach var="tache" items="${taches}">
                    <c:if test="${tache.id == temps.tacheId}">
                        ${tache.nom}
                    </c:if>
                </c:forEach>
            </p>
        </div>

        <div class="form-group mt-3">
            <label for="duree">Durée:</label>
            <input type="number" class="form-control" name="duree" id="duree" required min="1">
        </div>

        <button type="submit" class="livrable-btn" style="margin-top: 20px;">Enregistrer</button>
        <a href="${pageContext.request.contextPath}/membre/mesTaches" class="livrable-btn" style="background-color: #6c757d; margin-left:10px;">Retour</a>
    </form>
</div>

</body>
</html>
