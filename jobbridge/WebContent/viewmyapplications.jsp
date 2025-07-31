<%@ page import="java.sql.*, javax.servlet.http.*, com.jobportal.getSetEmail" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Applications - JobBridge</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f5f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #007bff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #dee2e6;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .back-link {
            text-align: center;
            margin-top: 25px;
        }
        .back-link a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📂 My Job Applications</h2>
    <%
        try {
            String email = getSetEmail.getEmail();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");

            PreparedStatement ps = con.prepareStatement(
                "SELECT a.applicationDate, a.status, j.jobTitle FROM applications a " +
                "JOIN seeker s ON a.seekerId = s.id " +
                "JOIN jobs j ON a.jobId = j.id WHERE s.email = ?"
            );
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            boolean hasData = false;
    %>
    <table>
        <tr><th>Job Title</th><th>Applied On</th><th>Status</th></tr>
        <%
            while (rs.next()) {
                hasData = true;
        %>
        <tr>
            <td><%= rs.getString("jobTitle") %></td>
            <td><%= rs.getString("applicationDate") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <% } %>
    </table>
    <%
        if (!hasData) {
            out.println("<p style='text-align:center; color:#dc3545;'>You have not applied to any jobs yet.</p>");
        }
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
    %>

    <div class="back-link">
        <p><a href="seekerdashboard.html">⬅ Back to Dashboard</a></p>
    </div>
</div>
</body>
</html>
