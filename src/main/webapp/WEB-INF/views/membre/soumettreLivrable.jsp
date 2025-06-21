<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    String dateDepot = sdf.format(new Date());
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Soumettre un Livrable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            margin: 0;
            background-color: #f5f7fa;
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
            box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        }
        .logo {
            font-weight: 700;
            font-size: 1.6rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo i {
            font-size: 1.5rem;
        }
        .btn-logout {
            background-color: #0c0c0c;
            color: white;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-logout:hover {
            background-color: #d90429;
        }
        .sidebar {
            position: fixed;
            top: 70px;
            left: 0;
            width: 240px;
            height: calc(100% - 70px);
            background-color: #201b36;
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
            color: #caf0f8;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            border-left: 5px solid transparent;
            transition: 0.3s ease;
            font-size: 1.1rem;
        }
        .sidebar ul li a i {
            margin-right: 10px;
            font-size: 1.3rem;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #7badc9;
            border-left: 5px solid #0a024d;
            color: white;
        }
        .main-content {
            margin-left: 240px;
            padding: 100px 30px 40px;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            border-left: 6px solid #7badc9;
        }
        h1 {
            text-align: center;
            color: #183357;
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            font-weight: 600;
            color: #2B2B2B;
            margin-bottom: .5rem;
        }
        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: .7rem 1rem;
            margin-bottom: 1.2rem;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1rem;
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
        .back-link {
            text-decoration: none;
            color: #3949ab;
            font-weight: bold;
            display: flex;
            align-items: center;
            margin-top: 1.2rem;
            gap: 6px;
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

<!-- Main Content -->
<div class="main-content">
    <div class="form-container">
        <h1><i class="bi bi-upload"></i> Soumettre un Livrable</h1>

        <form:form method="post" modelAttribute="livrable" action="${pageContext.request.contextPath}/membre/soumettreLivrable" enctype="multipart/form-data">
            <form:hidden path="tacheId" />

            <label for="nom">Titre du livrable :</label>
            <input type="text" id="nom" name="nom" placeholder="Titre du livrable" required />

            <label for="fichier">Fichier du livrable :</label>
            <input type="file" id="fichier" name="fichier" required />

            <label>Date de dépôt :</label>
            <input type="text" value="<%= dateDepot %>" readonly
                   style="width: 100%; padding: .7rem 1rem; margin-bottom: 1.2rem; border-radius: 6px; border: 1px solid #ccc; font-size: 1rem;" />

            <button type="submit">
                <i class="bi bi-send-fill"></i> Soumettre
            </button>
        </form:form>

        <a href="${pageContext.request.contextPath}/membre/mesTaches" class="back-link">
            <i class="bi bi-arrow-left-circle"></i> Retour aux tâches
        </a>
    </div>
</div>

</body>
</html>
