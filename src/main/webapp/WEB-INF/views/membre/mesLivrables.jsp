<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Mes Livrables</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

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

        tr:hover {
            background-color: #e8f0fe;
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
    <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
        <button type="submit" class="btn-logout">
            <i class="bi bi-box-arrow-right"></i> Déconnexion
        </button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="${pageContext.request.contextPath}/membre/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/membre/mesTaches"><i class="bi bi-list-check"></i> Mes Tâches</a></li>
        <li><a href="${pageContext.request.contextPath}/membre/mesLivrables" class="active"><i class="bi bi-folder2-open"></i> Mes Livrables</a></li>
        <li><a href="${pageContext.request.contextPath}/membre/profil"><i class="bi bi-person-circle"></i> Profil</a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <h1><i class="bi bi-folder2-open"></i> Mes Livrables</h1>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <c:choose>
        <c:when test="${empty livrables}">
            <p>Aucun livrable trouvé pour vos tâches.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>Nom du Livrable</th>
                        <th>Nom du Fichier</th>
                        <th>Date de Dépôt</th>
                        <th>Nom de Tâche</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="livrable" items="${livrables}">
                        <tr>
                            <td>${livrable.nom}</td>
                            <td>${livrable.fichierNom}</td>
                            <td><fmt:formatDate value="${livrable.dateDepot}" pattern="dd/MM/yyyy" /></td>
                            <td>${livrable.tacheNom}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
