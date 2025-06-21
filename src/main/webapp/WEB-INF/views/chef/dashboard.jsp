<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Chef</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #393258;
            --secondary-color: #8382b4;
            --accent-color: #7badc9;
            --light-bg: #f8f9fa;
            --dark-text: #183357;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
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
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
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

        .sidebar ul li a i {
            width: 24px;
            text-align: center;
            font-size: 1.1rem;
        }

        .sidebar ul li a:hover, .sidebar ul li a.active {
            background: linear-gradient(to right, rgba(123, 173, 201, 0.3), transparent);
            border-left: 4px solid #7badc9;
            color: white;
        }

        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;
        }

        h1 {
            margin-bottom: 30px;
            color: #183357;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .card {
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, #7badc9, #8382b4);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }

        .card h3 {
            color: #393258;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card h3 i {
            color: #7badc9;
        }

        .card p {
            font-size: 2rem;
            font-weight: 700;
            color: #183357;
        }

        .card .card-footer {
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #666;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 200px;
            }
            .main-content {
                margin-left: 200px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }
            .sidebar ul li a span {
                display: none;
            }
            .sidebar ul li a {
                justify-content: center;
                padding: 1rem;
            }
            .main-content {
                margin-left: 70px;
                padding: 90px 20px 20px 20px;
            }
            .card h3 {
                font-size: 1.3rem;
            }
            .card p {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-user-tie"></i>
        <span>Tableau de Bord Chef</span>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </button>
    </form>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/chef/dashboard" class="active"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/chef/taches"><i class="fas fa-tasks"></i><span>Tâches</span></a></li>
        <li><a href="/chef/projets"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/chef/profil"><i class="fas fa-user-circle"></i><span>Profil</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <h1>
        <i class="fas fa-chart-line"></i>
        Tableau de Bord
    </h1>

    <div class="dashboard-container">
        <div class="card">
            <h3><i class="fas fa-tasks"></i> Tâches</h3>
            <p>${nombreTaches}</p>
            <div class="card-footer">Total des tâches assignées</div>
        </div>

        <div class="card">
            <h3><i class="fas fa-project-diagram"></i> Projets</h3>
            <p>${nombreProjets}</p>
            <div class="card-footer">Projets en cours</div>
        </div>

        <div class="card">
            <h3><i class="fas fa-users"></i> Équipe</h3>
            <p>${nombreMembres}</p>
            <div class="card-footer">Membres dans votre équipe</div>
        </div>

        <div class="card">
            <h3><i class="fas fa-clock"></i> Retards</h3>
            <p>${tachesRetard}</p>
            <div class="card-footer">Tâches en retard</div>
        </div>
    </div>
</div>

</body>
</html>