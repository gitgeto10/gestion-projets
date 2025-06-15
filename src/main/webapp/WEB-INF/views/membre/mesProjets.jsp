<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Projets</title>
</head>
<body>
    <h2>Mes Projets</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Description</th>
                <th>Date D�but</th>
                <th>Date Fin</th>
                <th>Statut</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="projet" items="${projets}">
                <tr>
                    <td>${projet.nom}</td>
                    <td>${projet.description}</td>
                    <td>${projet.dateDebut}</td>
                    <td>${projet.dateFin}</td>
                    <td>${projet.statut}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
