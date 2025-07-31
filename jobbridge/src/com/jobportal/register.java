package com.jobportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public register() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String role = request.getParameter("role");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String contact = request.getParameter("contact"); // Optional
		String companyName = request.getParameter("companyName"); // Employer
		String skills = request.getParameter("skills"); // Seeker

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = Dbconnection.connect();

			String query = "";
			PreparedStatement ps;

			if ("employer".equals(role)) {
				query = "INSERT INTO employer (name, email, password, companyName, contact) VALUES (?, ?, ?, ?, ?)";
				ps = con.prepareStatement(query);
				ps.setString(1, name);
				ps.setString(2, email);
				ps.setString(3, password);
				ps.setString(4, companyName != null ? companyName : "");
				ps.setString(5, contact != null ? contact : "");
			} else if ("seeker".equals(role)) {
				query = "INSERT INTO seeker (name, email, password, skills, contact) VALUES (?, ?, ?, ?, ?)";
				ps = con.prepareStatement(query);
				ps.setString(1, name);
				ps.setString(2, email);
				ps.setString(3, password);
				ps.setString(4, skills != null ? skills : "");
				ps.setString(5, contact != null ? contact : "");
			} else {
				out.println("<h3 style='color:red;'>Invalid role specified.</h3>");
				return;
			}

			int result = ps.executeUpdate();
			con.close();

			if (result > 0) {
				response.sendRedirect("login.html");
			} else {
				out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
			}

		} catch (Exception e) {
			out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
		}
	}
}
