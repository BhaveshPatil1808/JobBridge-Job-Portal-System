<%@ page import="java.sql.*, com.jobportal.getSetEmail" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post a New Job - JobBridge</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .job-form-container {
            background: #fff;
            padding: 40px 35px;
            width: 400px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 12px;
            margin-top: 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="job-form-container">
    <h2>📌 Post New Job</h2>
    <form method="post" action="postjob">
        <label for="jobTitle">Job Title</label>
        <input type="text" name="jobTitle" id="jobTitle" required>

        <label for="description">Description</label>
        <textarea name="description" id="description" rows="4" required></textarea>

        <label for="location">Location</label>
        <input type="text" name="location" id="location" required>

        <input type="submit" value="Post Job">
    </form>
</div>

</body>
</html>
