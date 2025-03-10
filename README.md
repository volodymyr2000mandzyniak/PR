# 🚀 Project and Task Management API

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)  
![GitHub stars](https://img.shields.io/github/stars/volodymyr2000mandzyniak/PR?style=social)

This project is an API for managing projects and tasks. It provides a convenient way to organize workflows, allowing users to create, edit, delete, and filter projects and tasks.

---

## ✨ Features

- 🔐 **User Authentication**: Sign up, sign in, and sign out.
- 📂 **CRUD for Projects**: Create, read, update, and delete projects.
- ✅ **CRUD for Tasks**: Create, read, update, and delete tasks associated with projects.
- 🔍 **Task Filtering**: Filter tasks by status.

---

## 🛠 Installationon

1. Clone the repository:
```bash
git clone https://github.com/volodymyr2000mandzyniak/PR.git
```

2. Install:
```bash
bundle install rails db:create rails db:migrate
```

3. (Optional) Seed the database with sample data
```bash
rails db:seed
```

4. Start the Rails server:
```bash
rails server
```

5. Access the API endpoints with Swagger documentation
```bash
http://localhost:3000/#
```
Or use tools like Postman or curl.



## 🌐 API Endpoints

### Authentication

- **Sign up**:  
  `POST /users/sign_up`  
  Register a new user.

- **Sign in**:  
  `POST /users/sign_in`  
  Authenticate a user and return a JWT token.

- **Sign out**:  
  `DELETE /users/sign_out`  
  Invalidate the user's JWT token (log out).

### Projects

- **Retrieve all projects**:  
  `GET /projects`  
  Get a list of all projects belonging to the authenticated user.

- **Create a new project**:  
  `POST /projects`  
  Create a new project for the authenticated user.

- **Retrieve a project by ID**:  
  `GET /projects/:id`  
  Get details of a specific project belonging to the authenticated user.

- **Update a project by ID**:  
  `PUT /projects/:id`  
  Update details of a specific project belonging to the authenticated user.

- **Delete a project by ID**:  
  `DELETE /projects/:id`  
  Delete a specific project belonging to the authenticated user.

### Tasks

- **Retrieve all tasks associated with a project**:  
  `GET /projects/:project_id/tasks`  
  Get a list of all tasks for a specific project belonging to the authenticated user.

- **Create a new task associated with a project**:  
  `POST /projects/:project_id/tasks`  
  Create a new task for a specific project belonging to the authenticated user.

- **Retrieve a task by ID associated with a project**:  
  `GET /tasks/:id`  
  Get details of a specific task belonging to the authenticated user.

- **Update a task by ID associated with a project**:  
  `PUT /tasks/:id`  
  Update details of a specific task belonging to the authenticated user.

- **Delete a task by ID associated with a project**:  
  `DELETE /tasks/:id`  
  Delete a specific task belonging to the authenticated user.

📄 License
This project is licensed under the MIT License. See the LICENSE file for details.


