<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointments</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Appointments</h2>
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Upcoming Appointments</h5>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Appointment ID</th>
									<th>Patient Name</th>
									<th>Appointment Date</th>
									<th>Appointment Time</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${upcomingAppointments}" var="appointment">
									<tr>
										<td>${appointment.appointmentId}</td>
										<td>${appointment.patient.name}</td>
										<td>${appointment.appointmentDate}</td>
										<td>${appointment.appointmentTime}</td>
										<td>${appointment.status}</td>
										<td>
											<a href="patientDetails.jsp?patientId=${appointment.patient.patientId}" class="btn btn-primary">View Patient Details</a>
											<a href="editAppointment.jsp?appointmentId=${appointment.appointmentId}" class="btn btn-secondary">Edit Appointment</a>
											<a href="cancelAppointment.jsp?appointmentId=${appointment.appointmentId}" class="btn btn-danger">Cancel Appointment</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Past Appointments</h5>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Appointment ID</th>
									<th>Patient Name</th>
									<th>Appointment Date</th>
									<th>Appointment Time</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pastAppointments}" var="appointment">
									<tr>
										<td>${appointment.appointmentId}</td>
										<td>${appointment.patient.name}</td>
										<td>${appointment.appointmentDate}</td>
										<td>${appointment.appointmentTime}</td>
										<td>${appointment.status}</td>
										<td>
											<a href="patientDetails.jsp?patientId=${appointment.patient.patientId}" class="btn btn-primary">View Patient Details</a>
											<a href="viewAppointmentDetails.jsp?appointmentId=${appointment.appointmentId}" class="btn btn-secondary">View Appointment Details</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>