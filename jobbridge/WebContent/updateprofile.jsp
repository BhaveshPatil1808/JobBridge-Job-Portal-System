<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="com.jobportal.getSetEmail"%>
<%
    String skills = "";
    String contact = "";
    String email = getSetEmail.getEmail(); // Assuming you have stored user email statically

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");
        PreparedStatement ps = con.prepareStatement("SELECT skills, contact FROM seeker WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            skills = rs.getString("skills");
            contact = rs.getString("contact");
        }
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile - JobBridge</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f1f5f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: #28a745;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background: #218838;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            text-decoration: none;
            color: #007bff;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Update Your Profile</h2>
    <form method="post" action="updateprofile">
        <label for="skills">Your Skills</label>
        <input type="text" id="skills" name="skills" value="<%= skills %>" required>

        <label for="contact">Contact Number</label>
        <input type="text" id="contact" name="contact" value="<%= contact %>" required>

        <input type="submit" value="Update Profile">
    </form>

    <div class="back-link">
        <p><a href="seekerdashboard.html"> Back to Dashboard</a></p>
    </div>
</div>
</body>
</html>
