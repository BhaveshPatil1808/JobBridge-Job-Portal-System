package com.jobportal;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class applyjob
 */
public class applyjob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public applyjob() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String jobIdParam = request.getParameter("jobId");
        int jobId = Integer.parseInt(jobIdParam);

        String email = getSetEmail.getEmail();  // From shared session utility
        int seekerId = 0;

        try {
            Connection con = Dbconnection.connect();

            // Get seeker ID
            PreparedStatement ps1 = con.prepareStatement("SELECT id FROM seeker WHERE email = ?");
            ps1.setString(1, email);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                seekerId = rs.getInt("id");
            }

            // Check if already applied
            PreparedStatement check = con.prepareStatement("SELECT * FROM applications WHERE seekerId = ? AND jobId = ?");
            check.setInt(1, seekerId);
            check.setInt(2, jobId);
            ResultSet checkRS = check.executeQuery();
            if (checkRS.next()) {
                response.getWriter().println("<h3>You have already applied for this job.</h3>");
                return;
            }

            // Insert into applications
            String date = LocalDate.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
            String status = "Applied";

            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO applications (seekerId, jobId, applicationDate, status) VALUES (?, ?, ?, ?)");
            ps2.setInt(1, seekerId);
            ps2.setInt(2, jobId);
            ps2.setString(3, date);
            ps2.setString(4, status);

            int result = ps2.executeUpdate();

            if (result > 0) {
                response.sendRedirect("viewmyapplications.jsp");
            } else {
                response.getWriter().println("<h3>Failed to apply for the job.</h3>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
	}

}
