<%@ page import="java.sql.*, com.jobportal.getSetEmail" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Posted Jobs - JobBridge</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 14px 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
            font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f9fbfd;
        }

        tr:hover {
            background-color: #eef4ff;
        }

        .no-data {
            text-align: center;
            color: #888;
            font-style: italic;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📋 My Posted Jobs</h2>

    <%
        try {
            String email = getSetEmail.getEmail();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM jobs WHERE employerEmail = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            boolean found = false;
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Job Title</th>
            <th>Description</th>
            <th>Location</th>
            <th>Posted On</th>
        </tr>

        <%
            while(rs.next()) {
                found = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("jobTitle") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("postDate") %></td>
        </tr>
        <% } %>
    </table>

    <% if (!found) { %>
        <p class="no-data">You haven't posted any jobs yet.</p>
    <% } %>

    <%
        con.close();
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
