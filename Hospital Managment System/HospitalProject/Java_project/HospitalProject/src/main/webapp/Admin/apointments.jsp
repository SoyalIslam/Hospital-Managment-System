<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap & Font Awesome -->
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
    <div class="container mt-5">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-calendar-check"></i> All Appointments</h2>
            <button class="btn btn-primary" data-toggle="modal" data-target="#filterModal">
                <i class="fas fa-filter"></i> Filter
            </button>
        </div>

        <!-- Alert Messages -->
        <% String success = (String) request.getAttribute("success");
           String error = (String) request.getAttribute("error"); %>
        <% if (success != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= success %>
                <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
            </div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
            </div>
        <% } %>

        <!-- Appointments Table -->
        <div class="card">
            <div class="card-body table-responsive">
                <table class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet rs = (ResultSet) request.getAttribute("appointments");
                            if (rs != null) {
                                while (rs.next()) {
                                    String id = rs.getString("appointment_id");
                                    String patient = rs.getString("patient_name");
                                    String doctor = rs.getString("doctor_name");
                                    String date = rs.getString("appointment_date");
                                    String time = rs.getString("appointment_time");
                                    String status = rs.getString("status");
                                    String statusClass = "status-" + status.toLowerCase();
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= patient %></td>
                            <td><%= doctor %></td>
                            <td><%= date %></td>
                            <td><%= time %></td>
                            <td><span class="<%= statusClass %>"><i class="fas fa-circle"></i> <%= status %></span></td>
                            <td>
                                <div class="btn-group">
                                    <button class="btn btn-info btn-sm" onclick="viewDetails('<%= id %>')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-warning btn-sm" onclick="editAppointment('<%= id %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="cancelAppointment('<%= id %>')">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr><td colspan="7" class="text-center text-muted">No appointments found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Filter Modal -->
    <div class="modal fade" id="filterModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="Admin" method="get">
                    <input type="hidden" name="action" value="filterAppointments">
                    <div class="modal-header">
                        <h5 class="modal-title">Filter Appointments</h5>
                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Date Range</label>
                            <div class="row">
                                <div class="col">
                                    <input type="date" class="form-control" name="startDate">
                                </div>
                                <div class="col">
                                    <input type="date" class="form-control" name="endDate">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Status</label>
                            <select class="form-control" name="status">
                                <option value="">All</option>
                                <option value="SCHEDULED">Scheduled</option>
                                <option value="COMPLETED">Completed</option>
                                <option value="CANCELLED">Cancelled</option>
                                <option value="PENDING">Pending</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Apply Filter</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" defer></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" defer></script>

    <script>
        function viewDetails(id) {
            window.location.href = 'Admin?action=viewAppointmentDetails&id=' + encodeURIComponent(id);
        }
        function editAppointment(id) {
            window.location.href = 'Admin?action=editAppointment&id=' + encodeURIComponent(id);
        }
        function cancelAppointment(id) {
            if (confirm('Are you sure you want to cancel this appointment?')) {
                window.location.href = 'Admin?action=cancelAppointment&id=' + encodeURIComponent(id);
            }
        }
    </script>
</body>
</html>
