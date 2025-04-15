@WebServlet("/editDoctor")
public class EditDoctorServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String doctorId = req.getParameter("doctorId");
		String name = req.getParameter("name");
		String specialization = req.getParameter("specialization");
		String qualification = req.getParameter("qualification");
		String experience = req.getParameter("experience");
		String contactNumber = req.getParameter("contactNumber");
		String email = req.getParameter("email");

		// Update the doctor's details in the database
		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String sql = "UPDATE doctors SET name = ?, specialization = ?, qualification = ?, experience = ?, contact_number = ?, email = ? WHERE doctor_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, specialization);
			stmt.setString(3, qualification);
			stmt.setString(4, experience);
			stmt.setString(5, contactNumber);
			stmt.setString(6, email);
			stmt.setString(7, doctorId);
			stmt.executeUpdate();

			req.setAttribute("success", "Doctor updated successfully");
			resp.sendRedirect("doctors.jsp");
		} catch (SQLException e) {
			req.setAttribute("error", "Database error: " + e.getMessage());
			resp.sendRedirect("editDoctor.jsp");
		}
	}
}