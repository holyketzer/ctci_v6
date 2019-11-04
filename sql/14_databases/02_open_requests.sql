SELECT * FROM Buildings;
SELECT * FROM Apartments;
SELECT * FROM Requests;

SELECT min(Buildings.BuildingID), min(Buildings.BuildingName), count(Requests.RequestID)
FROM Buildings
JOIN Apartments ON Apartments.BuildingID = Buildings.BuildingID
JOIN Requests ON Requests.AptID = Apartments.AptID AND Requests.Status = 'Open'
GROUP BY Buildings.BuildingID;
