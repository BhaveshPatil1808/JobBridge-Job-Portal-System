package com.jobportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class updateprofile
 */
public class updateprofile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateprofile() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String skills = request.getParameter("skills");
		String contact = request.getParameter("contact");
		String email = getSetEmail.getEmail(); // Static email from session or
												// helper class

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = Dbconnection.connect();

			String query = "UPDATE seeker SET skills = ?, contact = ? WHERE email = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, skills);
			ps.setString(2, contact);
			ps.setString(3, email);

			int result = ps.executeUpdate();
			con.close();

			if (result > 0) {
				// Redirect to success page or dashboard
				response.sendRedirect("seekerdashboard.html");
			} else {
				out.println("<h3 style='color:red;'>❌ Update failed. Try again.</h3>");
			}

		} catch (Exception e) {
			e.printStackTrace();
			out.println("<h3 style='color:red;'>❌ Error: " + e.getMessage() + "</h3>");
		}
	}

}
