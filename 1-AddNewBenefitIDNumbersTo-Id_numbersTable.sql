SELECT DISTINCT MHPPayrollReport.Id INTO Id_numbers
FROM MHPPayrollReport LEFT JOIN MHPPayrollReport_old ON (MHPPayrollReport.Per_Pay = MHPPayrollReport_old.Per_Pay) AND (MHPPayrollReport.Plan_Description = MHPPayrollReport_old.Plan_Description) 
AND (MHPPayrollReport.Id = MHPPayrollReport_old.Id) AND (MHPPayrollReport.Division = MHPPayrollReport_old.Division)
WHERE (((MHPPayrollReport_old.Division) Is Null) AND ((MHPPayrollReport_old.Id) Is Null) AND ((MHPPayrollReport_old.Plan_Description) Is Null) AND ((MHPPayrollReport_old.Per_Pay) Is Null));