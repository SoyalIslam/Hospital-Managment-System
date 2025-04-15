package com.hospital.management.system;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "Admin", urlPatterns = "/Admin")
public class Admin extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hospital";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "viewDoctors":
                    viewDoctors(req, resp);
                    break;
                case "viewPatients":
                    viewPatients(req, resp);
                    break;
                case "viewAppointments":
                    viewAppointments(req, resp);
                    break;
                case "dashboard":
                    showDashboard(req, resp);
                    break;
                default:
                    resp.sendRedirect("admin.jsp");
            }
        } else {
            resp.sendRedirect("admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "addDoctor":
                    addDoctor(req, resp);
                    break;
                case "removeDoctor":
                    removeDoctor(req, resp);
                    break;
                case "updateDoctor":
                    updateDoctor(req, resp);
                    break;
                case "addPatient":
                    addPatient(req, resp);
                    break;
                case "removePatient":
                    removePatient(req, resp);
                    break;
                case "updatePatient":
                    updatePatient(req, resp);
                    break;
                default:
                    resp.sendRedirect("admin.jsp");
            }
        } else {
            resp.sendRedirect("admin.jsp");
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Get total counts
            Statement stmt = conn.createStatement();
            ResultSet rs;

            // Count doctors
            rs = stmt.executeQuery("SELECT COUNT(*) as doctor_count FROM doctors");
            rs.next();
            req.setAttribute("doctorCount", rs.getInt("doctor_count"));

            // Count patients
            rs = stmt.executeQuery("SELECT COUNT(*) as patient_count FROM patients");
            rs.next();
            req.setAttribute("patientCount", rs.getInt("patient_count"));

            // Count today's appointments
            rs = stmt.executeQuery("SELECT COUNT(*) as appointment_count FROM appointments WHERE DATE(appointment_date) = CURDATE()");
            rs.next();
            req.setAttribute("todayAppointments", rs.getInt("appointment_count"));

            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        }
    }

    private void viewDoctors(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM doctors ORDER BY name");
            req.setAttribute("doctors", rs);
            req.getRequestDispatcher("/admin/doctors.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/admin/doctors.jsp").forward(req, resp);
        }
    }

    private void viewPatients(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM patients ORDER BY name");
            req.setAttribute("patients", rs);
            req.getRequestDispatcher("/admin/patients.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/admin/patients.jsp").forward(req, resp);
        }
    }

    private void viewAppointments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.*, p.name as patient_name, d.name as doctor_name " +
                        "FROM appointments a " +
                        "JOIN patients p ON a.patient_id = p.patient_id " +
                        "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                        "ORDER BY a.appointment_date, a.appointment_time";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            req.setAttribute("appointments", rs);
            req.getRequestDispatcher("/admin/appointments.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/admin/appointments.jsp").forward(req, resp);
        }
    }

    private void addDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String specialization = req.getParameter("specialization");
        String phoneNumber = req.getParameter("phoneNumber");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO doctors (name, email, password, specialization, phone_number) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password); // In production, make sure to hash the password
            stmt.setString(4, specialization);
            stmt.setString(5, phoneNumber);
            stmt.executeUpdate();

            req.setAttribute("success", "Doctor added successfully");
            resp.sendRedirect("Admin?action=viewDoctors");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect("Admin?action=viewDoctors");
        }
    }

    private void removeDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // First check if doctor has any appointments
            String checkSql = "SELECT COUNT(*) FROM appointments WHERE doctor_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, doctorId);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                req.setAttribute("error", "Cannot remove doctor with existing appointments");
                resp.sendRedirect("Admin?action=viewDoctors");
                return;
            }

            // If no appointments, proceed with removal
            String sql = "DELETE FROM doctors WHERE doctor_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, doctorId);
            stmt.executeUpdate();

            req.setAttribute("success", "Doctor removed successfully");
            resp.sendRedirect("Admin?action=viewDoctors");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect("Admin?action=viewDoctors");
        }
    }

    private void updateDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String specialization = req.getParameter("specialization");
        String phoneNumber = req.getParameter("phoneNumber");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE doctors SET name = ?, email = ?, specialization = ?, phone_number = ? WHERE doctor_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, specialization);
            stmt.setString(4, phoneNumber);
            stmt.setString(5, doctorId);
            stmt.executeUpdate();

            req.setAttribute("success", "Doctor updated successfully");
            resp.sendRedirect("Admin?action=viewDoctors");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect("Admin?action=viewDoctors");
        }
    }

    // Similar methods for patient management
    private void addPatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementation similar to addDoctor
    }

    private void removePatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementation similar to removeDoctor
    }

    private void updatePatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementation similar to updateDoctor
    }
}