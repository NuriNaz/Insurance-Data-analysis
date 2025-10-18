create database Insurancedb;



select * from  [dbo].[InsuranceData];


SELECT 
    SUM(PremiumAmount) AS TotalPremium,
    SUM(CoverageAmount) AS TotalCoverage,
    SUM(ClaimAmount) AS TotalClaimAmount
FROM InsuranceData;


SELECT 
    Gender,
    COUNT(*) AS TotalCustomers
FROM InsuranceData
GROUP BY Gender;

SELECT 
    PolicyType,
    SUM(PremiumAmount) AS TotalPremium
FROM InsuranceData
GROUP BY PolicyType
ORDER BY TotalPremium DESC;





SELECT 
    CASE 
        WHEN PolicyEndDate <= '2024-12-10' THEN 'Inactive'
        ELSE 'Active'
    END AS PolicyStatus,
    COUNT(*) AS TotalPolicies
FROM InsuranceData
GROUP BY 
    CASE 
        WHEN PolicyEndDate <= '2024-12-10' THEN 'Inactive'
        ELSE 'Active'
    END;



 SELECT 
    ClaimStatus,
    COUNT(*) AS NumberOfClaims
FROM InsuranceData
GROUP BY ClaimStatus;



SELECT 
    CASE
        WHEN Age <= 24 THEN 'Young Adult'
        WHEN Age <= 60 THEN 'Adult'
        ELSE 'Elder'
    END AS AgeGroup,
    SUM(ClaimAmount) AS TotalClaimAmount
FROM InsuranceData
GROUP BY 
    CASE
        WHEN Age <= 24 THEN 'Young Adult'
        WHEN Age <= 60 THEN 'Adult'
        ELSE 'Elder'
    END
ORDER BY TotalClaimAmount DESC;




SELECT 
    PolicyType,
    SUM(CASE WHEN ClaimStatus = 'Pending' THEN CoverageAmount ELSE 0 END) AS Pending,
    SUM(CASE WHEN ClaimStatus = 'Rejected' THEN CoverageAmount ELSE 0 END) AS Rejected,
    SUM(CASE WHEN ClaimStatus = 'Settled' THEN CoverageAmount ELSE 0 END) AS Settled,
    SUM(CoverageAmount) AS TotalCoverage
FROM InsuranceData
GROUP BY PolicyType;











