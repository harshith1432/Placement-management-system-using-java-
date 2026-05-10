-- Database: placement_db

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN', 'STUDENT', 'COMPANY')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS students (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    cgpa NUMERIC(4, 2) NOT NULL,
    roll_number VARCHAR(20),
    semester INTEGER,
    skills TEXT,
    resume_url VARCHAR(255),
    profile_photo_url VARCHAR(255),
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS companies (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    company_name VARCHAR(100) NOT NULL,
    hr_name VARCHAR(100),
    description TEXT,
    website VARCHAR(255),
    logo_url VARCHAR(255),
    industry_type VARCHAR(100),
    location VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE NOT NULL,
    contact_phone VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS drives (
    id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES companies(user_id) ON DELETE CASCADE,
    job_role VARCHAR(100) NOT NULL,
    job_description TEXT,
    package_lpa NUMERIC(10, 2) NOT NULL,
    cgpa_req NUMERIC(4, 2) NOT NULL,
    branch_req VARCHAR(255) NOT NULL, -- Comma-separated or 'ALL'
    drive_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'CLOSED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS applications (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(user_id) ON DELETE CASCADE,
    drive_id INTEGER REFERENCES drives(id) ON DELETE CASCADE,
    status VARCHAR(30) DEFAULT 'APPLIED' CHECK (status IN ('APPLIED', 'SHORTLISTED', 'INTERVIEW_SCHEDULED', 'REJECTED', 'SELECTED')),
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(student_id, drive_id) -- Prevent multiple applications to the same drive
);

CREATE TABLE IF NOT EXISTS interviews (
    id SERIAL PRIMARY KEY,
    application_id INTEGER REFERENCES applications(id) ON DELETE CASCADE,
    round_name VARCHAR(100) NOT NULL,
    date_time TIMESTAMP NOT NULL,
    meeting_link VARCHAR(255),
    status VARCHAR(20) DEFAULT 'SCHEDULED' CHECK (status IN ('SCHEDULED', 'COMPLETED', 'CANCELLED')),
    notes TEXT
);

-- Default Admin User (Password is 'admin123' - you should hash passwords in production)
INSERT INTO users (username, password, role) VALUES ('admin', 'admin123', 'ADMIN') ON CONFLICT DO NOTHING;

-- New Tables for Production Features
CREATE TABLE IF NOT EXISTS departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed Departments
INSERT INTO departments (name) VALUES 
('Computer Science'), 
('Information Technology'), 
('Electronics'), 
('Mechanical'), 
('Civil') 
ON CONFLICT DO NOTHING;

-- Migration for Forgot Password System
ALTER TABLE users ADD COLUMN IF NOT EXISTS email VARCHAR(100);

CREATE TABLE IF NOT EXISTS password_reset_tokens (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    otp VARCHAR(6) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    last_sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Seed Admin details (assuming 'admin' user exists from line 63)
-- We use a subquery to get the ID of the 'admin' user
INSERT INTO admins (user_id, full_name, email) 
SELECT id, 'System Administrator', 'admin@college.edu' 
FROM users WHERE username = 'admin'
ON CONFLICT (user_id) DO NOTHING;
