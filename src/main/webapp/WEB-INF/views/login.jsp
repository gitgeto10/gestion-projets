<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Connexion</title>
</head>
<body>
    <h2>Connexion</h2>
    
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form action="/login" method="post">
        <label>Email :</label>
        <input type="email" name="email" required /><br />
        <label>Mot de passe :</label>
        <input type="password" name="pwd" required /><br />
        <input type="submit" value="Se connecter" />
    </form>
</body>
</html>
