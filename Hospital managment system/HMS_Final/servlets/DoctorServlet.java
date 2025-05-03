package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoctorServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String specialty = request.getParameter("specialty");

        System.out.println("DoctorServlet: name=" + name + ", specialty=" + specialty);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "INSERT INTO doctors (name, specialty) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, specialty);
            int rows = stmt.executeUpdate();
            System.out.println("DoctorServlet: Rows inserted=" + rows);
            conn.close();
            response.sendRedirect("doctors.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error adding doctor: " + e.getMessage());
            request.getRequestDispatcher("doctors.jsp").forward(request, response);
        }
    }
}