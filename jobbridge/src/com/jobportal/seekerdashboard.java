package com.jobportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

public class seekerdashboard extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public seekerdashboard() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get user email from session
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("email") : null;

        if (userEmail == null) {
            response.sendRedirect("login.html"); // Not logged in
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = Dbconnection.connect();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM seeker WHERE email=?");
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");

                out.println("<html><head><title>Seeker Dashboard</title></head><body>");
                out.println("<h1>Welcome, " + name + "!</h1>");
                out.println("<p><a href='seekerdashboard.html'>Go to Dashboard</a></p>");
                out.println("<p><a href='logout'>Logout</a></p>");
                out.println("</body></html>");
            } else {
                out.println("<h3>User not found</h3>");
            }

            con.close();
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
