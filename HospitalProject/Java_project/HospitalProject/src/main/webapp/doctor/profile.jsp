<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Profile</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Doctor Profile</h2>
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Personal Details</h5>
						<p><strong>Doctor ID:</strong> ${doctor.doctorId}</p>
						<p><strong>Name:</strong> ${doctor.name}</p>
						<p><strong>Date of Birth:</strong> ${doctor.dateOfBirth}</p>
						<p><strong>Gender:</strong> ${doctor.gender}</p>
						<p><strong>Contact Number:</strong> ${doctor.contactNumber}</p>
						<p><strong>Email:</strong> ${doctor.email}</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Professional Details</h5>
						<p><strong>Specialization:</strong> ${doctor.specialization}</p>
						<p><strong>Qualification:</strong> ${doctor.qualification}</p>
						<p><strong>Experience:</strong> ${doctor.experience} years</p>
						<p><strong>Registration Number:</strong> ${doctor.registrationNumber}</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Account Details</h5>
						<p><strong>Username:</strong> ${doctor.username}</p>
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