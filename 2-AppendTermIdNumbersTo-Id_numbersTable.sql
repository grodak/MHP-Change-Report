INSERT INTO Id_numbers ( Id )
SELECT DISTINCT MHPPayrollReport_old.Id
FROM MHPPayrollReport_old LEFT JOIN MHPPayrollReport ON (MHPPayrollReport_old.Division = MHPPayrollReport.Division) AND (MHPPayrollReport_old.Id = MHPPayrollReport.Id) 
AND (MHPPayrollReport_old.Plan_Description = MHPPayrollReport.Plan_Description) AND (MHPPayrollReport_old.Per_Pay = MHPPayrollReport.Per_Pay)
WHERE (((MHPPayrollReport.Id) Is Null) AND ((MHPPayrollReport.Division) Is Null) AND ((MHPPayrollReport.Plan_Description) Is Null) 
AND ((MHPPayrollReport.Per_Pay) Is Null) AND ((MHPPayrollReport_old.Division)<>"9999") AND ((Exists (SELECT * FROM Id_numbers WHERE Id_numbers.Id = MHPPayrollReport_old.Id))=False));