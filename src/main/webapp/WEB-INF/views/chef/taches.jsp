<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mycompany.gestion.projets.model.Tache"%>
<%@ page import="com.mycompany.gestion.projets.model.Utilisateur"%>
<%@ page import="com.mycompany.gestion.projets.model.Project"%>
<%@ page import="com.mycompany.gestion.projets.service.ProjectService"%>
<%@ page import="com.mycompany.gestion.projets.service.UtilisateurService"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    List<Tache> taches = (List<Tache>) request.getAttribute("taches");
    if (taches == null) taches = new java.util.ArrayList<>();

    WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProjectService projectService = ctx.getBean(ProjectService.class);
    UtilisateurService utilisateurService = ctx.getBean(UtilisateurService.class);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Liste des Tâches</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #393258;
            --secondary-color: #8382b4;
            --accent-color: #7badc9;
            --light-bg: #f8f9fa;
            --dark-text: #183357;
            --danger: #d90429;
            --success: #6cc556;
            --warning: #ff9800;
            --info: #2196f3;
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

        /* Navbar - Style cohérent */
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

        /* Sidebar - Style cohérent */
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

        /* Contenu principal */
        .main-content {
            margin-left: 250px;
            padding: 100px 40px 40px 40px;
            min-height: 100vh;
        }

        /* Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.8rem;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-add {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(57, 50, 88, 0.3);
        }

        /* Card Container */
        .card-container {
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 2.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .card-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, #7badc9, #8382b4);
        }

        /* Table */
        .tasks-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .tasks-table th {
            background: linear-gradient(to right, #96bbcf, #8382b4);
            color: white;
            padding: 1.2rem 1.5rem;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        .tasks-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            color: #555;
        }

        .tasks-table tr:last-child td {
            border-bottom: none;
        }

        .tasks-table tr:hover {
            background-color: rgba(123, 173, 201, 0.05);
        }

        /* Status badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            text-align: center;
            min-width: 100px;
        }

        .status-a_faire {
            background-color: var(--warning);
            color: white;
        }

        .status-en_cours {
            background-color: var(--info);
            color: white;
        }

        .status-termine {
            background-color: var(--success);
            color: white;
        }

        .status-en_retard {
            background-color: var(--danger);
            color: white;
        }

        /* Action buttons */
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            padding: 0.5rem;
            border-radius: 8px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            width: 34px;
            height: 34px;
            font-size: 0.9rem;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-view {
            background-color: var(--accent-color);
        }

        .btn-edit {
            background-color: var(--success);
        }

        .btn-delete {
            background-color: var(--danger);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #7badc9;
        }

        .empty-state h3 {
            margin-bottom: 0.5rem;
            color: var(--dark-text);
        }

        /* Responsive */
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

            .tasks-table {
                display: block;
                overflow-x: auto;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .card-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <i class="fas fa-tasks"></i>
        <span>Chef de Projet</span>
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
        <li><a href="/chef/dashboard"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
        <li><a href="/chef/taches" class="active"><i class="fas fa-tasks"></i><span>Tâches</span></a></li>
        <li><a href="/chef/projets"><i class="fas fa-project-diagram"></i><span>Projets</span></a></li>
        <li><a href="/chef/profil"><i class="fas fa-user-circle"></i><span>Profil</span></a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-tasks"></i>
            Liste des Tâches
        </h1>
        <a href="${pageContext.request.contextPath}/chef/taches/ajouter" class="btn-add">
            <i class="fas fa-plus"></i>
            Ajouter Tâche
        </a>
    </div>

    <div class="card-container">
        <% if (taches.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <h3>Aucune tâche disponible</h3>
            <p>Commencez par créer une nouvelle tâche</p>
        </div>
        <% } else { %>
        <table class="tasks-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Durée</th>
                <th>État</th>
                <th>Projet</th>
                <th>Membre</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Tache t : taches) {
                    Project p = projectService.findById(t.getProjetId());
                    Utilisateur u = utilisateurService.findById(t.getMembreId());
                    String nomProjet = (p != null ? p.getNom() : "Non défini");
                    String nomMembre = (u != null ? u.getNom() : "Non assigné");

                    // Détermination de la classe CSS en fonction de l'état
                    String etat = t.getEtat();
                    String etatClass = "status-badge ";

                    if (etat != null) {
                        switch(etat.toLowerCase()) {
                            case "à faire":
                                etatClass += "status-a_faire";
                                break;
                            case "en cours":
                                etatClass += "status-en_cours";
                                break;
                            case "terminée":
                                etatClass += "status-termine";
                                break;
                            case "en retard":
                                etatClass += "status-en_retard";
                                break;
                            default:
                                etatClass += "status-a_faire";
                        }
                    } else {
                        etat = "Non défini";
                        etatClass += "status-a_faire";
                    }
            %>
            <tr>
                <td><strong><%= t.getId() %></strong></td>
                <td><%= t.getNom() %></td>
                <td><%= t.getDureeEstimee() != null ? (t.getDureeEstimee()+" j") : "-" %></td>
                <td><span class="<%= etatClass %>"><%= etat %></span></td>
                <td><%= nomProjet %></td>
                <td><%= nomMembre %></td>
                <td>
                    <div class="action-btns">
                        <a href="${pageContext.request.contextPath}/chef/taches/modifier?id=<%=t.getId()%>"
                           class="action-btn btn-edit" title="Modifier">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/chef/taches/supprimer?id=<%=t.getId()%>"
                           class="action-btn btn-delete"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette tâche ?');"
                           title="Supprimer">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

</body>
</html>