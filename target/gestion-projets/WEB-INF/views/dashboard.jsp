<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.mycompany.gestion.projets.model.Utilisateur utilisateur =
        (com.mycompany.gestion.projets.model.Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect("login");
    }
%>

<html>
<head>
    <title>Tableau de bord</title>
</head>
<body>
    <h2>Bienvenue, ${utilisateur.nom}</h2>
    <p>Rôle : ${utilisateur.role}</p>

    <a href="/logout">Se déconnecter</a>
</body>
</html>
