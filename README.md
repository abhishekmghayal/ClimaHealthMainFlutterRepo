# 🌿 ClimaHealth

### Smart Healthcare & Health Assistance Platform

ClimaHealth is a Flutter-based healthcare application developed to provide users with a simple and centralized platform for managing personal health information and accessing healthcare-related features.

The project is currently in its **Initial Development Phase**, where the primary focus is building a strong application foundation, secure authentication, user management, and backend integration.

---

## 🚀 Initial Phase

The first phase of ClimaHealth focuses on establishing the core architecture of the application.

### 🎯 Objectives

- Build the Flutter mobile application
- Develop the Node.js backend
- Integrate MongoDB
- Implement secure user authentication
- Connect Flutter with REST APIs
- Implement user profile management
- Establish a scalable project structure for future healthcare and AI features

---

# ✨ Features Implemented

### 🔐 Authentication

- User Registration
- User Login
- JWT-based Authentication
- Persistent Login
- Logout
- Protected API Routes
- Password Hashing using bcrypt
- Login Validation
- Registration Validation

### 👤 User Profile

- Fetch User Profile
- Update User Profile
- Change Password
- Blood Group
- Height
- Date of Birth
- Mobile Number
- Email Management

### 📱 Flutter Application

- Splash Screen
- Start Screen
- Login Screen
- Registration Screen
- Home Screen
- Account/Profile Screen
- Edit Profile Screen
- API Service Layer
- Persistent Authentication

---

# 🏗️ Initial Architecture

```text
                    CLIMAHEALTH
                         │
                         ▼
                ┌─────────────────┐
                │  Flutter App    │
                │                 │
                │ Login            │
                │ Register         │
                │ Home             │
                │ Profile          │
                └────────┬────────┘
                         │
                    REST API
                         │
                         ▼
                ┌─────────────────┐
                │  Node.js        │
                │  Express.js     │
                │                 │
                │ Authentication  │
                │ User APIs       │
                └────────┬────────┘
                         │
                      Mongoose
                         │
                         ▼
                ┌─────────────────┐
                │    MongoDB      │
                │                 │
                │     Users       │
                └─────────────────┘
