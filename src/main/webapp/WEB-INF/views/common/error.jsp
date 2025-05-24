<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger" role="alert">
            <h4>Erreur</h4>
            <p>${message}</p>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Retour au login</a>
    </div>
</body>
</html>
