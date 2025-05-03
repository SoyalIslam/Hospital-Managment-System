<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% if (session.getAttribute("first_name") == null) {
       response.sendRedirect("login.jsp");
       return;
   } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard - HMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <script>
        window.currentUser = {
            firstName: '<%= session.getAttribute("first_name") != null ? session.getAttribute("first_name") : "" %>'
        };
    </script>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-hospital"></i> HMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="patients.jsp">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="appointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section" data-aos="fade-up">
        <div class="hero-overlay"></div>
        <div class="container">
            <h1 class="hero-title">Welcome, <%= session.getAttribute("first_name") %>!</h1>
            <p class="hero-slogan">Empowering Healthcare with Cutting-Edge Technology</p>
            <a href="#features" class="btn btn-primary btn-lg hero-btn">Explore Features</a>
        </div>
    </div>

    <!-- Quick Links Section -->
    <section  data-aos="fade-up">
        <div class="container quick-links-section">
            <h2 class="section-title">Quick Access</h2>
            <div class="row g-3">
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                    <a href="patients.jsp" class="quick-link-card">
                        <i class="fas fa-user-injured"></i>
                        <h4>Patients</h4>
                    </a>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <a href="doctors.jsp" class="quick-link-card">
                        <i class="fas fa-user-md"></i>
                        <h4>Doctors</h4>
                    </a>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
                    <a href="appointments.jsp" class="quick-link-card">
                        <i class="fas fa-calendar-check"></i>
                        <h4>Appointments</h4>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="container features-section" data-aos="fade-up">
        <h2 class="section-title">Explore HMS Features</h2>
        <div class="row g-4">
            <div class="col-md-4" data-aos="flip-left" data-aos-delay="100">
                <div class="feature-card">
                    <i class="fas fa-user-injured fa-3x mb-3"></i>
                    <h3>Patient Management</h3>
                    <p>Manage patient records with real-time updates and secure storage.</p>
                    <a href="patients.jsp" class="btn btn-primary"><i class="fas fa-users me-2"></i>Manage Patients</a>
                </div>
            </div>
            <div class="col-md-4" data-aos="flip-up" data-aos-delay="200">
                <div class="feature-card">
                    <i class="fas fa-user-md fa-3x mb-3"></i>
                    <h3>Doctor Management</h3>
                    <p>Streamline doctor profiles and schedules with ease.</p>
                    <a href="doctors.jsp" class="btn btn-primary"><i class="fas fa-stethoscope me-2"></i>Manage Doctors</a>
                </div>
            </div>
            <div class="col-md-4" data-aos="flip-right" data-aos-delay="300">
                <div class="feature-card">
                    <i class="fas fa-calendar-check fa-3x mb-3"></i>
                    <h3>Appointment Scheduling</h3>
                    <p>Book and track appointments seamlessly.</p>
                    <a href="appointments.jsp" class="btn btn-primary"><i class="fas fa-calendar me-2"></i>Manage Appointments</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Hospital Info Section -->
    <section class="hospital-info-section" data-aos="fade-up">
        <div class="container">
            <h2 class="section-title">About Our Hospital</h2>
            <div class="row g-4">
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                    <div class="info-card">
                        <i class="fas fa-heartbeat fa-2x mb-3"></i>
                        <h4>Our Mission</h4>
                        <p>Delivering compassionate, high-quality healthcare to enhance lives.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="info-card">
                        <i class="fas fa-eye fa-2x mb-3"></i>
                        <h4>Our Vision</h4>
                        <p>Leading in innovative healthcare solutions and patient care.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
                    <div class="info-card">
                        <i class="fas fa-phone-alt fa-2x mb-3"></i>
                        <h4>Contact Us</h4>
                        <p>Email: info@hmshospital.com<br>Phone: +91-8058803339</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section" data-aos="fade-up">
        <div class="container">
            <h2 class="section-title">What Our Community Says</h2>
            <div class="row g-4">
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="testimonial-card">
                        <p>"HMS has transformed our patient care process. It's intuitive and efficient!"</p>
                        <h5>Dr. Sachin Gurjar</h5>
                        <span>Chief Physician</span>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="testimonial-card">
                        <p>"The appointment system is a game-changer. So easy to use!"</p>
                        <h5>Govind Goyal</h5>
                        <span>Patient</span>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="testimonial-card">
                        <p>"The support team is always responsive and helpful."</p>
                        <h5>Emily Brown</h5>
                        <span>Nurse</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section" data-aos="fade-up">
        <div class="container">
            <h2 class="section-title">System Overview</h2>
            <div class="row g-4">
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                    <div class="stat-card">
                        <h4>Total Patients</h4>
                        <p class="stat-number">
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM patients");
                                    if (rs.next()) {
                                        out.print(rs.getInt("count"));
                                    }
                                    conn.close();
                                } catch (Exception e) {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="stat-card">
                        <h4>Total Doctors</h4>
                        <p class="stat-number">
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
                        </p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
                    <div class="stat-card">
                        <h4>Total Appointments</h4>
                        <p class="stat-number">
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM appointments");
                                    if (rs.next()) {
                                        out.print(rs.getInt("count"));
                                    }
                                    conn.close();
                                } catch (Exception e) {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>HMS Hospital</h5>
                    <p>123 Health St, Wellness City<br>Email: info@hmshospital.com<br>Phone: +1 (800) 123-4567</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5>Connect With Us</h5>
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <hr>
            <p class="text-center mb-0">&copy; 2025 HMS Hospital. All rights reserved.</p>
        </div>
    </footer>

    <!-- Chatbot -->
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
    <script>
        AOS.init({ duration: 1000, once: true });
        // Animate stat numbers
        document.querySelectorAll('.stat-number').forEach((el) => {
            const target = parseInt(el.textContent) || 0;
            let current = 0;
            const increment = target / 50;
            const updateCount = () => {
                current += increment;
                if (current < target) {
                    el.textContent = Math.ceil(current);
                    requestAnimationFrame(updateCount);
                } else {
                    el.textContent = target;
                }
            };
            updateCount();
        });
    </script>
</body>
</html>