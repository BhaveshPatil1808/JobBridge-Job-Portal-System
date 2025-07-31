<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Jobs - JobBridge</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f5f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        .no-jobs {
            text-align: center;
            color: #dc3545;
            font-weight: bold;
            margin-top: 20px;
        }

        .apply-btn {
            padding: 6px 12px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .apply-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🔍 Available Job Listings</h2>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM jobs");

            boolean hasJobs = false;
    %>
    <table>
        <tr>
            <th>Job Title</th>
            <th>Description</th>
            <th>Location</th>
            <th>Posted Date</th>
            <th>Action</th>
        </tr>
        <%
            while (rs.next()) {
                hasJobs = true;
                int jobId = rs.getInt("id"); // assuming 'id' is the job's primary key
        %>
        <tr>
            <td><%= rs.getString("jobTitle") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("postDate") %></td>
            <td>
                <form method="post" action="applyjob">
                    <input type="hidden" name="jobId" value="<%= jobId %>" />
                    <input type="submit" value="Apply" class="apply-btn" />
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <%
        if (!hasJobs) {
            out.println("<div class='no-jobs'>No jobs available at the moment.</div>");
        }

        con.close();
        } catch(Exception e) {
            out.println("<div class='no-jobs'>Error: " + e.getMessage() + "</div>");
        }
    %>

    <div class="back-link">
        <p><a href="seekerdashboard.html">⬅ Back to Dashboard</a></p>
    </div>
</div>

</body>
</html>
