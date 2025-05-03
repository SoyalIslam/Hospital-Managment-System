package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AppointmentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patientIdStr = request.getParameter("patient_id");
        String doctorIdStr = request.getParameter("doctor_id");
        String date = request.getParameter("date");

        System.out.println("AppointmentServlet: patient_id=" + patientIdStr + ", doctor_id=" + doctorIdStr + ", date=" + date);

        try {
            int patientId = Integer.parseInt(patientIdStr);
            int doctorId = Integer.parseInt(doctorIdStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "INSERT INTO appointments (patient_id, doctor_id, date) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientId);
            stmt.setInt(2, doctorId);
            stmt.setString(3, date);
            int rows = stmt.executeUpdate();
            System.out.println("AppointmentServlet: Rows inserted=" + rows);
            conn.close();
            response.sendRedirect("appointments.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error booking appointment: " + e.getMessage());
            request.getRequestDispatcher("appointments.jsp").forward(request, response);
        }
    }
}