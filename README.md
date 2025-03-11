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

## 🛠 Technologies

- **Ruby**: `3.2.3`  
  The programming language used for the project.

- **Ruby on Rails**: `7.2.2`  
  The web framework used to build the API.

- **PostgreSQL**: `1.1`  
  The database system for storing data.

- **RSpec**: `6.1.0`  
  The testing framework for writing unit and integration tests.

- **Swagger**  
  Used for API documentation and interactive API exploration.

- **Devise**  
  Handles user authentication (sign up, sign in, sign out).

- **Rack Attack**  
  Provides throttling and blocking of malicious requests.

- **Devise JWT**  
  Enables token-based authentication for secure API access.

- **Rack CORS**  
  Manages Cross-Origin Resource Sharing (CORS) to allow secure cross-domain requests.

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



# Rails API Documentation

## Base URL

The base URL for the API is: `http://localhost:3000`

## Authentication

The API uses Devise for authentication. You need to sign up and log in to access protected endpoints.

### Endpoints

1. **User Registration**
   - **Endpoint:** `POST /signup`
   - **Description:** Register a new user.
   - **Parameters:**
     - `email` (string, required): User's email.
     - `password` (string, required): User's password.
     - `password_confirmation` (string, required): Confirmation of the user's password.
   - **Example Request (Postman):**
     ```json
     {
       "email": "user@example.com",
       "password": "password123",
       "password_confirmation": "password123"
     }
     ```

2. **User Login**
   - **Endpoint:** `POST /login`
   - **Description:** Log in an existing user.
   - **Parameters:**
     - `email` (string, required): User's email.
     - `password` (string, required): User's password.
   - **Example Request (Postman):**
     ```json
     {
       "email": "user@example.com",
       "password": "password123"
     }
     ```

3. **User Logout**
   - **Endpoint:** `DELETE /logout`
   - **Description:** Log out the current user.
   - **Headers:**
     - `Authorization`: `Bearer <your_token>`

4. **Projects**
   - **List Projects**
     - **Endpoint:** `GET /projects`
     - **Description:** Retrieve a list of projects.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

   - **Create Project**
     - **Endpoint:** `POST /projects`
     - **Description:** Create a new project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`
     - **Parameters:**
       - `name` (string, required): Name of the project.
       - `description` (text, optional): Description of the project.
     - **Example Request (Postman):**
       ```json
       {
         "name": "New Project",
         "description": "This is a new project."
       }
       ```

   - **Show Project**
     - **Endpoint:** `GET /projects/:id`
     - **Description:** Retrieve details of a specific project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

   - **Update Project**
     - **Endpoint:** `PUT /projects/:id`
     - **Description:** Update an existing project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`
     - **Parameters:**
       - `name` (string, optional): Updated name of the project.
       - `description` (text, optional): Updated description of the project.
     - **Example Request (Postman):**
       ```json
       {
         "name": "Updated Project Name",
         "description": "Updated project description."
       }
       ```

   - **Delete Project**
     - **Endpoint:** `DELETE /projects/:id`
     - **Description:** Delete a project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

5. **Tasks**
   - **List Tasks for a Project**
     - **Endpoint:** `GET /projects/:project_id/tasks`
     - **Description:** Retrieve a list of tasks for a specific project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

   - **Create Task**
     - **Endpoint:** `POST /projects/:project_id/tasks`
     - **Description:** Create a new task for a specific project.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`
     - **Parameters:**
       - `name` (string, required): Name of the task.
       - `description` (text, optional): Description of the task.
       - `status` (string, optional): Status of the task (e.g., "pending", "completed").
     - **Example Request (Postman):**
       ```json
       {
         "name": "New Task",
         "description": "This is a new task.",
         "status": "pending"
       }
       ```

   - **Show Task**
     - **Endpoint:** `GET /projects/:project_id/tasks/:id`
     - **Description:** Retrieve details of a specific task.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

   - **Update Task**
     - **Endpoint:** `PUT /projects/:project_id/tasks/:id`
     - **Description:** Update an existing task.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`
     - **Parameters:**
       - `name` (string, optional): Updated name of the task.
       - `description` (text, optional): Updated description of the task.
       - `status` (string, optional): Updated status of the task.
     - **Example Request (Postman):**
       ```json
       {
         "name": "Updated Task Name",
         "description": "Updated task description.",
         "status": "completed"
       }
       ```

   - **Delete Task**
     - **Endpoint:** `DELETE /projects/:project_id/tasks/:id`
     - **Description:** Delete a task.
     - **Headers:**
       - `Authorization`: `Bearer <your_token>`

## Testing with Postman

1. **Set Up Environment:**
   - Create a new environment in Postman and add variables for `base_url` and `token`.

2. **Authentication:**
   - Use the `/signup` and `/login` endpoints to register and log in. Save the token from the login response to the `token` variable.

3. **Testing Endpoints:**
   - For each endpoint, create a new request in Postman.
   - Set the request type (GET, POST, PUT, DELETE) and URL.
   - Add necessary headers, such as `Authorization: Bearer {{token}}`.
   - Add request body parameters if needed.
   - Send the request and verify the response.



📄 License
This project is licensed under the MIT License. See the LICENSE file for details.


