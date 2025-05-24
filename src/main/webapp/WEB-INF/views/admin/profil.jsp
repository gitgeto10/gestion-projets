<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String nom = (String) session.getAttribute("nom");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    if (nom == null || email == null || role == null) {
        response.sendRedirect("../login.jsp"); // Redirige si non connecté
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Profil Admin</title>
    <style>
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
            padding: 90px 40px 40px 40px;
        }

        .profile-box {
            background-color: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            max-width: 600px;
        }

        .profile-box h2 {
            margin-bottom: 1rem;
            color: #183357;
        }

        .profile-item {
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .profile-item span {
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="logo">AdminPanel</div>
        <form action="/logout" method="post">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="utilisateurs.jsp">Utilisateurs</a></li>
            <li><a href="projets.jsp">Projets</a></li>
            <li><a href="profil.jsp" class="active">Profil</a></li>
        </ul>
    </div>

    <!-- Contenu principal -->
    <div class="main-content">
        <div class="profile-box">
            <h2>Profil Administrateur</h2>
            <div class="profile-item"><span>Nom :</span> <%= nom %></div>
            <div class="profile-item"><span>Email :</span> <%= email %></div>
            <div class="profile-item"><span>Rôle :</span> <%= role %></div>
        </div>
    </div>

</body>
</html>
