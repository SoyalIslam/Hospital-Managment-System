<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Doctor Dashboard</h2>
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Upcoming Appointments</h5>
						<p class="card-text">You have ${upcomingAppointments} upcoming appointments today.</p>
						<a href="appointments.jsp" class="btn btn-primary">View Appointments</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">New Patients</h5>
						<p class="card-text">You have ${newPatients} new patients assigned to you.</p>
						<a href="patientDetails.jsp" class="btn btn-primary">View Patients</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Patient Messages</h5>
						<p class="card-text">You have ${unreadMessages} unread messages from patients.</p>
						<a href="messages.jsp" class="btn btn-primary">View Messages</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h3>Today's Schedule</h3>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Time</th>
							<th>Patient Name</th>
							<th>Appointment Type</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${todaySchedule}" var="appointment">
							<tr>
								<td>${appointment.appointmentTime}</td>
								<td>${appointment.patient.name}</td>
								<td>${appointment.appointmentType}</td>
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