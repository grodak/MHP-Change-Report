SELECT IIf([MHPPayrollReport.Division] Is Null,[PARTICIP.GPDIV],[MHPPayrollReport.Division]) AS Division, 
IIf([MHPPayrollReport.Effective_From] Is Null,Format([PARTICIP.GPBENEFF],"0000-00-00"),Format([MHPPayrollReport.Effective_From],"yyyy-mm-dd")) AS Effective_From, 
IIf([MHPPayrollReport.Division] Is Null,Format([PARTICIP.GPBENEND],"0000-00-00"),"") AS Effective_To, IIf([MHPPayrollReport.First_Name] Is Null,Trim([PARTICIP.GPFIRST]),[MHPPayrollReport.First_Name]) AS First_Name, 
Id_numbers.Id, IIf([MHPPayrollReport.Last_Name] Is Null,Trim([PARTICIP.GPLAST]),[MHPPayrollReport.Last_Name]) AS Last_Name, plan_xref.Plan_Description, MHPPayrollReport.Product, MHPPayrollReport.Per_Pay, MHPPayrollReport.Volumne 
INTO MHPChangeReport_master
FROM ((Id_numbers LEFT JOIN MHPPayrollReport ON Id_numbers.Id = MHPPayrollReport.Id) INNER JOIN PARTICIP ON Id_numbers.Id = PARTICIP.GPPARTIC) LEFT JOIN plan_xref ON MHPPayrollReport.Plan_Description = plan_xref.Plan
WHERE (((PARTICIP.GPGROUP)="MHP"));
