<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Sign Up</h2>
		<form action="Signup" method="post">
			<div class="form-group">
				<label for="name">Name:</label>
				<input type="text" class="form-control" id="name" name="name">
			</div>
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" class="form-control" id="email" name="email">
			</div>
			<div class="form-group">
				<label for="contactNumber">Contact Number:</label>
				<input type="text" class="form-control" id="contactNumber" name="contactNumber">
			</div>
			<div class="form-group">
				<label for="username">Username:</label>
				<input type="text" class="form-control" id="username" name="username">
			</div>
			<div class="form-group">
				<label for="password">Password:</label>
				<input type="password" class="form-control" id="password" name="password">
			</div>
			<div class="form-group">
				<label for="confirmPassword">Confirm Password:</label>
				<input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
			</div>
			<div class="form-group">
				<label for="userType">User Type:</label>
				<select class="form-control" id="userType" name="userType">
					<option value="patient">Patient</option>
					<option value="doctor">Doctor</option>
				</select>
			</div>
			<button type="submit" class="btn btn-primary">Sign Up</button>
		</form>
		<c:if test="${error != null}">
			<div class="alert alert-danger">
				<c:out value="${error}"/>
			</div>
		</c:if>
	</div>
</body>
</html>