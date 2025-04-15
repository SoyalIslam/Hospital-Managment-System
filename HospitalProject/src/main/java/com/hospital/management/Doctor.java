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

@WebServlet(name = "doctor", urlPatterns = "/doctor")
public class Doctor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle GET requests
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "viewProfile":
                    viewProfile(req, resp);
                    break;
                case "viewAppointments":
                    viewAppointments(req, resp);
                    break;
                case "viewPatients":
                    viewPatients(req, resp);
                    break;
                default:
                    req.getRequestDispatcher("doctor.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
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
                case "addPrescription":
                    addPrescription(req, resp);
                    break;
                default:
                    req.getRequestDispatcher("doctor.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }

    private void viewProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve doctor profile from database
        String doctorId = req.getParameter("doctorId");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM doctors WHERE doctor_id = ?");
            stmt.setString(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                req.setAttribute("doctorName", rs.getString("name"));
                req.setAttribute("doctorEmail", rs.getString("email"));
                req.setAttribute("doctorPhoneNumber", rs.getString("phone_number"));
                req.setAttribute("doctorSpecialization", rs.getString("specialization"));
                req.getRequestDispatcher("doctorProfile.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Doctor not found");
                req.getRequestDispatcher("doctor.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error retrieving doctor profile");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }

    private void viewAppointments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve appointments for doctor
        String doctorId = req.getParameter("doctorId");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM appointments WHERE doctor_id = ?");
            stmt.setString(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            req.setAttribute("appointments", rs);
            req.getRequestDispatcher("doctorAppointments.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error retrieving appointments");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }

    private void viewPatients(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve patients for doctor
        String doctorId = req.getParameter("doctorId");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM patients WHERE doctor_id = ?");
            stmt.setString(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            req.setAttribute("patients", rs);
            req.getRequestDispatcher("doctorPatients.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error retrieving patients");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Update doctor profile
        String doctorId = req.getParameter("doctorId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phoneNumber = req.getParameter("phoneNumber");
        String specialization = req.getParameter("specialization");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("UPDATE doctors SET name = ?, email = ?, phone_number = ?, specialization = ? WHERE doctor_id = ?");
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, specialization);
            stmt.setString(5, doctorId);
            stmt.executeUpdate();
            req.setAttribute("success", "Profile updated successfully");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error updating profile");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }

    private void addPrescription(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Add prescription for patient
        String patientId = req.getParameter("patientId");
        String medication = req.getParameter("medication");
        String dosage = req.getParameter("dosage");
        String instructions = req.getParameter("instructions");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "password");
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO prescriptions (patient_id, medication, dosage, instructions) VALUES (?, ?, ?, ?)");
            stmt.setString(1, patientId);
            stmt.setString(2, medication);
            stmt.setString(3, dosage);
            stmt.setString(4, instructions);
            stmt.executeUpdate();
            req.setAttribute("success", "Prescription added successfully");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error adding prescription");
            req.getRequestDispatcher("doctor.jsp").forward(req, resp);
        }
    }
}