<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .card {
            transition: transform .2s;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-md-12">
                <h2>Welcome, <%= session.getAttribute("patientName") %></h2>
                <p class="text-muted">Your Health Dashboard</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body text-center">
                        <h5 class="card-title">Book Appointment</h5>
                        <i class="fas fa-calendar-plus fa-3x mb-3"></i>
                        <br>
                        <a href="Patient?action=bookAppointment" class="btn btn-light">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body text-center">
                        <h5 class="card-title">View Reports</h5>
                        <i class="fas fa-file-medical fa-3x mb-3"></i>
                        <br>
                        <a href="Patient?action=viewReports" class="btn btn-light">View All</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body text-center">
                        <h5 class="card-title">Medical History</h5>
                        <i class="fas fa-history fa-3x mb-3"></i>
                        <br>
                        <a href="Patient?action=viewHistory" class="btn btn-light">View History</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body text-center">
                        <h5 class="card-title">Update Profile</h5>
                        <i class="fas fa-user-edit fa-3x mb-3"></i>
                        <br>
                        <a href="Patient?action=editProfile" class="btn btn-light">Update</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upcoming Appointments and Medical Info -->
        <div class="row">
            <!-- Upcoming Appointments -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-calendar-check"></i> Upcoming Appointments</h5>
                    </div>
                    <div class="card-body">
                        <% 
                            ResultSet appointments = (ResultSet) request.getAttribute("upcomingAppointments");
                            if(appointments != null && appointments.next()) {
                        %>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Doctor</th>
                                        <th>Purpose</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= appointments.getString("appointment_date") %></td>
                                        <td>Dr. <%= appointments.getString("doctor_name") %></td>
                                        <td><%= appointments.getString("purpose") %></td>
                                        <td>
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="cancelAppointment(<%= appointments.getString("appointment_id") %>)">
                                                Cancel
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        <% } else { %>
                            <p class="text-center">No upcoming appointments</p>
                            <div class="text-center">
                                <a href="Patient?action=bookAppointment" class="btn btn-primary">
                                    Book an Appointment
                                </a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Medical Information -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-notes-medical"></i> Medical Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Blood Group:</strong> <%= request.getAttribute("bloodGroup") %></p>
                                <p><strong>Age:</strong> <%= request.getAttribute("age") %></p>
                                <p><strong>Weight:</strong> <%= request.getAttribute("weight") %> kg</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Height:</strong> <%= request.getAttribute("height") %> cm</p>
                                <p><strong>Allergies:</strong> <%= request.getAttribute("allergies") %></p>
                                <p><strong>Last Visit:</strong> <%= request.getAttribute("lastVisit") %></p>
                            </div>
                        </div>
                        <hr>
                        <h6>Recent Prescriptions</h6>
                        <ul class="list-group">
                            <% 
                                ResultSet prescriptions = (ResultSet) request.getAttribute("recentPrescriptions");
                                while(prescriptions != null && prescriptions.next()) {
                            %>
                            <li class="list-group-item">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1"><%= prescriptions.getString("medicine_name") %></h6>
                                    <small><%= prescriptions.getString("prescribed_date") %></small>
                                </div>
                                <small class="text-muted">
                                    Dr. <%= prescriptions.getString("doctor_name") %>
                                </small>
                            </li>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function cancelAppointment(appointmentId) {
            if(confirm('Are you sure you want to cancel this appointment?')) {
                window.location.href = 'Patient?action=cancelAppointment&id=' + appointmentId;
            }
        }
    </script>
</body>
</html>