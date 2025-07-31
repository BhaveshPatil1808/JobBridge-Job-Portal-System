<!-- postedjobs.jsp -->
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Posted Jobs - Admin</title>
    <style>
        body { font-family: Arial; background: #f9f9f9; padding: 20px; }
        h2 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #007bff; color: white; }
        
        .delete-btn {
            padding: 6px 12px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background: #c82333;
        }
    </style>
</head>
<body>
    <h2>📄 All Posted Jobs</h2>
    <table>
        <tr>
            <th>Job ID</th>
            <th>Employer Email</th>
            <th>Title</th>
            <th>Description</th>
            <th>Location</th>
            <th>Date</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM jobs");
                while (rs.next()) {
                	int id= rs.getInt("id");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= rs.getString("employerEmail") %></td>
            <td><%= rs.getString("jobTitle") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("postDate") %></td>
            <td>
                <form method="post" action="deletejob">
                    <input type="hidden" name="id" value="<%= id %>" />
                    <input type="submit" value="Delete" class="delete-btn"  />
                </form>
            </td>
        </tr>
        <%      }
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>