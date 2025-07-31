# 💼 JobBridge – Job Portal System

**JobBridge** is a Java-based dynamic web application that connects **Job Seekers** with **Employers**. Built with JSP, Servlets, and MySQL, it allows users to register, apply for jobs, post vacancies, and manage recruitment from a centralized platform.

---

## 🛠️ Tech Stack

| Layer        | Technology Used                 |
|--------------|----------------------------------|
| Frontend     | JSP, HTML, CSS                   |
| Backend      | Java Servlets                    |
| Database     | MySQL                            |
| Server       | Apache Tomcat 7                  |
| IDE          | Eclipse / IntelliJ               |
| JDK          | Java 1.8                         |

---

## 📦 Modules

### 🔹 Job Seeker
- Register and update profile
- Apply for posted jobs
- View application status

### 🔹 Employer
- Post new jobs
- View and manage applicants
- Delete jobs

### 🔹 Admin (Optional Extension)
- Manage users and job listings

---

## 🧩 Features

✔️ Role-based access control  
✔️ One-click job application and status tracking  
✔️ Employers can manage listings and applicants  
✔️ Simple CRUD operations for jobs and profiles  
✔️ Clean and modular design

---

## 🗄️ Database Structure (MySQL)

| Table Name      | Purpose                            |
|------------------|-------------------------------------|
| `job_seekers`    | Stores user details and resumes     |
| `employers`      | Stores company login & info         |
| `jobs`           | Job listings with descriptions      |
| `applications`   | Applications linking seekers & jobs |

---

