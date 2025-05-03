<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4b7bec, #8e54e9);
            min-height: 100vh;
            display: flex;
            align-items: center;
            overflow-y: auto;
            position: relative;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 2.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }
        .hospital-img {
            height: 120px;
            filter: drop-shadow(0 0 10px rgba(0,0,0,0.2));
            transition: transform 0.3s ease;
        }
        .hospital-img:hover {
            transform: scale(1.1);
        }
        .form-control {
            background: rgba(255, 255, 255, 0.25);
            border: none;
            border-radius: 10px;
            color: #ffffff;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.35);
            box-shadow: 0 0 10px rgba(75, 123, 236, 0.4);
            color: #ffffff;
            border: none;
            outline: none;
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.75);
        }
        .btn-primary {
            background: linear-gradient(45deg, #4b7bec, #8e54e9);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(45deg, #5c8cff, #9f6bf5);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(75, 123, 236, 0.4);
        }
        .input-group-text {
            background: rgba(255, 255, 255, 0.25);
            border: none;
            color: #ffffff;
            border-radius: 10px 0 0 10px;
        }
        .text-primary {
            color: #ffffff !important;
            text-shadow: 0 2px 4px rgba(0,0,0,0.15);
        }
        .text-muted {
            color: rgba(255, 255, 255, 0.8) !important;
        }
        a {
            color: #8e54e9;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #4b7bec;
        }
        .alert {
            border-radius: 10px;
            background: rgba(239, 68, 68, 0.3);
            border: none;
            color: #ffffff;
        }
        .bg-particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"><circle cx="10" cy="10" r="1" fill="rgba(255,255,255,0.25)"/></svg>') repeat;
            animation: float 20s infinite linear;
        }
        @keyframes float {
            0% { background-position: 0 0; }
            100% { background-position: 100px 100px; }
        }
        .form-check-input {
            background-color: rgba(255, 255, 255, 0.25);
            border-color: rgba(255, 255, 255, 0.5);
        }
        .form-check-input:checked {
            background-color: #4b7bec;
            border-color: #4b7bec;
        }
        .form-check-label {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="bg-particles"></div>
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-6 col-lg-5">
                <div class="card login-card">
                    <div class="text-center mb-4">
                        <img src="https://cdn-icons-png.flaticon.com/512/2967/2967921.png" class="hospital-img mb-3" alt="Hospital Logo">
                        <h2 class="text-primary">Hospital Management System</h2>
                        <p class="text-muted">Secure access to your healthcare portal</p>
                    </div>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    
                    <form action="LoginServlet" method="post" onsubmit="return validateLogin()">
                        <div class="mb-3">
                            <label class="form-label text-white">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text">@</span>
                                <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember">
                                <label class="form-check-label text-white" for="remember">Remember me</label>
                            </div>
                            <a href="#" class="text-decoration-none">Forgot password?</a>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            Sign In
                        </button>
                        <p class="text-center text-muted mt-4">
                            Don't have an account? <a href="signup.jsp" class="text-decoration-none">Create one</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>