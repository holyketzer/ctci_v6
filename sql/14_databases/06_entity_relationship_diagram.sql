CREATE TABLE IF NOT EXISTS Persons (
  id int PRIMARY KEY,
  first_name varchar(100),
  last_name varchar(100)
);

CREATE TABLE IF NOT EXISTS Companies (
  id int PRIMARY KEY,
  name varchar(100)
);

CREATE TABLE IF NOT EXISTS CompanyPersons (
  person_id int,
  company_id int,
  position varchar(100)
);

CREATE UNIQUE INDEX CompanyPersonsPersonIdAndCompanyId ON CompanyPersons (person_id, company_id);
