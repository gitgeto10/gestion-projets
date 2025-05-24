<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm">
                    <div class="card-header text-center">
                        <h3>Connexion </h3>
                    </div>
                    <div class="card-body">

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Adresse email</label>
                                <input type="email" class="form-control" name="email" id="email" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Mot de passe</label>
                                <input type="password" class="form-control" name="pwd" id="password" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Se connecter</button>
                            </div>
                        </form>

                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger mt-3" role="alert">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>


                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
