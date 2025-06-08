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
    <!-- Styles similaires à ta page Projets -->
</head>
<body>
<!-- Navbar & sidebar identiques -->

<div class="main-content">
    <h1>Liste des Tâches</h1>
    <div class="ajouter-container">
        <a href="${pageContext.request.contextPath}/chef/taches/ajouter" class="btn-ajouter">Ajouter une tâche</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th><th>Nom</th><th>Durée</th><th>État</th><th>Projet</th><th>Membre</th><th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Tache t : taches) {
                Project p = projectService.findById(t.getProjetId());
                Utilisateur u = utilisateurService.findById(t.getMembreId());
                String nomProjet = (p != null ? p.getNom() : "Non défini");
                String nomMembre = (u != null ? u.getNom() : "Non assigné");
        %>
        <tr>
            <td><%= t.getId() %></td>
            <td><%= t.getNom() %></td>
            <td><%= t.getDureeEstimee() != null ? (t.getDureeEstimee()+" j") : "-" %></td>
            <td><%= t.getEtat() %></td>
            <td><%= nomProjet %></td>
            <td><%= nomMembre %></td>
            <td>
                <a href="${pageContext.request.contextPath}/chef/taches/modifier?id=<%=t.getId()%>" class="action-btn edit-btn">Modifier</a>
                <a href="${pageContext.request.contextPath}/chef/taches/supprimer?id=<%=t.getId()%>" class="action-btn delete-btn"
                   onclick="return confirm('Supprimer cette tâche ?');">Supprimer</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
