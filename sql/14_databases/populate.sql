INSERT INTO Complexes (ComplexID, ComplexName) VALUES (1, 'Complex A');
INSERT INTO Complexes (ComplexID, ComplexName) VALUES (2, 'Complex Z');

INSERT INTO Buildings (BuildingID, ComplexID, BuildingName, Address) VALUES (1, 1, 'Building AA', 'Lenina 5');
INSERT INTO Buildings (BuildingID, ComplexID, BuildingName, Address) VALUES (2, 2, 'Building AX', 'Rose 7');
INSERT INTO Buildings (BuildingID, ComplexID, BuildingName, Address) VALUES (3, 2, 'Building Z7', 'Rose 7');

INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (1, 'A1', 1);
INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (2, 'A2', 1);
INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (3, 'C1', 2);
INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (4, 'C2', 2);
INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (5, 'E1', 3);
INSERT INTO Apartments (AptID, UnitNumber, BuildingID) VALUES (6, 'E2', 3);

INSERT INTO Tenants (TenantID, TenantName) VALUES (1, 'Ivan');
INSERT INTO Tenants (TenantID, TenantName) VALUES (2, 'John');
INSERT INTO Tenants (TenantID, TenantName) VALUES (3, 'Alex');

INSERT INTO AptTenants (TenantID, AptID) VALUES (1, 1);
INSERT INTO AptTenants (TenantID, AptID) VALUES (2, 4);
INSERT INTO AptTenants (TenantID, AptID) VALUES (3, 5);
INSERT INTO AptTenants (TenantID, AptID) VALUES (3, 6);

INSERT INTO Requests (RequestID, Status, AptID, Description) VALUES (1, 'Open', 1, 'Test');
INSERT INTO Requests (RequestID, Status, AptID, Description) VALUES (2, 'Open', 2, 'Test');
INSERT INTO Requests (RequestID, Status, AptID, Description) VALUES (3, 'Open', 3, 'Test');
