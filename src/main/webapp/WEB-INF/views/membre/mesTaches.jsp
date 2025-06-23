<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f4f9;
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
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .logo {
            font-weight: 700;
            font-size: 1.6rem;
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

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 70px;
            left: 0;
            width: 250px;
            height: calc(100% - 70px);
            background-color: #201b36;
            padding-top: 1.5rem;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar ul {
            list-style: none;
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

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background: linear-gradient(to right, rgba(123, 173, 201, 0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }

        /* Main content */
        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px;
            min-height: 100vh;
        }

        h1 {
            color: #183357;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: left;
            font-weight: 500;
            color: #1B1B2F;
        }

        th {
            background-color: #7badc9;
            color: white;
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid #eee;
        }

        a.livrable-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: background-color 0.3s ease;
            color: white;
        }

        a.livrable-btn:hover {
            opacity: 0.9;
        }

        .soumettre {
            background-color: #0d6efd;
        }

        .modifier {
            background-color: #388E3C;
        }

        @media(max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
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
    <div class="logo"><i class="bi bi-person-badge"></i> Espace Membre</div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout"><i class="bi bi-box-arrow-right"></i> Déconnexion</button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/membre/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
        <li><a href="/membre/mesTaches" class="active"><i class="bi bi-list-task"></i> Mes Tâches</a></li>
        <li><a href="/membre/mesLivrables"><i class="bi bi-folder2-open"></i> Mes Livrables</a></li> 
        <li><a href="/membre/profil"><i class="bi bi-person-circle"></i> Profil</a></li>
    </ul>
</div>


<!-- Contenu principal -->
<div class="main-content">
    <h1><i class="bi bi-list-check"></i> Mes Tâches</h1>
    <c:if test="${not empty info}">
    <script>
        alert("${fn:escapeXml(info)}");
    </script>
    </c:if>

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
                                <a href="modifierLivrable?id=${tache.livrableId}" class="livrable-btn modifier">
                                    <i class="bi bi-pencil-square"></i> Modifier Livrable
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="soumettreLivrable?tacheId=${tache.id}" class="livrable-btn soumettre">
                                    <i class="bi bi-upload"></i> Soumettre Livrable
                                </a>
                            </c:otherwise>
                        </c:choose>
 <!-- 🔽 Bouton pour déclarer du temps -->
<c:choose>
    <c:when test="${tache.tempsDeclare}">
        <a href="${pageContext.request.contextPath}/membre/temps/modifier?tacheId=${tache.id}" class="livrable-btn" style="background-color:#f0ad4e; margin-left:10px;">Modifier Temps</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/membre/temps/ajouter?tacheId=${tache.id}" class="livrable-btn" style="background-color:#0275d8; margin-left:10px;">Déclarer Temps</a>
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
