<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <style>
        /* Ensure content is not hidden behind navbar */
        body {
            padding-top: 70px; /* Adjust based on navbar height */
        }
        /* Hover effects for team cards */
        .team-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        /* Hover effect for team images */
        .team-img {
            transition: transform 0.3s ease, filter 0.3s ease;
        }
        .team-card:hover .team-img {
            transform: scale(1.05);
            filter: brightness(1.1);
        }
        /* Ensure section titles are visible */
        .section-title {
            margin-top: 20px;
            padding-top: 20px;
        }
        /* Hero image hover effect */
        .hero-img {
            transition: transform 0.3s ease;
        }
        .hero-img:hover {
            transform: scale(1.03);
        }
    </style>
    <script>
        window.currentUser = {
            firstName: '<%= session.getAttribute("first_name") != null ? session.getAttribute("first_name") : "" %>'
        };
    </script>
</head>
<body class="fade-in">
    <nav class="navbar navbar-expand-lg fixed-top navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-hospital"></i> HMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if (session.getAttribute("first_name") != null) { %>
                        <li class="nav-item"><a class="nav-link" href="patients.jsp">Patients</a></li>
                        <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                        <li class="nav-item"><a class="nav-link" href="appointments.jsp">Appointments</a></li>
                        <li class="nav-item"><a class="nav-link active" href="about.jsp">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="signup.jsp">Sign Up</a></li>
                        <li class="nav-item"><a class="nav-link active" href="about.jsp">About</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="container mt-5" data-aos="fade-up">
        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold text-primary">About Our Hospital Management System</h1>
            <p class="lead text-muted">Transforming healthcare administration through innovative technology</p>
        </div>

        <div class="row align-items-center mb-5">
            <div class="col-lg-6 mb-4" data-aos="fade-right">
                <img src="https://advinhealthcare.com/wp-content/uploads/2022/12/Types-of-Hospitals-2.jpg"
                     class="hero-img img-fluid rounded shadow" alt="Hospital Team" loading="lazy">
            </div>
            <div class="col-lg-6" data-aos="fade-left">
                <div class="card p-4 h-100 shadow-sm">
                    <h2 class="text-primary mb-4">Our Mission</h2>
                    <p class="lead">The Hospital Management System (HMS) is designed to revolutionize healthcare operations by providing an integrated platform for managing patients, doctors, and appointments with unprecedented efficiency.</p>

                    <div class="d-flex align-items-start mb-3">
                        <i class="fas fa-check-circle text-success me-3 mt-1"></i>
                        <div>
                            <h5 class="mb-1">Streamlined Workflows</h5>
                            <p class="text-muted mb-0">Reduce administrative burdens and focus on patient care with our intuitive interface.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start mb-3">
                        <i class="fas fa-check-circle text-success me-3 mt-1"></i>
                        <div>
                            <h5 class="mb-1">Real-Time Data</h5>
                            <p class="text-muted mb-0">Access up-to-date patient and appointment information instantly.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start">
                        <i class="fas fa-check-circle text-success me-3 mt-1"></i>
                        <div>
                            <h5 class="mb-1">Secure & Scalable</h5>
                            <p class="text-muted mb-0">Built with robust security measures to protect sensitive data and scale with your needs.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Team Section -->
        <h2 class="section-title" data-aos="zoom-in">Meet Our Team</h2>
        <div class="row g-4">
            <div class="col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="team-card card p-3 shadow-sm">
                    <img src="https://media.licdn.com/dms/image/v2/D5603AQFNmeficTCeYg/profile-displayphoto-shrink_400_400/B56ZSt38T_HEAk-/0/1738083912213?e=1750896000&v=beta&t=iIBPHkNSEAbypoWs4rnSnyfUsX7eXiI4UMj7K0IXBLA"
     alt="Nikhil Jangid"
     class="img-fluid rounded-circle mb-3"
     style="width: 200px; height: 200px; object-fit: cover;"
     loading="lazy">

                    <h3>Nikhil Jangid</h3>
                    <p class="text-muted">Lead Developer</p>
                    <p>Passionate about crafting innovative solutions for healthcare technology, Nikhil brings expertise in full-stack development and UI/UX design.</p>
                    <div class="social-links">
                        <a href="https://github.com/nikhiljngd" class="btn btn-outline-primary btn-sm"><i class="fab fa-github"></i></a>
                        <a href="https://linkedin.com/in/nikhiljngd" class="btn btn-outline-primary btn-sm"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6" data-aos="fade-up" data-aos-delay="200">
                <div class="team-card card p-3 shadow-sm">
                    <img src="https://media.licdn.com/dms/image/v2/D5603AQEh5CU_LxDIqg/profile-displayphoto-shrink_400_400/B56ZZeIcbWHAAg-/0/1745335994539?e=1750896000&v=beta&t=q1K-XSYk7CCM80klJWvzBCEOFzs4glb7OdsiQkBhTdg"
                    alt="Soyal Islam"
                    class="img-fluid rounded-circle mb-3"
                    style="width: 200px; height: 200px; object-fit: cover;"
                    loading="lazy">
               
                    <h3>Soyal Islam</h3>
                    <p class="text-muted">System Architect</p>
                    <p>Soyal specializes in designing scalable systems and ensuring seamless integration of complex healthcare workflows.</p>
                    <div class="social-links">
                        <a href="https://github.com/soyal-islam" class="btn btn-outline-primary btn-sm"><i class="fab fa-github"></i></a>
                        <a href="https://linkedin.com/in/soyal-islam" class="btn btn-outline-primary btn-sm"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Vision Section -->
        <div class="stats-section mt-5" data-aos="fade-up">
            <h2 class="section-title text-center mb-4">Our Vision</h2>
            <div class="row g-4">
                <!-- Vision Card 1 -->
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                    <div class="stat-card card p-4 shadow-sm text-center h-100">
                        <i class="fas fa-heartbeat fa-3x mb-3 text-primary" aria-hidden="true"></i>
                        <h4 class="mb-2">Patient-Centric Care</h4>
                        <p>Empowering healthcare providers to deliver personalized care through technology.</p>
                    </div>
                </div>
                <!-- Vision Card 2 -->
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="stat-card card p-4 shadow-sm text-center h-100">
                        <i class="fas fa-cogs fa-3x mb-3 text-primary" aria-hidden="true"></i>
                        <h4 class="mb-2">Operational Excellence</h4>
                        <p>Optimizing hospital operations with smart, automated solutions.</p>
                    </div>
                </div>
                <!-- Vision Card 3 -->
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
                    <div class="stat-card card p-4 shadow-sm text-center h-100">
                        <i class="fas fa-globe fa-3x mb-3 text-primary" aria-hidden="true"></i>
                        <h4 class="mb-2">Global Impact</h4>
                        <p>Transforming healthcare systems worldwide with accessible, scalable technology.</p>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

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
    <script>AOS.init({ duration: 1200, once: true });</script>
</body>
</html>