<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Doctors - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .doctor-card {
            transition: transform .2s;
        }
        .doctor-card:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .status-active { color: #28a745; }
        .status-inactive { color: #dc3545; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h2><i class="fas fa-user-md"></i> Manage Doctors</h2>
            </div>
            <div class="col-md-6 text-right">
                <a href="Admin?action=addDoctor" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Doctor
                </a>
            </div>
        </div>

        <!-- Alert Messages -->
        <% if(request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getAttribute("success") %>
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        <% } %>
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getAttribute("error") %>
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        <% } %>

        <!-- Search Bar -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <form action="Admin" method="get" class="form-inline">
                            <input type="hidden" name="action" value="searchDoctors">
                            <div class="form-group mx-sm-3 mb-2">
                                <input type="text" class="form-control" name="searchTerm" 
                                       placeholder="Search by name or specialization">
                            </div>
                            <button type="submit" class="btn btn-primary mb-2">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Doctors List -->
        <div class="row">
            <% 
                ResultSet rs = (ResultSet) request.getAttribute("doctors");
                while(rs != null && rs.next()) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card doctor-card">
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <i class="fas fa-user-md fa-3x text-primary"></i>
                        </div>
                        <h5 class="card-title text-center">Dr. <%= rs.getString("name") %></h5>
                        <p class="card-text text-center text-muted">
                            <%= rs.getString("specialization") %>
                        </p>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <i class="fas fa-envelope"></i> <%= rs.getString("email") %>
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-phone"></i> <%= rs.getString("phone_number") %>
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-circle status-<%= rs.getBoolean("is_active") ? "active" : "inactive" %>"></i>
                                Status: <%= rs.getBoolean("is_active") ? "Active" : "Inactive" %>
                            </li>
                        </ul>
                        <div class="card-body text-center">
                            <div class="btn-group">
                                <a href="Admin?action=editDoctor&id=<%= rs.getString("doctor_id") %>" 
                                   class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="Admin?action=viewDoctor&id=<%= rs.getString("doctor_id") %>" 
                                   class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <button onclick="toggleStatus(<%= rs.getString("doctor_id") %>)" 
                                        class="btn btn-<%= rs.getBoolean("is_active") ? "danger" : "success" %> btn-sm">
                                    <i class="fas fa-power-off"></i> 
                                    <%= rs.getBoolean("is_active") ? "Deactivate" : "Activate" %>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function toggleStatus(doctorId) {
            if(confirm('Are you sure you want to change this doctor\'s status?')) {
                window.location.href = 'Admin?action=toggleDoctorStatus&id=' + doctorId;
            }
        }
    </script>
</body>
</html>