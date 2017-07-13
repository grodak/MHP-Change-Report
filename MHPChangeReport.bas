Attribute VB_Name = "Module17"
Sub MHPChangeReport()

Dim ws As Worksheet, ws2 As Worksheet
Dim wb As Workbook
Dim lr As Long, lr2 As Long
Dim startrow As Range, endrow As Range
Dim fileName As String

Set wb = ActiveWorkbook
Set ws = wb.Sheets("ChangeReport_Master")

'======================================
'Subtotal Group the data at each change
'in ID number, sum the Per pay column.
'======================================
lr = ws.Cells(Rows.Count, 1).End(xlUp).Row
ws.Range("A1:J" & lr).Sort Key1:=ws.Range("A1"), Order1:=xlAscending, Key2:=ws.Range("E1"), Order2:=xlAscending, Header:=xlYes
ws.Range("A1:J" & lr).Subtotal GroupBy:=5, Function:=xlSum, TotalList:=9

'=======================================================
'Bold the Subtotal rows, and delete the Grand Total row.
'=======================================================
lr = ws.Cells(Rows.Count, 5).End(xlUp).Row
For i = 2 To lr
    If InStr(ws.Cells(i, 5).Value, "Total") > 0 Then
        If InStr(ws.Cells(i, 5).Value, "Grand") > 0 Then
            ws.Rows(i).EntireRow.Delete
        End If
        ws.Range("I" & i).Font.Bold = True
    End If
Next

'=========================================================
'Fill in the Subtotal row with the Div number of the Part.
'This makes finding the Div range easier later on.
'=========================================================
ws.Range("A1:A" & lr).SpecialCells(xlCellTypeBlanks).Select
Selection.FormulaR1C1 = "=R[-1]C"
ws.Range("A1:A" & lr).Copy
ws.Cells(1, 1).PasteSpecial xlPasteValues
ws.Cells(1, 1).Select

'=========================================================================================================
'Filters the Division column to get unique Div numbers. Uses that list
'to create a new tab for each division, and pastes the data to the applicable tab.
'Then prints the tab to PDF, naming it the Division Number-Division Description for sending to the client.
'=========================================================================================================
ws.Range("A1:A" & lr).AdvancedFilter Action:=xlFilterCopy, CopyToRange:=ws.Cells(1, 12), Unique:=True
For i = 2 To ws.Cells(Rows.Count, 12).End(xlUp).Row
    Set startrow = ws.Range("A1:A" & lr).Find(ws.Cells(i, 12).Value, LookIn:=xlValues, LookAt:=xlWhole, MatchCase:=False)
    Set endrow = ws.Range("A1:A" & lr).Find(ws.Cells(i, 12).Value, LookIn:=xlValues, LookAt:=xlWhole, SearchDirection:=xlPrevious, MatchCase:=False)
    wb.Sheets.Add().Name = ws.Cells(i, 12).Value
    Set ws2 = Sheets(ws.Cells(i, 12).Value)
    ws.Range("A1:J1").Copy ws2.Range("A1")
    ws.Range("A" & startrow.Row & ":J" & endrow.Row).Copy ws2.Range("A2")
    ws2.Range("I2:J" & endrow.Row).NumberFormat = "$#,##0.00"
    ws2.UsedRange.Rows.AutoFit
    ws2.UsedRange.Columns.AutoFit
    With ws2.PageSetup
        .Orientation = xlLandscape
        .Zoom = False
        .FitToPagesWide = 1
        .FitToPagesTall = 10
    End With
    'TODO: There has to be a better way to match div # to div description.
    Select Case ws.Cells(i, 12).Value
        Case "9999"
            fileName = "9999-MHPCOBRADivision"
        Case "AA01"
            fileName = "AA01-AsthmaAllergyImmun"
        Case "BC00"
            fileName = "BC00-BiotechClinicalLabs"
        Case "CL00"
            fileName = "CL00-ClarkstonMedicalGroup"
        Case "CM01"
            fileName = "CM01-AffiliatesInUrology"
        Case "CM02"
            fileName = "CM02-ComprehensiveUrology"
        Case "CM03"
            fileName = "CM03-GrossPointeUrology"
        Case "CM04"
            fileName = "CM04-DrSabryMansour"
        Case "CM05"
            fileName = "CM05-OaklandCountyUrologists"
        Case "CM06"
            fileName = "CM06-UrologyAssocPortHuron"
        Case "CM07"
            fileName = "CM07-MichiganUrologicalInst"
        Case "CM08"
            fileName = "CM08-DrArnkoff&DrWeigler"
        Case "CM09"
            fileName = "CM09-RichardMillsMD"
        Case "CV00"
            fileName = "CV00-Cardiology&Vascular"
        Case "EN00"
            fileName = "EN00-ENTSurgicalAssociates"
        Case "EP01"
            fileName = "EP01-EduardoPhillipsMD"
        Case "FH01"
            fileName = "FH01-FarmingtonHillsOBGYN"
        Case "HO00"
            fileName = "HO00-HemotologyOncology"
        Case "JO06"
            fileName = "JO06-JordySacksnerMD"
        Case "KS00"
            fileName = "KS00-KestenbergSurgical"
        Case "KW00"
            fileName = "KW00-KingswoodOBGYN"
        Case "LA01"
            fileName = "LA01-LungAllergy&Sleep"
        Case "MG01"
            fileName = "MG01-MillenniumMedGrpWest"
        Case "MG02"
            fileName = "MG02-MillenniumMedGrpWest"
        Case "MG03"
            fileName = "MG03-MillenniumMedGrpWest"
        Case "MH00"
            fileName = "MH00-MichiganHealthcareProf"
        Case "MH01"
            fileName = "MH01-MHPRadiationOncology"
        Case "MH02"
            fileName = "MH02-Hepatobiliary&GenSurg"
        Case "MH03"
            fileName = "MH03-MHPRadiology"
        Case "MH04"
            fileName = "MH04-MHPMMGCardiology"
        Case "MH07"
            fileName = "MH07-KrisWarszawskiMD"
        Case "MH08"
            fileName = "MH08-MHPMellenniumOrthopedic"
        Case "MH09"
            fileName = "MH09-MichiganThoraricInst"
        Case "MM00"
            fileName = "MM00-MMGAdministrationOffice"
        Case "MM01"
            fileName = "MM01-NorthwestInternalMed"
        Case "MM02"
            fileName = "MM02-InternalMedicinePlus"
        Case "MM04"
            fileName = "MM04-OakParkMedicalCenter"
        Case "MM05"
            fileName = "MM05-ReemAlsabtiMD"
        Case "MM07"
            fileName = "MM07-ImadMGeorgeMD"
        Case "MM09"
            fileName = "MM09-DrAthanasiusLobo"
        Case "MM10"
            fileName = "MM10-AssocRheumatologyCnslt"
        Case "MM11"
            fileName = "MM11-DrDavidBenkoff"
        Case "MM12"
            fileName = "MM12-MillenniumDiagnostic"
        Case "MM14"
            fileName = "MM14-MichiganPremierIntern"
        Case "MM19"
            fileName = "MM19-FranklinInternists"
        Case "MM20"
            fileName = "MM20-InternalMedSpecialists"
        Case "MM21"
            fileName = "MM21-InternalMedSpecialists"
        Case "MM22"
            fileName = "MM22-InternalMedSpecialists"
        Case "MM23"
            fileName = "MM23-InternalMedSpecialists"
        Case "MM28"
            fileName = "MM28-PremierInternists"
        Case "MM29"
            fileName = "MM29-MillenniumMRICenter"
        Case "MM30"
            fileName = "MM30-MillenniumCardiology"
        Case "MM32"
            fileName = "MM32-DrBrianKolender"
        Case "MM34"
            fileName = "MM34-InternalMedPhysicians"
        Case "MM36"
            fileName = "MM36-MillenniumPulmonary&SleepClinic"
        Case "MM38"
            fileName = "MM38-MillenniumUrgentCare"
        Case "MM40"
            fileName = "MM40-DrWilliamLeuchter"
        Case "MM42"
            fileName = "MM42-TheParkinsonsAndMovementDisorderClinic"
        Case "MM43"
            fileName = "MM43-TroschAndKischnerMDS"
        Case "MM46"
            fileName = "MM46-Hospitalists"
        Case "MM47"
            fileName = "MM47-DrRainaErnstoff"
        Case "MM51"
            fileName = "MM51-DrDavidWolf"
        Case "MM52"
            fileName = "MM52-WestBloomfieldIntlMed"
        Case "MM53"
            fileName = "MM53-MillenniumAffiliated"
        Case "MS01"
            fileName = "MS01-SatinderAggarwalMD"
        Case "MS02"
            fileName = "MS02-RanajitMikerjeeMD&NadarajanJanakanMD"
        Case "MS06"
            fileName = "MS06-Sadiq&ShehnazRizviMD"
        Case "MS07"
            fileName = "MS07-RamsewakRajGoswamiMD"
        Case "MS09"
            fileName = "MS09-TaylorInternalMD"
        Case "MW01"
            fileName = "MW01-MichiganWomensHlthInst"
        Case "OM00"
            fileName = "OM00-TheOaklandMedicalGroup"
        Case "OM04"
            fileName = "OM04-DivOfClinicHematology"
        Case "OM05"
            fileName = "OM05-DrMichaelLafferAndDrGaryBerg"
        Case "OM06"
            fileName = "OM06-StephenHoffmanDO&RonaldRasanskyDO"
        Case "OM07"
            fileName = "OM07-MaryCFerrisDO"
        Case "OM08"
            fileName = "OM08-ManisteeClinic"
        Case "OM09"
            fileName = "OM09-GeoffreySahamMD"
        Case "OM10"
            fileName = "OM10-SleepDisorderClinic"
        Case "OM11"
            fileName = "OM11-OaklandImaginingDiagnostic"
        Case "OM12"
            fileName = "OM12-SheldonKaftanDO"
        Case "OM13"
            fileName = "OM13-EastpointeFamilyPhys"
        Case "OM15"
            fileName = "OM15-DrSeymourWeiner"
        Case "OM18"
            fileName = "OM18-VincentJGranowiczDO"
        Case "OM20"
            fileName = "OM20-OaklandFamilyPractice"
        Case "OM21"
            fileName = "OM21-RedfordClinic"
        Case "OM22"
            fileName = "OM22-DrSheilaSimpson"
        Case "OM24"
            fileName = "OM24-TimothyGammonsDO"
        Case "OM26"
            fileName = "OM26-RyanMedicalAssociates"
        Case "OM27"
            fileName = "OM27-HamtramckMedicalCenter"
        Case "OM29"
            fileName = "OM29-RobertMoretskyDO"
        Case "OM30"
            fileName = "OM30-GreaterGeneseeMRI"
        Case "OM31"
            fileName = "OM31-MusibGappy&IyadAlosachiMD"
        Case "OM32"
            fileName = "OM32-BeWellMedicalCenter"
        Case "OM34"
            fileName = "OM34-LifetimeFamiylCare"
        Case "OM35"
            fileName = "OM35-GammonsWellness"
        Case "OM37"
            fileName = "OM37-SterlingPhysicians"
        Case "OM40"
            fileName = "OM40-HazelParkMedicalCtr"
        Case "OM42"
            fileName = "OM42-JohnRMedicalCenter"
        Case "OM43"
            fileName = "OM43-AuburnHillsMedClinic"
        Case "OM45"
            fileName = "OM45-DrDanielHoffman&DrJasperYung"
        Case "OM47"
            fileName = "OM47-RemerAndHoffmanDOs"
        Case "OM48"
            fileName = "OM48-RochesterMedicalGroup"
        Case "OM49"
            fileName = "OM49-EveryWomanOBGYN"
        Case "OM51"
            fileName = "OM51-JeffreyMargolisMD"
        Case "OM55"
            fileName = "OM55-LewerenzMedicalCenter"
        Case "OM56"
            fileName = "OM56-EmilSittoMD"
        Case "OM59"
            fileName = "OM59-SouthMacombInternists"
        Case "OM60"
            fileName = "OM60-DrSheldonWeiner"
        Case "OM61"
            fileName = "OM61-LinaSakrMD"
        Case "OM62"
            fileName = "OM62-JoelHarrisDO"
        Case "OM66"
            fileName = "OM66-OaklandNeurologistsPC"
        Case "OM67"
            fileName = "OM67-DrSamiMounayer"
        Case "OM68"
            fileName = "OM68-DrMohammadAlkahim"
        Case "OM70"
            fileName = "OM70-ErwinFeldmanDO"
        Case "OM71"
            fileName = "OM71-OaklandMacombSurgical"
        Case "PF00"
            fileName = "PF00-PreferredMedicalGroupPC"
        Case "PW00"
            fileName = "PW00-PremierWomensHealth"
        Case "RD01"
            fileName = "RD01-RichardKeidanMD"
        Case "RX01"
            fileName = "RX01-MHPPharmacyLLC"
        Case "RX02"
            fileName = "RX02-MHPPharmacyWayneLLC"
        Case "RX03"
            fileName = "RX03-MHPSpecialtyPharmacy"
        Case Else
            '=================================================
            'Traps error in case div number is not in listing.
            '=================================================
            fileName = "ERROR! DIVISION NOT IN LIST!"
            MsgBox "ERROR! Division" & ws.Cells(i, 12).Value & " not in list!"
    End Select
    
    ws2.ExportAsFixedFormat Type:=xlTypePDF, fileName:="H:\CEEM\MHP\Change Reports\" & fileName & "ChangeReport" & Format(Now - 7, "yyyymmdd") & "-" & Format(Now, "yyyymmdd"), Quality:=xlQualityStandard, IncludeDocProperties:=True, IgnorePrintAreas:=False, OpenAfterPublish:=False
Next

MsgBox "Done"
End Sub

