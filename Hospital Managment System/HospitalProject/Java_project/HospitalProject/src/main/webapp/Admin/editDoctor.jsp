<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Doctor</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Edit Doctor</h2>
		<form action="EditDoctor" method="post">
			<div class="form-group">
				<label for="doctorId">Doctor ID:</label>
				<input type="text" class="form-control" id="doctorId" name="doctorId" value="${doctor.doctorId}" readonly>
			</div>
			<div class="form-group">
				<label for="name">Name:</label>
				<input type="text" class="form-control" id="name" name="name" value="${doctor.name}">
			</div>
			<div class="form-group">
				<label for="specialization">Specialization:</label>
				<input type="text" class="form-control" id="specialization" name="specialization" value="${doctor.specialization}">
			</div>
			<div class="form-group">
				<label for="qualification">Qualification:</label>
				<input type="text" class="form-control" id="qualification" name="qualification" value="${doctor.qualification}">
			</div>
			<div class="form-group">
				<label for="experience">Experience:</label>
				<input type="text" class="form-control" id="experience" name="experience" value="${doctor.experience}">
			</div>
			<div class="form-group">
				<label for="contactNumber">Contact Number:</label>
				<input type="text" class="form-control" id="contactNumber" name="contactNumber" value="${doctor.contactNumber}">
			</div>
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" class="form-control" id="email" name="email" value="${doctor.email}">
			</div>
			<button type="submit" class="btn btn-primary">Update Doctor</button>
		</form>
	</div>
</body>
</html>