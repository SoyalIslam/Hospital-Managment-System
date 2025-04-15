<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Details</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Patient Details</h2>
		<div class="row">
			<div class="col-md-6">
				<h3>Personal Details</h3>
				<p><strong>Patient ID:</strong> ${patient.patientId}</p>
				<p><strong>Name:</strong> ${patient.name}</p>
				<p><strong>Date of Birth:</strong> ${patient.dateOfBirth}</p>
				<p><strong>Gender:</strong> ${patient.gender}</p>
				<p><strong>Contact Number:</strong> ${patient.contactNumber}</p>
				<p><strong>Email:</strong> ${patient.email}</p>
			</div>
			<div class="col-md-6">
				<h3>Medical Details</h3>
				<p><strong>Blood Group:</strong> ${patient.bloodGroup}</p>
				<p><strong>Medical History:</strong> ${patient.medicalHistory}</p>
				<p><strong>Allergies:</strong> ${patient.allergies}</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h3>Appointment History</h3>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Appointment ID</th>
							<th>Doctor Name</th>
							<th>Appointment Date</th>
							<th>Appointment Time</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${patient.appointments}" var="appointment">
							<tr>
								<td>${appointment.appointmentId}</td>
								<td>${appointment.doctor.name}</td>
								<td>${appointment.appointmentDate}</td>
								<td>${appointment.appointmentTime}</td>
								<td>${appointment.status}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>