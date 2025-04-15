<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule Appointment</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2>Schedule Appointment</h2>
		<form action="scheduleAppointment" method="post">
			<div class="form-group">
				<label for="doctor">Select Doctor:</label>
				<select class="form-control" id="doctor" name="doctorId">
					<c:forEach items="${doctors}" var="doctor">
						<option value="${doctor.doctorId}">${doctor.name} - ${doctor.specialization}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="date">Select Date:</label>
				<input type="date" class="form-control" id="date" name="appointmentDate">
			</div>
			<div class="form-group">
				<label for="time">Select Time:</label>
				<select class="form-control" id="time" name="appointmentTime">
					<option value="9:00 AM">9:00 AM</option>
					<option value="10:00 AM">10:00 AM</option>
					<option value="11:00 AM">11:00 AM</option>
					<option value="12:00 PM">12:00 PM</option>
					<option value="1:00 PM">1:00 PM</option>
					<option value="2:00 PM">2:00 PM</option>
					<option value="3:00 PM">3:00 PM</option>
					<option value="4:00 PM">4:00 PM</option>
				</select>
			</div>
			<div class="form-group">
				<label for="reason">Reason for Visit:</label>
				<textarea class="form-control" id="reason" name="reasonForVisit"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Schedule Appointment</button>
		</form>
	</div>
</body>
</html>