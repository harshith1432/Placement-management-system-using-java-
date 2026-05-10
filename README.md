# 🎓 Placement Management System

A full-stack **College Placement Management System** built with Java Servlets, PostgreSQL, and Tailwind CSS. It streamlines the campus recruitment process by connecting **Students**, **Companies**, and **Administrators** through a unified platform.

---

## ✨ Features

### 👨‍🎓 Student Portal
- **Dashboard** — View application stats, upcoming interviews, and eligible drives
- **Drive Discovery** — Browse and apply to eligible placement drives (filtered by CGPA & department)
- **Interview Tracking** — See meeting links, interview schedules, and results in real-time
- **Profile Management** — Maintain academic profile, skills, resume URL, and contact info

### 🏢 Company Portal
- **Drive Management** — Create, edit, and close campus placement drives
- **Applicant Review** — View and shortlist student applications
- **Interview Scheduling** — Schedule interviews with meeting links (Zoom/Google Meet)
- **Result Recording** — Mark students as Selected, Rejected, or advance to Next Round

### 🛡️ Admin Portal
- **Overview Dashboard** — Real-time statistics on students, companies, drives, and placements
- **Live Placement Tracking** — Monitor all student applications and interview stages
- **Reports & Analytics** — Department-wise placement charts, drive history, CSV exports
- **User Management** — Add/manage students and companies

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Backend** | Java 11+, Servlets (javax.servlet), JDBC |
| **Frontend** | JSP, JSTL, Tailwind CSS, Chart.js |
| **Database** | PostgreSQL (Local or Neon Cloud) |
| **Server** | Jetty (embedded via Maven plugin) |
| **Build Tool** | Apache Maven |

---

## 📁 Project Structure

```
├── database/
│   └── schema.sql              # Full database schema
├── src/main/
│   ├── java/com/placement/
│   │   ├── dao/                # Data Access Objects (JDBC queries)
│   │   ├── filters/            # Authentication filters
│   │   ├── models/             # POJOs (User, Student, Drive, etc.)
│   │   ├── servlets/           # HTTP request handlers
│   │   └── utils/              # DB connection, helpers
│   └── webapp/
│       ├── assets/css/, js/    # Static assets
│       ├── includes/           # Shared JSP fragments (header, sidebar, modals)
│       ├── views/              # Role-specific views (student/, company/, admin/)
│       ├── WEB-INF/web.xml     # Servlet configuration
│       └── *.jsp               # Top-level pages
├── .env.example                # Environment variable template
├── pom.xml                     # Maven dependencies & plugins
└── run.ps1                     # One-click run script (Windows)
```

---

## 🚀 Getting Started

### Prerequisites

- **Java 11+** (JDK)
- **PostgreSQL** (local instance or [Neon](https://neon.tech) cloud)
- **Git**

> Maven is **auto-downloaded** by `run.ps1` — no manual installation needed.

### 1. Clone the Repository

```bash
git clone https://github.com/harshith1432/Placement-management-system-using-java-.git
cd Placement-management-system-using-java-
```

### 2. Set Up the Database

Create a PostgreSQL database and run the schema:

```bash
psql -U postgres -c "CREATE DATABASE placementjava;"
psql -U postgres -d placementjava -f database/schema.sql
```

### 3. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with your database credentials:

```env
DATABASE_URL=postgresql://postgres:YOUR_PASSWORD@127.0.0.1:5432/placementjava
```

### 4. Run the Application

```powershell
.\run.ps1
```

The app will start at **http://localhost:8081**

---

## 🗄️ Database Schema

The system uses **9 tables** with automatic schema migration on startup:

| Table | Purpose |
|-------|---------|
| `users` | Authentication & role management (ADMIN, STUDENT, COMPANY) |
| `students` | Student profiles (CGPA, department, skills, resume) |
| `companies` | Company profiles (industry, location, HR contact) |
| `drives` | Campus placement drives (role, package, eligibility) |
| `applications` | Student ↔ Drive applications with status tracking |
| `interviews` | Interview scheduling, meeting links, results & feedback |
| `departments` | Department master list |
| `notifications` | User notification system |
| `password_reset_tokens` | OTP-based password reset |

---

## 🔄 Interview Workflow

```
Company creates Drive → Students apply → Company shortlists
    → Schedule Interview (with meeting link)
        → Student joins interview
            → Company records result:
                ├── ✅ SELECTED → Placed!
                ├── ❌ REJECTED → Process ends
                └── 🔄 NEXT ROUND → New interview scheduled
```

---

## 📸 Screenshots

> _Coming soon_

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Harshith** — [@harshith1432](https://github.com/harshith1432)
