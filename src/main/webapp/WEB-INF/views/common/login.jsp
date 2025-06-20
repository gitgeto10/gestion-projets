<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Connexion - Gestion de Projet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background: linear-gradient(135deg, #e4e6e9, #bdc7d6);
            font-family: 'Segoe UI', sans-serif;
        }
        .full-height {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container-login {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            max-width: 900px;
            width: 100%;
            display: flex;
            overflow: hidden;
            animation: fadeIn 0.6s ease;
        }
       .left-side {
    flex: 1;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: #1b1b1b;
    font-weight: 600;
    font-size: 1.25rem;
    text-align: center;
}

        .right-side {
            flex: 1;
            padding: 40px 30px;
        }
        .login-card h3 {
            color: #0d6efd;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .form-control {
            border: none;
            border-bottom: 2px solid #ccc;
            border-radius: 0;
            box-shadow: none;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: none;
        }
        .btn-login {
            background-color: #2c67c0;
            border: none;
            border-radius: 50px;
            padding: 0.6rem;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn-login:hover {
            background-color: #437ad3;
        }
        .form-label {
            color: #444;
            font-weight: 500;
            text-align: left;
            display: block;
        }
        .alert {
            font-size: 0.9rem;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container-login {
                flex-direction: column;
                max-width: 400px;
            }
            .left-side {
                padding: 20px;
                font-size: 1rem;
                background-size: 120px;
                height: 180px;
            }
            .right-side {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="full-height">
    <div class="container-login">
       <div class="left-side">
           <p>Bienvenue dans votre espace</p>
          <img src="${pageContext.request.contextPath}/images/gestion-de-projets.png" alt="Gestion de Projet" style="max-width: 100%; height: auto; margin-bottom: 20px;" />
    </div>

        <div class="right-side">
            <div class="login-card">
                <h3>Connexion</h3>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3 text-start">
                        <label for="email" class="form-label"><i class="bi bi-envelope"></i> Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="email@projet.com" required />
                    </div>
                    <div class="mb-3 text-start">
                        <label for="password" class="form-label"><i class="bi bi-lock"></i> Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="pwd" placeholder="••••••••" required />
                    </div>
                    <div class="d-flex justify-content-start align-items-center mb-3 small-link">
                        <input type="checkbox" id="remember" />
                        <label for="remember" class="ms-2">Se souvenir de moi</label>
                    </div>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-login text-white">Connexion</button>
                    </div>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger text-center">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
