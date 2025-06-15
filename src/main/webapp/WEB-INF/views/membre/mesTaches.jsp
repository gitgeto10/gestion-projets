<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Tâches</title>
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
            width: 100%;
            top: 0;
            left: 0;
            z-index: 999;
        }
        .logo {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .btn-logout {
            background-color: #38200a;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            transition: background-color 0.3s ease;
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
            margin: 1rem 0;
        }
        .sidebar ul li a {
            display: block;
            padding: 0.8rem 1.5rem;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-left: 5px solid transparent;
            transition: background-color 0.3s ease, border-left 0.3s ease;
        }
        .sidebar ul li a.active,
        .sidebar ul li a:hover {
            background-color: #996b4d;
            border-left: 5px solid #fff;
        }
        .main-content {
            margin-left: 240px;
            padding: 100px 40px 40px;
            min-height: 100vh;
        }
        h1 {
            margin-bottom: 30px;
            color: #615544;
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
            background-color: #b17949;
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
        <li><a href="/membre/mesTaches" class="active">Mes Tâches</a></li>
        <li><a href="/membre/profil">Profil</a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <h1>Liste de mes tâches</h1>

    <c:if test="${empty taches}">
        <p>Aucune tâche assignée.</p>
    </c:if>

    <c:if test="${not empty taches}">
        <table>
            <thead>
                <tr>
                    <th>Nom</th>
                    <th>Durée Estimée</th>
                    <th>État</th>
                    <th>Projet</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tache" items="${taches}">
                    <tr>
                        <td>${tache.nom}</td>
                        <td>${tache.dureeEstimee}</td>
                        <td>${tache.etat}</td>
                        <td>${tache.projetNom}</td>
                        <td>
                            <c:choose>
<c:when test="${tache.livrableId != null}">
                                    <a href="modifierLivrable?id=${tache.livrableId}" class="livrable-btn">Modifier Livrable</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="soumettreLivrable?tacheId=${tache.id}" class="livrable-btn">Soumettre Livrable</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>
