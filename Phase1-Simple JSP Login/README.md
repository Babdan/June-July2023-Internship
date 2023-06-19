# SCADA Website Project

This project is a simple SCADA (Supervisory Control and Data Acquisition) website implemented using JSP (JavaServer Pages) and MySQL database. The project includes functionality for user authentication, a login page, and a home page with a placeholder for SCADA content.

## Project Structure

SCADAProject
├── WEB-INF
│ ├── classes
│ └── lib
│ └── mysql-connector-java-x.x.xx.jar
├── home.jsp
├── index.jsp
├── login.jsp
└── loginCheck.jsp

markdown
Copy code

- `WEB-INF`: This directory contains web application-specific resources.
  - `classes`: This directory is used to store compiled Java classes (if any).
  - `lib`: This directory is used to store the MySQL JDBC driver jar file (`mysql-connector-java-x.x.xx.jar`).
- `home.jsp`: The home page that displays the SCADA content (placeholder for now).
- `index.jsp`: The index page that redirects to the login page.
- `login.jsp`: The login page for user authentication.
- `loginCheck.jsp`: JSP page that validates user credentials against the MySQL database and handles the login process.

## Prerequisites

To run the SCADA website project, you need the following:

- Apache Tomcat (version x.x.x or higher)
- MySQL database
- MySQL Connector/J (JDBC driver for MySQL)

## Setup and Configuration

1. Download and install Apache Tomcat on your machine.
2. Download and install MySQL database on your machine.
3. Download the MySQL Connector/J JDBC driver from the MySQL website.
4. Copy the `mysql-connector-java-x.x.xx.jar` file to the `SCADAProject/WEB-INF/lib/` directory.
5. Create a database named `scadaproject` in your MySQL database.
6. Execute the SQL script provided earlier to create the `users` table in the `scadaproject` database and insert a test user.
7. Copy the entire `SCADAProject` directory to the Tomcat webapps directory.

## Usage

1. Start the Apache Tomcat server.
2. Open a web browser and navigate to `http://localhost:8080/SCADAProject/`.
3. You will be redirected to the login page.
4. Enter the test username and password (as per the SQL script) or create a new user in the `users` table.
5. Upon successful login, you will be redirected to the home page with the placeholder SCADA content.
6. Click on the "Logout" button in the top navbar to logout and return to the login page.

## Customization

- Modify the `home.jsp` file to include your SCADA content or replace the placeholder "Hello, World!" with the desired content.
- Customize the CSS styles in the JSP files to match your desired visual design.

## Note

- This is a basic implementation for learning purposes and does not include advanced security features.
- In a production environment, ensure to follow best practices for secure coding, such as input validation, hashing passwords, and protecting against SQL injection attacks.

Feel free to modify and enhance the project according to your requirements and specifications.
