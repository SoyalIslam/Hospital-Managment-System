<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Patients - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .patient-row:hover {
            background-color: #f8f9fa;
        }
        .badge-active {
            background-color: #28a745;
        }
        .badge-inactive {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h2><i class="fas fa-users"></i> Manage Patients</h2>
            </div>
            <div class="col-md-6 text-right">
                <a href="Admin?action=addPatient" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Add New Patient
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

        <!-- Search and Filter -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="Admin" method="get" class="form-row align-items-center">
                    <input type="hidden" name="action" value="searchPatients">
                    <div class="col-auto">
                        <input type="text" class="form-control mb-2" name="searchTerm" 
                               placeholder="Search by name or ID">
                    </div>
                    <div class="col-auto">
                        <select class="form-control mb-2" name="bloodGroup">
                            <option value="">Blood Group</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary mb-2">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Patients Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Blood Group</th>
                                <th>Contact</th>
                                <th>Last Visit</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                ResultSet rs = (ResultSet) request.getAttribute("patients");
                                while(rs != null && rs.next()) {
                            %>
                            <tr class="patient-row">
                                <td><%= rs.getString("patient_id") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getInt("age") %></td>
                                <td><%= rs.getString("gender") %></td>
                                <td><%= rs.getString("blood_group") %></td>
                                <td>
                                    <i class="fas fa-phone"></i> <%= rs.getString("phone_number") %><br>
                                    <i class="fas fa-envelope"></i> <%= rs.getString("email") %>
                                </td>
                                <td><%= rs.getDate("last_visit") %></td>
                                <td>
                                    <span class="badge badge-<%= rs.getBoolean("is_active") ? "active" : "inactive" %>">
                                        <%= rs.getBoolean("is_active") ? "Active" : "Inactive" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="Admin?action=viewPatient&id=<%= rs.getString("patient_id") %>" 
                                           class="btn btn-info btn-sm" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="Admin?action=editPatient&id=<%= rs.getString("patient_id") %>" 
                                           class="btn btn-warning btn-sm" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button onclick="togglePatientStatus(<%= rs.getString("patient_id") %>)" 
                                                class="btn btn-danger btn-sm" title="Toggle Status">
                                            <i class="fas fa-power-off"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function togglePatientStatus(patientId) {
            if(confirm('Are you sure you want to change this patient\'s status?')) {
                window.location.href = 'Admin?action=togglePatientStatus&id=' + patientId;
            }
        }
    </script>
</body>
</html>