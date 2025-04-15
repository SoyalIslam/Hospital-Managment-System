<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Profile</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Patient Profile</h2>
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Personal Details</h5>
						<p><strong>Patient ID:</strong> ${patient.patientId}</p>
						<p><strong>Name:</strong> ${patient.name}</p>
						<p><strong>Date of Birth:</strong> ${patient.dateOfBirth}</p>
						<p><strong>Gender:</strong> ${patient.gender}</p>
						<p><strong>Contact Number:</strong> ${patient.contactNumber}</p>
						<p><strong>Email:</strong> ${patient.email}</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Medical Details</h5>
						<p><strong>Blood Group:</strong> ${patient.bloodGroup}</p>
						<p><strong>Medical History:</strong> ${patient.medicalHistory}</p>
						<p><strong>Allergies:</strong> ${patient.allergies}</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Account Details</h5>
						<p><strong>Username:</strong> ${patient.username}</p>
						<p><strong>Password:</strong> **********</p>
						<a href="changePassword.jsp" class="btn btn-primary">Change Password</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
			</div>
		</div>
	</div>
</body>
</html>