package com.hospital.management.system;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HMS", urlPatterns = "/HMS")
public class HMS extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle GET requests
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "login":
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    break;
                case "signup":
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                    break;
                case "admin":
                    req.getRequestDispatcher("admin.jsp").forward(req, resp);
                    break;
                case "doctor":
                    req.getRequestDispatcher("doctor.jsp").forward(req, resp);
                    break;
                case "patient":
                    req.getRequestDispatcher("patient.jsp").forward(req, resp);
                    break;
                default:
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle POST requests
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "login":
                    String username = req.getParameter("username");
                    String password = req.getParameter("password");
                    // Authenticate user
                    if (authenticateUser(username, password)) {
                        // Redirect to dashboard
                        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
                    } else {
                        // Display error message
                        req.setAttribute("error", "Invalid username or password");
                        req.getRequestDispatcher("login.jsp").forward(req, resp);
                    }
                    break;
                case "signup":
                    String name = req.getParameter("name");
                    String email = req.getParameter("email");
                    String phoneNumber = req.getParameter("phoneNumber");
                    // Register user
                    if (registerUser(name, email, phoneNumber)) {
                        // Redirect to login page
                        req.getRequestDispatcher("login.jsp").forward(req, resp);
                    } else {
                        // Display error message
                        req.setAttribute("error", "Failed to register user");
                        req.getRequestDispatcher("signup.jsp").forward(req, resp);
                    }
                    break;
                default:
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }

    private boolean authenticateUser(String username, String password) {
        // Implement authentication logic here
        // For example, you can query a database to check if the username and password match
        return true; // Replace with actual authentication logic
    }

    private boolean registerUser(String name, String email, String phoneNumber) {
        // Implement registration logic here
        // For example, you can insert a new user into a database
        return true; // Replace with actual registration logic
    }
}