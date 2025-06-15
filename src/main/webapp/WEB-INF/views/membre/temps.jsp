<%-- 
    Document   : temps
    Created on : 8 juin 2025, 23:43:24
    Author     : dell
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.gestion.projets.model.TempsTravail" %>
<%
    List<TempsTravail> tempsTravails = (List<TempsTravail>) request.getAttribute("tempsTravail");
%>
<html>
<head>
    <title>Temps de Travail</title>
</head>
<body>
    <h2>Mes Temps de Travail</h2>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Durée (heures)</th>
            <th>Tâche</th>
        </tr>
        <c:forEach var="temps" items="${tempsTravail}">
            <tr>
                <td>${temps.date}</td>
                <td>${temps.duree}</td>
                <td>${temps.tacheId}</td>
            </tr>
        </c:forEach>
    </table>

    <h3>Saisir ou Modifier un Temps</h3>
    <form method="post" action="${pageContext.request.contextPath}/membre/temps/add">
        <label>Date:</label><input type="date" name="date" required /><br/>
        <label>Durée:</label><input type="number" name="duree" required /><br/>
        <label>Tâche ID:</label><input type="number" name="tacheId" required /><br/>
        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
