<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View All Applications - Admin</title>
<style>
/* Page and table styles */
body {
	font-family: 'Segoe UI', sans-serif;
	background: #f1f5f9;
	margin: 0;
	padding: 20px;
}
.container {
	background: white;
	padding: 30px;
	max-width: 1100px;
	margin: 0 auto;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
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
	padding: 10px;
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

/* Button styles */
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
.accept-btn {
	padding: 6px 12px;
	background: #28a745;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
.accept-btn:hover {
	background: #218838;
}
.reject-btn {
	padding: 6px 12px;
	background: #ff6b00;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
.reject-btn:hover {
	background: #e65c00;
}
</style>
</head>
<body>
	<div class="container">
		<h2>📄 All Job Applications</h2>

		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "rcpit");

				String query = "SELECT " +
						"a.id AS applicationId, " +
						"j.jobTitle, " +
						"s.name AS seekerName, " +
						"s.email, s.contact, s.skills, " +
						"a.applicationDate, a.status " +
						"FROM applications a " +
						"JOIN seeker s ON a.seekerId = s.id " +
						"JOIN jobs j ON a.jobId = j.id";

				PreparedStatement ps = con.prepareStatement(query);
				ResultSet rs = ps.executeQuery();
		%>
		<table>
			<tr>
				<th>Application ID</th>
				<th>Job Title</th>
				<th>Applicant Name</th>
				<th>Email</th>
				<th>Contact</th>
				<th>Skills</th>
				<th>Applied On</th>
				<th>Status</th>
				<th>Delete</th>
				<th>Accept</th>
				<th>Reject</th>
			</tr>
			<%
				boolean found = false;
				while (rs.next()) {
					found = true;
					int id = rs.getInt("applicationId");
			%>
			<tr>
				<td><%= id %></td>
				<td><%= rs.getString("jobTitle") %></td>
				<td><%= rs.getString("seekerName") %></td>
				<td><%= rs.getString("email") %></td>
				<td><%= rs.getString("contact") %></td>
				<td><%= rs.getString("skills") %></td>
				<td><%= rs.getString("applicationDate") %></td>
				<td><%= rs.getString("status") %></td>
				<td>
					<form method="post" action="deleteapp">
						<input type="hidden" name="id" value="<%= id %>" />
						<input type="submit" value="Delete" class="delete-btn" />
					</form>
				</td>
				<td>
					<form method="post" action="acceptapp">
						<input type="hidden" name="id" value="<%= id %>" />
						<input type="submit" value="Accept" class="accept-btn" />
					</form>
				</td>
				<td>
					<form method="post" action="rejectapp">
						<input type="hidden" name="id" value="<%= id %>" />
						<input type="submit" value="Reject" class="reject-btn" />
					</form>
				</td>
			</tr>
			<% } if (!found) { %>
			<tr>
				<td colspan="11">No applications found.</td>
			</tr>
			<% }
				con.close();
			} catch (Exception e) {
				out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
			}
		%>
		</table>
	</div>
	<div class="back-link">
        <p><a href="employerdashboard.html"> Back to Dashboard</a></p>
    </div>
</body>
</html>
