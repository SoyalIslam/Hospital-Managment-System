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
    <title>Doctors - HMS</title>
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
                    <li class="nav-item"><a class="nav-link active" href="doctors.jsp">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="appointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5" data-aos="fade-up">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="section-title">Doctor Management</h2>
            <span class="badge graphic-bg-primary">Total Doctors:
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM doctors");
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
                <div class="card p-4 doctor-card">
                    <h3 class="text-primary mb-4"><i class="fas fa-user-md me-2"></i>Add New Doctor</h3>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <form action="DoctorServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control" placeholder="Dr. John Smith" required aria-label="Doctor name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Specialty</label>
                            <input type="text" name="specialty" class="form-control" placeholder="Cardiology" required aria-label="Doctor specialty">
                            <small class="text-muted">Enter the doctor's medical specialty</small>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-3">
                            <i class="fas fa-user-plus me-2"></i>Add Doctor
                        </button>
                    </form>
                </div>
            </div>
            <div class="col-md-8" data-aos="fade-left">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0"><i class="fas fa-stethoscope me-2"></i>Our Medical Team</h3>
                        <small class="text-muted">Showing all registered doctors</small>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-primary">
                                <tr>
                                    <th>ID</th>
                                    <th>Doctor Name</th>
                                    <th>Specialty</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT * FROM doctors ORDER BY name");
                                        while (rs.next()) {
                                            out.println("<tr><td>" + rs.getInt("id") + "</td><td class='fw-bold'>" + rs.getString("name") +
                                                "</td><td><span class='badge specialty-badge'>" + rs.getString("specialty") + "</span></td>" +
                                                "<td><a href='#' class='btn btn-sm btn-outline-primary'><i class='fas fa-eye'></i> View</a></td></tr>");
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='4' class='text-center text-danger'>Error loading doctor data</td></tr>");
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