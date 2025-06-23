<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Modifier un Livrable</title>
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
            padding: 100px 40px 40px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-container {
            max-width: 600px;
            width: 100%;
            background: #fff;
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-left: 6px solid #7badc9;
        }
        h1 {
            color: #183357;
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-align: center;
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
        }
        label {
            font-weight: 600;
            color: #183357;
            display: block;
            margin-bottom: 0.5rem;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 0.8rem 1.2rem;
            margin-bottom: 1.2rem;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        .btn {
            padding: 0.8rem 1.8rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            background: linear-gradient(to right, #393258, #8382b4);
            font-size: 1.05rem;
            cursor: pointer;
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
            text-decoration: none;
            padding: 0.8rem 1.8rem;
            border-radius: 10px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-secondary:hover {
            background: #e0e0e0;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-tasks"></i>
        <span>Espace Membre</span>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </button>
    </form>
</div>

<div class="sidebar">
    <ul>
        <li><a href="/membre/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        <li><a href="/membre/mesTaches" class="active"><i class="fas fa-tasks"></i> Mes Tâches</a></li>
        <li><a href="/membre/profil"><i class="fas fa-user"></i> Profil</a></li>
    </ul>
</div>

<!-- Formulaire centré -->
<div class="main-content">
    <div class="form-container">
        <h1><i class="fas fa-pen-to-square"></i> Modifier un Livrable</h1>

        <form action="${pageContext.request.contextPath}/membre/modifierLivrable" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${livrable.id}" />
            <input type="hidden" name="tacheId" value="${livrable.tacheId}" />

            <label for="nom">Nom du livrable :</label>
            <input type="text" id="nom" name="nom" value="${livrable.nom}" required />

            <c:if test="${not empty livrable.fichierNom}">
                <label>Fichier actuel :</label>
                <p>${livrable.fichierNom}</p>
            </c:if>

            <label for="fichier">Nouveau fichier (facultatif) :</label>
            <input type="file" id="fichier" name="fichier" />

            <div class="btn-container">
                <button type="submit" class="btn">
                    <i class="fas fa-upload"></i> Modifier
                </button>
                <a href="${pageContext.request.contextPath}/membre/mesTaches" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
