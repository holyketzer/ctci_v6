SELECT * FROM Tenants;
SELECT * FROM AptTenants;

SELECT min(Tenants.TenantName), COUNT(AptTenants.AptID)
FROM Tenants
JOIN AptTenants
ON AptTenants.TenantID = Tenants.TenantID
GROUP BY Tenants.TenantID
HAVING COUNT(AptTenants.AptID) > 1;
