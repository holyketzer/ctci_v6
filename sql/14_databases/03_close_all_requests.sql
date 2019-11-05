SELECT * FROM Buildings;
SELECT * FROM Apartments;
SELECT * FROM Requests;

UPDATE Requests
SET Status = 'Closed'
FROM Buildings, Apartments
WHERE Apartments.BuildingID = Buildings.BuildingID AND Buildings.BuildingID = 11
  AND Requests.AptID = Apartments.AptID AND Requests.Status = 'Open';
