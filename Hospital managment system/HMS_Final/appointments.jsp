<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% if (session.getAttribute("first_name") == null) {
       response.sendRedirect("login.jsp");
       return;
   } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <style>
        body {
            padding-top: 70px; /* Adjust for fixed navbar height */
        }
        .section-title {
            margin-top: 20px;
            padding-top: 20px;
        }
    </style>
    <script>
        window.currentUser = {
            firstName: '<%= session.getAttribute("first_name") != null ? session.getAttribute("first_name") : "" %>'
        };
    </script>
</head>
<body>
    <div class="bg-particles"></div>
    <nav class="navbar navbar-expand-lg fixed-top navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-hospital"></i> HMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="patients.jsp">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link active" href="appointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5" data-aos="fade-up">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="section-title">Appointment Scheduling</h2>
            <span class="badge graphic-bg-primary">Today's Appointments:
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM appointments WHERE date = CURDATE()");
                        if (rs.next()) {
                            out.print(rs.getInt("count"));
                        }
                        conn.close();
                    } catch (Exception e) {
                        out.print("N/A");
                    }
                %>
            </span>
        </div>

        <div class="row">
            <div class="col-md-4" data-aos="fade-right">
                <div class="card p-4 appointment-card">
                    <h3 class="text-success mb-4"><i class="fas fa-calendar-plus me-2"></i>Schedule Appointment</h3>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <form action="AppointmentServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Select Patient</label>
                            <select name="patient_id" class="form-select" required aria-label="Select patient">
                                <option value="" selected disabled>Choose patient...</option>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT id, name FROM patients ORDER BY name");
                                        while (rs.next()) {
                                            out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("name") + "</option>");
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        out.println("<option>Error loading patients</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Select Doctor</label>
                            <select name="doctor_id" class="form-select" required aria-label="Select doctor">
                                <option value="" selected disabled>Choose doctor...</option>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT id, name, specialty FROM doctors ORDER BY name");
                                        while (rs.next()) {
                                            out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("name") + " (" + rs.getString("specialty") + ")</option>");
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        out.println("<option>Error loading doctors</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Appointment Date</label>
                            <input type="date" name="date" class="form-control" required aria-label="Appointment date">
                            <small class="text-muted">Select a future date</small>
                        </div>
                        <button type="submit" class="btn btn-success w-100 mt-3">
                            <i class="fas fa-calendar-check me-2"></i>Book Appointment
                        </button>
                    </form>
                </div>
            </div>
            <div class="col-md-8" data-aos="fade-left">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Upcoming Appointments</h3>
                        <small class="text-muted">Next 30 days</small>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-primary">
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery(
                                            "SELECT a.id, p.name AS patient_name, d.name AS doctor_name, a.date " +
                                            "FROM appointments a " +
                                            "JOIN patients p ON a.patient_id = p.id " +
                                            "JOIN doctors d ON a.doctor_id = d.id " +
                                            "WHERE a.date >= CURDATE() " +
                                            "ORDER BY a.date LIMIT 50");
                                        while (rs.next()) {
                                            out.println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("patient_name") +
                                                "</td><td>" + rs.getString("doctor_name") + "</td><td><span class='badge date-badge'>" +
                                                rs.getString("date") + "</span></td><td><span class='badge graphic-bg-warning'>Pending</span></td></tr>");
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='5' class='text-center text-danger'>Error loading appointment data</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="chatbot-container">
        <button class="chatbot-toggle" aria-label="Open chat assistant">
            <div class="toggle-icon-wrapper">
                <svg class="toggle-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M20 2H4C2.9 2 2 2.9 2 4V22L6 18H20C21.1 18 22 17.1 22 16V4C22 2.9 21.1 2 20 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7 9H17M7 13H14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </div>
        </button>
        <div class="chatbot-window">
            <div class="chatbot-header">
                <div class="chatbot-avatar">
                    <div class="avatar-circle"><span>HMS</span></div>
                </div>
                <div class="chatbot-title">
                    <h3>HMS Assistant</h3>
                    <span class="status">Online</span>
                </div>
                <div class="chatbot-controls">
                    <button class="minimize-btn" aria-label="Minimize chat">−</button>
                    <button class="close-btn" aria-label="Close chat">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="chatbot-body"></div>
            <div class="chatbot-footer">
                <input type="text" class="chatbot-input" placeholder="Type your message..." aria-label="Type your message">
                <button class="send-btn" aria-label="Send message">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 2L11 13M22 2L15 22L11 13L2 9L22 2Z"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script src="js/chatbot.js"></script>
    <script>AOS.init({ duration: 1200, once: true });</script>
</body>
</html>