# QueRank-Java — Company-Specific Quiz Platform

Lightweight company-specific quiz platform built with JSP, Servlets and MySQL (JDBC). The project is organized as a Dynamic Web Project and intended to run on Apache Tomcat (via Eclipse). It includes model classes, servlets, JSP views and SQL scripts to create schema and sample data.

## Features

- Company-specific quiz selection and delivery
- User registration and quiz submission
- Result calculation and display
- Simple JDBC-based persistence (MySQL)

## Tech stack

- Java (Servlets + JSP)
- MySQL (via JDBC)
- Apache Tomcat (run from Eclipse as a Dynamic Web Project)
- Development: Eclipse IDE (Dynamic Web Project support)

## Repository structure

- `java/model/` — domain classes: `Company.java`, `Question.java`, `User.java`
- `java/servlet/` — servlets: `CompanySelectServlet.java`, `QuizServlet.java`, `RegistrationServlet.java`, `SubmitQuizServlet.java`, `ResultServlet.java`
- `java/util/DatabaseConnection.java` — centralized DB connection helper (update with your DB credentials)
- `webapp/` — JSP pages and web resources
  - `index.jsp`, `registration.jsp`, `company-select.jsp`, `quiz.jsp`, `result.jsp`, `error.jsp`
  - `WEB-INF/web.xml` — servlet mappings and configuration
  - `WEB-INF/lib/` — add the MySQL JDBC driver jar here (`mysql-connector-java-x.x.x.jar`)
- `database/` — SQL scripts: `schema.sql` and `sample_data.sql`

## Prerequisites

- Java JDK (8/11/17 — matches your Tomcat/Eclipse setup)
- Eclipse IDE with Web Tools Platform (Dynamic Web Project support)
- Apache Tomcat (compatible with your Eclipse configuration)
- MySQL server
- MySQL JDBC driver (mysql-connector-java X.x.x)

## Quick setup

1. Create a MySQL database and load schema + sample data

   - Recommended DB name: `querank` (or choose your own and update `DatabaseConnection.java` accordingly)

   Run from a bash shell (adjust user & DB name as needed):

```bash
# Create DB and load schema
mysql -u root -p < database/schema.sql

# Load sample data (optional)
mysql -u root -p querank < database/sample_data.sql
```

2. Update database connection settings

- Open `java/util/DatabaseConnection.java` and set your MySQL URL, username and password. By default the project expects you to point at the DB you created in step 1. Common JDBC URL format:

```text
jdbc:mysql://localhost:3306/querank?useSSL=false&serverTimezone=UTC
```

3. Add MySQL JDBC driver

- Download `mysql-connector-java-8.x.x.jar` (or compatible version) and place it into `webapp/WEB-INF/lib/`.

4. Import into Eclipse

- In Eclipse: File → New → Dynamic Web Project
- Name it (e.g., `QueRank`), set the appropriate runtime (Tomcat), and Java version.
- Copy/merge the project files into the new project structure so that `java/` sources go into the project's `src` and `webapp/` contents into `WebContent` (or the structure Eclipse creates). Alternatively, use the workspace folder as the project root if you prefer.
- Ensure the compiled classes target the same Java version as the Tomcat runtime.

5. Run on Tomcat

- Right-click the project → Run As → Run on Server (choose your Tomcat)
- Open the app in a browser (usually http://localhost:8080/<context-root>/)

## Pages & Endpoints

- `index.jsp` — landing page
- `registration.jsp` — user registration
- `company-select.jsp` — pick a company and see quizzes
- `quiz.jsp` — take a quiz
- `result.jsp` — view quiz results
- Servlets under `java/servlet/` handle request processing and forwarding to JSPs; mappings are defined in `webapp/WEB-INF/web.xml`.

## Configuration notes

- If you change the database name, username or password, update `DatabaseConnection.java` accordingly.
- If you use a non-default port or host for MySQL, ensure the JDBC URL is updated (example above).
- Ensure the MySQL JDBC driver jar is present in `WEB-INF/lib` so Tomcat has access at runtime.

## Troubleshooting

- Common errors

  - ClassNotFoundException: com.mysql.cj.jdbc.Driver — the JDBC jar is not in `WEB-INF/lib`.
  - Communications link failure — MySQL not running or wrong host/port.
  - SQL syntax errors — run `database/schema.sql` manually to see full errors.

- Helpful debugging tips
  - Check Tomcat logs (Console / Logs) for stack traces.
  - Add simple println() logging in servlets while developing.
  - Use the MySQL CLI or a GUI (MySQL Workbench) to verify the database and tables exist.

## Tests / Validation

- This project is small and doesn't include automated tests. After deploying to Tomcat and preparing the DB, register a user and try a sample quiz to validate end-to-end flow.

## Security & production notes

- Do not store DB credentials in plaintext for production. Use environment variables, JNDI datasource, or a secrets manager.
- Use connection pooling (e.g., Tomcat JDBC or HikariCP) for better performance under load.

## Where to look next (developer pointers)

- `java/util/DatabaseConnection.java` — change DB credentials or switch to a connection pool
- `java/servlet/*` — request handling and business logic
- `webapp/WEB-INF/web.xml` — servlet mappings

---

If you want, I can also:

- Add a short script to import schema and sample data automatically.
- Add a short note in `DatabaseConnection.java` to read credentials from environment variables.
