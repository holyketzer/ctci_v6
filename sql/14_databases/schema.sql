CREATE TABLE IF NOT EXISTS Apartments (
  AptID int PRIMARY KEY,
  UnitNumber varchar(10),
  BuildingID int
);

CREATE TABLE IF NOT EXISTS Buildings (
  BuildingID int PRIMARY KEY,
  ComplexID int,
  BuildingName varchar(100),
  Address varchar(100)
);

CREATE TABLE IF NOT EXISTS Requests (
  RequestID int PRIMARY KEY,
  Status varchar(100),
  AptID int,
  Description varchar(500)
);

CREATE TABLE IF NOT EXISTS Complexes (
  ComplexID int PRIMARY KEY,
  ComplexName varchar(100)
);

CREATE TABLE IF NOT EXISTS AptTenants (
  TenantID int,
  AptID int
);

CREATE UNIQUE INDEX TenantIDAptID ON AptTenants (TenantID, AptID);

CREATE TABLE IF NOT EXISTS Tenants (
  TenantID int PRIMARY KEY,
  TenantName varchar(100)
);
