<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Management System</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Hospital Management System</h2>
		<div class="row">
			<div class="col-md-4">
				<a href="Admin/login.jsp" class="btn btn-primary">Admin Login</a>
			</div>
			<div class="col-md-4">
				<a href="doctor/login.jsp" class="btn btn-primary">Doctor Login</a>
			</div>
			<div class="col-md-4">
				<a href="Patient/login.jsp" class="btn btn-primary">Patient Login</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<a href="Patient/signup.jsp" class="btn btn-primary">Patient Sign Up</a>
			</div>
		</div>
	</div>
</body>
</html>