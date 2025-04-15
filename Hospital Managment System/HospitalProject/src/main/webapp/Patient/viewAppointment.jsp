<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Appointment</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>View Appointment</h2>
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Appointment Details</h5>
						<p><strong>Appointment ID:</strong> ${appointment.appointment_id}</p>
						<p><strong>Doctor Name:</strong> ${appointment.doctor_name}</p>
						<p><strong>Appointment Date:</strong> ${appointment.appointment_date}</p>
						<p><strong>Appointment Time:</strong> ${appointment.appointment_time}</p>
						<p><strong>Reason for Visit:</strong> ${appointment.reason}</p>
						<p><strong>Status:</strong> ${appointment.status}</p>
						<p><strong>Notes:</strong> ${appointment.notes}</p>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<a href="Appointment?action=list" class="btn btn-primary">Back to Appointments</a>
			</div>
		</div>
	</div>
</body>
</html>