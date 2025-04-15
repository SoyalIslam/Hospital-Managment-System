<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Login / Signup</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 10px;
        }
        .toggle-buttons {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
    </style>
    <script>
        function showForm(formId) {
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('signupForm').style.display = 'none';
            document.getElementById(formId).style.display = 'block';
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2 class="text-center">Doctor Portal</h2>

        <div class="toggle-buttons">
            <button class="btn btn-outline-primary" onclick="showForm('loginForm')">Login</button>
            <button class="btn btn-outline-success" onclick="showForm('signupForm')">Signup</button>
        </div>

        <!-- Login Form -->
        <form id="loginForm" action="<c:url value='/doctorLogin'/>" method="post">
            <div class="form-group">
                <label for="loginEmail">Email</label>
                <input type="email" class="form-control" id="loginEmail" name="email" required>
            </div>
            <div class="form-group">
                <label for="loginPassword">Password</label>
                <input type="password" class="form-control" id="loginPassword" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
        </form>

        <!-- Signup Form -->
        <form id="signupForm" action="<c:url value='/doctorSignup'/>" method="post" style="display: none;">
            <div class="form-group">
                <label for="signupName">Name</label>
                <input type="text" class="form-control" id="signupName" name="name" required>
            </div>
            <div class="form-group">
                <label for="signupEmail">Email</label>
                <input type="email" class="form-control" id="signupEmail" name="email" required>
            </div>
            <div class="form-group">
                <label for="signupPhone">Phone Number</label>
                <input type="text" class="form-control" id="signupPhone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="signupSpecialization">Specialization</label>
                <input type="text" class="form-control" id="signupSpecialization" name="specialization" required>
            </div>
            <div class="form-group">
                <label for="signupPassword">Password</label>
                <input type="password" class="form-control" id="signupPassword" name="password" required>
            </div>
            <button type="submit" class="btn btn-success btn-block">Signup</button>
        </form>
    </div>
</body>
</html>
