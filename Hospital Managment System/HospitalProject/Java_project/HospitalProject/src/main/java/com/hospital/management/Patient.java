package com.hospital.management.system;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "Patient", urlPatterns = "/Patient")
public class Patient extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle GET requests
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "viewProfile":
                    viewProfile(req, resp);
                    break;
                case "bookAppointment":
                    bookAppointment(req, resp);
                    break;
                case "viewAppointments":
                    viewAppointments(req, resp);
                    break;
                default:
                    req.getRequestDispatcher("patient.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle POST requests
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "updateProfile":
                    updateProfile(req, resp);
                    break;
                case "bookAppointment":
                    bookAppointment(req, resp);
                    break;
                default:
                    req.getRequestDispatcher("patient.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }

    private void viewProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve patient profile from database
        String patientId = req.getParameter("patientId");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM patients WHERE patient_id = ?");
            stmt.setString(1, patientId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                req.setAttribute("patientName", rs.getString("name"));
                req.setAttribute("patientEmail", rs.getString("email"));
                req.setAttribute("patientPhoneNumber", rs.getString("phone_number"));
                req.getRequestDispatcher("patientProfile.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Patient not found");
                req.getRequestDispatcher("patient.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error retrieving patient profile");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }

    private void bookAppointment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Book appointment for patient
        String patientId = req.getParameter("patientId");
        String doctorId = req.getParameter("doctorId");
        String appointmentDate = req.getParameter("appointmentDate");
        String appointmentTime = req.getParameter("appointmentTime");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time) VALUES (?, ?, ?, ?)");
            stmt.setString(1, patientId);
            stmt.setString(2, doctorId);
            stmt.setString(3, appointmentDate);
            stmt.setString(4, appointmentTime);
            stmt.executeUpdate();
            req.setAttribute("success", "Appointment booked successfully");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error booking appointment");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }

    private void viewAppointments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve appointments for patient
        String patientId = req.getParameter("patientId");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM appointments WHERE patient_id = ?");
            stmt.setString(1, patientId);
            ResultSet rs = stmt.executeQuery();
            req.setAttribute("appointments", rs);
            req.getRequestDispatcher("patientAppointments.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error retrieving appointments");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Update patient profile
        String patientId = req.getParameter("patientId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phoneNumber = req.getParameter("phoneNumber");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("UPDATE patients SET name = ?, email = ?, phone_number = ? WHERE patient_id = ?");
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, patientId);
            stmt.executeUpdate();
            req.setAttribute("success", "Profile updated successfully");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error updating profile");
            req.getRequestDispatcher("patient.jsp").forward(req, resp);
        }
    }
}w