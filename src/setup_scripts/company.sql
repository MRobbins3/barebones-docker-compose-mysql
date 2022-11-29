CREATE DATABASE IF NOT EXISTS company;

use company;

DROP TABLE IF EXISTS Projects_Employee;
DROP TABLE IF EXISTS Projects;
# Need to drop this FK constraint before it will let us drop Employee. 
# Employee and Department have cyclic FK references, so we need to drop one or the other. I chose Employee at random.
ALTER TABLE Department DROP FOREIGN KEY FK_DeptManager;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Employee (
  id_num INT PRIMARY KEY,
  emp_name VARCHAR(40),
  address varchar(80),
  birthdate DATE,
  salary INT,
  dept_id INT,
  supervisor_id INT,
  CONSTRAINT FK_EmpSupervisor FOREIGN KEY(supervisor_id) REFERENCES Employee(id_num)
);

CREATE TABLE Department (
	id INT PRIMARY KEY,
    dept_name varchar(50), 
    office_loc varchar(100),
    manager_id int,
    CONSTRAINT FK_DeptManager FOREIGN KEY(manager_id) REFERENCES Employee(id_num) ON DELETE SET NULL
);

ALTER TABLE Employee 
ADD FOREIGN KEY(dept_id) REFERENCES Department(id);

CREATE TABLE Projects (
	project_id INT PRIMARY KEY, 
    proj_name varchar(50) UNIQUE, 
    budget INT,
    dept_id INT NOT NULL,
    CONSTRAINT FK_ProjDept FOREIGN KEY(dept_id) REFERENCES Department(id)
);

CREATE TABLE Projects_Employee (
	project_id INT,
    employee_id INT,
    start_date DATE, 
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id_num)
);
