<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Appointments - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .status-scheduled { color: #007bff; }
        .status-completed { color: #28a745; }
        .status-cancelled { color: #dc3545; }
        .status-pending { color: #ffc107; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2><i class="fas fa-calendar-check"></i> My Appointments</h2>
            </div>
            <div class="col-md-6 text-right">
                <a href="Patient?action=bookAppointment" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Book New Appointment
                </a>
            </div>
        </div>

        <!-- Alert Messages -->
        <% if(request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getAttribute("success") %>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <% } %>

        <!-- Appointments List -->
        <div class="card">
            <div class="card-body">
                <ul class="nav nav-tabs" id="appointmentTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#upcoming">
                            Upcoming Appointments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#past">
                            Past Appointments
                        </a>
                    </li>
                </ul>

                <div class="tab-content mt-3">
                    <!-- Upcoming Appointments -->
                    <div class="tab-pane fade show active" id="upcoming">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Doctor</th>
                                    <th>Purpose</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    ResultSet upcomingRs = (ResultSet) request.getAttribute("upcomingAppointments");
                                    while(upcomingRs != null && upcomingRs.next()) {
                                %>
                                <tr>
                                    <td><%= upcomingRs.getString("appointment_date") %></td>
                                    <td><%= upcomingRs.getString("appointment_time") %></td>
                                    <td>Dr. <%= upcomingRs.getString("doctor_name") %></td>
                                    <td><%= upcomingRs.getString("purpose") %></td>
                                    <td>
                                        <span class="status-<%= upcomingRs.getString("status").toLowerCase() %>">
                                            <%= upcomingRs.getString("status") %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if(upcomingRs.getString("status").equals("SCHEDULED")) { %>
                                            <button class="btn btn-danger btn-sm" 
                                                    onclick="cancelAppointment(<%= upcomingRs.getString("appointment_id") %>)">
                                                <i class="fas fa-times"></i> Cancel
                                            </button>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Past Appointments -->
                    <div class="tab-pane fade" id="past">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Doctor</th>
                                    <th>Purpose</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    ResultSet pastRs = (ResultSet) request.getAttribute("pastAppointments");
                                    while(pastRs != null && pastRs.next()) {
                                %>
                                <tr>
                                    <td><%= pastRs.getString("appointment_date") %></td>
                                    <td><%= pastRs.getString("appointment_time") %></td>
                                    <td>Dr. <%= pastRs.getString("doctor_name") %></td>
                                    <td><%= pastRs.getString("purpose") %></td>
                                    <td>
                                        <span class="status-<%= pastRs.getString("status").toLowerCase() %>">
                                            <%= pastRs.getString("status") %>
                                        </span>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
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