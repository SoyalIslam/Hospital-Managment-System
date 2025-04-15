<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .card {
            transition: transform .2s;
        }
        .card:hover {
            transform: scale(1.02);
        }
        .stats-card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-md-12">
                <h2>Welcome, Admin</h2>
                <p class="text-muted">Hospital Management System Dashboard</p>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card stats-card bg-primary text-white">
                    <div class="card-body">
                        <h5 class="card-title">Total Doctors</h5>
                        <h2 class="card-text">
                            <i class="fas fa-user-md"></i>
                            <%= request.getAttribute("doctorCount") %>
                        </h2>
                        <a href="Admin?action=viewDoctors" class="text-white">View Details →</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stats-card bg-success text-white">
                    <div class="card-body">
                        <h5 class="card-title">Total Patients</h5>
                        <h2 class="card-text">
                            <i class="fas fa-users"></i>
                            <%= request.getAttribute("patientCount") %>
                        </h2>
                        <a href="Admin?action=viewPatients" class="text-white">View Details →</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stats-card bg-warning text-white">
                    <div class="card-body">
                        <h5 class="card-title">Today's Appointments</h5>
                        <h2 class="card-text">
                            <i class="fas fa-calendar-check"></i>
                            <%= request.getAttribute("todayAppointments") %>
                        </h2>
                        <a href="Admin?action=viewAppointments" class="text-white">View Details →</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stats-card bg-info text-white">
                    <div class="card-body">
                        <h5 class="card-title">Available Doctors</h5>
                        <h2 class="card-text">
                            <i class="fas fa-user-md"></i>
                            <%= request.getAttribute("availableDoctors") %>
                        </h2>
                        <a href="Admin?action=viewDoctors" class="text-white">View Details →</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4>Quick Actions</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <a href="Admin?action=addDoctor" class="btn btn-primary btn-block">
                                    <i class="fas fa-user-plus"></i> Add New Doctor
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="Admin?action=addPatient" class="btn btn-success btn-block">
                                    <i class="fas fa-user-plus"></i> Add New Patient
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="Admin?action=viewAppointments" class="btn btn-warning btn-block">
                                    <i class="fas fa-calendar-plus"></i> View Appointments
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="Admin?action=reports" class="btn btn-info btn-block">
                                    <i class="fas fa-chart-bar"></i> Generate Reports
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4>Recent Appointments</h4>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    ResultSet recentAppointments = (ResultSet) request.getAttribute("recentAppointments");
                                    while(recentAppointments != null && recentAppointments.next()) {
                                %>
                                <tr>
                                    <td><%= recentAppointments.getString("patient_name") %></td>
                                    <td><%= recentAppointments.getString("doctor_name") %></td>
                                    <td><%= recentAppointments.getString("appointment_date") %></td>
                                    <td><%= recentAppointments.getString("status") %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4>New Patients</h4>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Contact</th>
                                    <th>Date Joined</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    ResultSet newPatients = (ResultSet) request.getAttribute("newPatients");
                                    while(newPatients != null && newPatients.next()) {
                                %>
                                <tr>
                                    <td><%= newPatients.getString("name") %></td>
                                    <td><%= newPatients.getString("contact") %></td>
                                    <td><%= newPatients.getString("join_date") %></td>
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
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>