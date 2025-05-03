package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PatientServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");

        System.out.println("PatientServlet: name=" + name + ", age=" + ageStr + ", gender=" + gender);

        try {
            int age = Integer.parseInt(ageStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "INSERT INTO patients (name, age, gender) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setInt(2, age);
            stmt.setString(3, gender);
            int rows = stmt.executeUpdate();
            System.out.println("PatientServlet: Rows inserted=" + rows);
            conn.close();
            response.sendRedirect("patients.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error adding patient: " + e.getMessage());
            request.getRequestDispatcher("patients.jsp").forward(request, response);
        }
    }
}