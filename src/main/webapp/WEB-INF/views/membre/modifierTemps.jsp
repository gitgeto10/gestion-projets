<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier Temps de Travail</title>
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

        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px;
            min-height: 100vh;
        }

        .form-container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            border-left: 6px solid #7badc9;
        }

        h1 {
            color: #183357;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: .5rem;
            color: #2c3e50;
        }

        input[type="number"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-bottom: 1.5rem;
            font-size: 1rem;
        }

        p {
            background: #f0f0f0;
            padding: .7rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            margin-bottom: 1.5rem;
        }

        button {
            background-color: #393258;
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 700;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2a2442;
        }

        .btn-secondary {
            background-color: #6c757d;
            text-align: center;
            margin-top: 10px;
            padding: 0.8rem 1.5rem;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            display: inline-block;
            text-decoration: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
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
        <button type="submit" class="btn-logout">
            <i class="bi bi-box-arrow-right"></i> Déconnexion
        </button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/membre/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
        <li><a href="/membre/mesTaches" class="active"><i class="bi bi-list-task"></i> Mes Tâches</a></li>
        <li><a href="/membre/profil"><i class="bi bi-person-circle"></i> Profil</a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="form-container">
        <h1><i class="bi bi-pencil-square"></i> Modifier Temps de Travail</h1>

        <form action="${pageContext.request.contextPath}/membre/temps/modifier" method="post">
            <input type="hidden" name="id" value="${temps.id}" />
            <input type="hidden" name="tacheId" value="${temps.tacheId}" />

            <label>Tâche :</label>
            <p>
                <c:forEach var="tache" items="${taches}">
                    <c:if test="${tache.id == temps.tacheId}">
                        ${tache.nom}
                    </c:if>
                </c:forEach>
            </p>

            <label for="duree">Durée (heures) :</label>
            <input type="number" name="duree" id="duree" value="${temps.duree}" required min="1" />

            <button type="submit"><i class="bi bi-check-circle"></i> Enregistrer</button>

            <a href="${pageContext.request.contextPath}/membre/mesTaches" class="btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Retour
            </a>
        </form>
    </div>
</div>

</body>
</html>
