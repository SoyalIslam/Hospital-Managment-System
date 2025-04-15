package com.hospital.management.system;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet(name = "Appointment", urlPatterns = "/appointment")
public class Appointment extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hospital";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "view":
                    viewAppointment(req, resp);
                    break;
                case "schedule":
                    showScheduleForm(req, resp);
                    break;
                case "cancel":
                    cancelAppointment(req, resp);
                    break;
                case "list":
                    listAppointments(req, resp);
                    break;
                default:
                    resp.sendRedirect("appointment.jsp");
            }
        } else {
            resp.sendRedirect("appointment.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "schedule":
                    scheduleAppointment(req, resp);
                    break;
                case "update":
                    updateAppointment(req, resp);
                    break;
                default:
                    resp.sendRedirect("appointment.jsp");
            }
        } else {
            resp.sendRedirect("appointment.jsp");
        }
    }

    private void viewAppointment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String appointmentId = req.getParameter("id");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.*, p.name as patient_name, d.name as doctor_name " +
                        "FROM appointments a " +
                        "JOIN patients p ON a.patient_id = p.patient_id " +
                        "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                        "WHERE a.appointment_id = ?";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, appointmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                req.setAttribute("appointment", rs);
                req.getRequestDispatcher("/patient/viewAppointment.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Appointment not found");
                req.getRequestDispatcher("/patient/appointment.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/patient/appointment.jsp").forward(req, resp);
        }
    }

    private void showScheduleForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Get list of doctors for the dropdown
            String sql = "SELECT doctor_id, name, specialization FROM doctors";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            req.setAttribute("doctors", rs);
            req.getRequestDispatcher("/patient/scheduleAppointment.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/patient/appointment.jsp").forward(req, resp);
        }
    }

    private void scheduleAppointment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String patientId = (String) session.getAttribute("patientId");
        String doctorId = req.getParameter("doctorId");
        String appointmentDate = req.getParameter("appointmentDate");
        String appointmentTime = req.getParameter("appointmentTime");
        String reason = req.getParameter("reason");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Check if the time slot is available
            String checkSql = "SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND appointment_date = ? AND appointment_time = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, doctorId);
            checkStmt.setString(2, appointmentDate);
            checkStmt.setString(3, appointmentTime);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                req.setAttribute("error", "This time slot is already booked");
                showScheduleForm(req, resp);
                return;
            }

            // Insert new appointment
            String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason, status) " +
                        "VALUES (?, ?, ?, ?, ?, 'SCHEDULED')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, patientId);
            stmt.setString(2, doctorId);
            stmt.setString(3, appointmentDate);
            stmt.setString(4, appointmentTime);
            stmt.setString(5, reason);
            stmt.executeUpdate();

            req.setAttribute("success", "Appointment scheduled successfully");
            resp.sendRedirect("Appointment?action=list");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            showScheduleForm(req, resp);
        }
    }

    private void cancelAppointment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String appointmentId = req.getParameter("id");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE appointments SET status = 'CANCELLED' WHERE appointment_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, appointmentId);
            stmt.executeUpdate();

            req.setAttribute("success", "Appointment cancelled successfully");
            resp.sendRedirect("Appointment?action=list");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect("Appointment?action=list");
        }
    }

    private void listAppointments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userType = (String) session.getAttribute("userType");
        String userId = userType.equals("doctor") ? 
            (String) session.getAttribute("doctorId") : 
            (String) session.getAttribute("patientId");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = userType.equals("doctor") ?
                "SELECT a.*, p.name as patient_name " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "WHERE a.doctor_id = ? ORDER BY a.appointment_date, a.appointment_time" :
                "SELECT a.*, d.name as doctor_name " +
                "FROM appointments a " +
                "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                "WHERE a.patient_id = ? ORDER BY a.appointment_date, a.appointment_time";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            req.setAttribute("appointments", rs);
            String jspPage = userType.equals("doctor") ? "/doctor/appointments.jsp" : "/patient/appointments.jsp";
            req.getRequestDispatcher(jspPage).forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect(userType + ".jsp");
        }
    }

    private void updateAppointment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String appointmentId = req.getParameter("id");
        String status = req.getParameter("status");
        String notes = req.getParameter("notes");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE appointments SET status = ?, notes = ? WHERE appointment_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, notes);
            stmt.setString(3, appointmentId);
            stmt.executeUpdate();

            req.setAttribute("success", "Appointment updated successfully");
            resp.sendRedirect("Appointment?action=list");
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            resp.sendRedirect("Appointment?action=list");
        }
    }
}