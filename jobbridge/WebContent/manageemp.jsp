<!-- manage_employers.jsp -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Employers - JobBridge</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; padding: 20px; }
        h2 { color: #333; text-align: center; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #007bff; color: white; }
        form { margin: 0; }
        .delete-btn {
            background: #dc3545; color: white; border: none; padding: 8px 12px; border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn:hover { background: #c82333; }
    </style>
</head>
<body>
<h2>Manage Employers</h2>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM employer");
%>
    <table>
        <tr><th>ID</th><th>Name</th><th>Email</th><th>Action</th></tr>
        <% while(rs.next()) {
        	int id=rs.getInt("id");
        	%>
            <tr>
                <td><%= id %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td>
                    <form action="deleteemployer" method="post">
                        <input type="hidden" name="id" value="<%= id %>" />
                        <input type="submit" value="Delete" class="delete-btn" />
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
<%  
        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>
