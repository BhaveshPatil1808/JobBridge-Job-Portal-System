package com.jobportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class postjob
 */
public class postjob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public postjob() {
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
		String title = request.getParameter("jobTitle");
		String des = request.getParameter("description");
		String loc = request.getParameter("location");
		String email = getSetEmail.getEmail();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate date = LocalDate.now();
        String formattedDate = date.format(formatter);
		try{
			int id=0;
			Connection con = Dbconnection.connect();
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO jobs values(?, ?, ?, ?, ?, ?)");
			pstmt.setInt(1, id);
			pstmt.setString(2, email);
			pstmt.setString(3, title);
			pstmt.setString(4, des);
			pstmt.setString(5, loc);
			pstmt.setString(6, formattedDate);
			
			int i=pstmt.executeUpdate();
			
			if(i>0){
				response.sendRedirect("sucessfull.html");
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}

}
