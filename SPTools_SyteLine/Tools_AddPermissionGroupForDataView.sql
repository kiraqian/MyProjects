IF OBJECT_ID('[dbo].[Tools_AddPermissionGroupForDataView]') IS NOT NULL
   DROP PROCEDURE Tools_AddPermissionGroupForDataView
GO

CREATE PROCEDURE Tools_AddPermissionGroupForDataView
(
   @DataViewName    NameType
 , @CommitOrNot     ListYesNoType = 0
)
AS
BEGIN TRAN
;WITH BGTaskNamesTable AS (
SELECT bgtd.TaskName
FROM WBDataView dv INNER JOIN BGTaskDefinitions bgtd
ON dv.ViewName + '-ReportOutput' = bgtd.TaskExecutable
WHERE dv.ViewName = @DataViewName
)

, FormNamesTable AS (
SELECT fm.[Name] FROM CSI_Forms.dbo.Variables var
INNER JOIN CSI_Forms.dbo.Forms fm ON var.FormID = fm.ID
WHERE var.[Value] IN (SELECT TaskName FROM BGTaskNamesTable)
)

, GroupNamesTable AS (
SELECT DISTINCT gn.GroupName FROM AccountAuthorizations_mst aa LEFT JOIN GroupNames gn ON aa.Id = gn.GroupId
WHERE aa.ObjectName1 IN (SELECT [Name] FROM FormNamesTable) AND gn.GroupName IN
(
 'QC Utilities'
,'MGR - Accounts Receivable'
,'MGR - Data Collection'
,'Standard Forms'
,'Accounts Payable'
,'Accounts Receivable'
,'Advanced Manufacturing'
,'Data Collection'
,'Data Collection Hide Costs'
,'Delivery Orders'
,'Delivery Orders Hide Prices'
,'ECN'
,'ECN Hide Costs'
,'EDI'
,'EDI Hide Costs'
,'Entity Forms'
,'Estimating'
,'Estimating Hide Costs'
,'Estimating Hide Prices'
,'Fixed Assets'
,'General Ledger'
,'GRN'
,'Human Resources'
,'Human Resources Hide Costs'
,'Inventory'
,'Inventory Costs Maintenance'
,'Inventory Hide Costs'
,'Order Entry'
,'Order Entry Hide Costs'
,'Order Entry Hide Prices'
,'Payroll'
,'Payroll Hide Costs'
,'Portal Admin'
,'Portal Data Admin'
,'Projects'
,'Projects Hide Costs'
,'Purchase Reqs'
,'Purchase Reqs Hide Costs'
,'Purchasing'
,'Purchasing Hide Costs'
,'RMA'
,'RMA Hide Costs'
,'Shop Floor Control'
,'Shop Floor Control Hide Costs'
,'ERP Configuration'
,'MGR - Accounts Payable'
,'Auditor'
,'MGR - General Ledger'
,'MGR - Human Resources'
,'MGR - Inventory Control'
,'MGR - Order Entry'
,'MGR - Payroll'
,'MGR - Purchasing'
,'MGR - RMA'
,'MGR - Shop Floor Control'
,'System Administration'
,'APS - Override Projected Date'
,'APS - Set Due Date < Projected'
,'Credit Field Update'
,'ECN - Approve'
,'ECN - Post'
,'ECN - Est - Insert'
,'ECN - Est - Delete'
,'ECN - Est - Update'
,'ECN - Est - ViewCosts'
,'ECN - Job - Insert'
,'ECN - Job - Delete'
,'ECN - Job - Update'
,'ECN - Job - ViewCosts'
,'ECN - Std - Insert'
,'ECN - Std - Delete'
,'ECN - Std - Update'
,'ECN - Std - ViewCosts'
,'Employee - Hourly'
,'Employee - Salaried'
,'Enter out of Date Range'
,'Item Stockroom - Remote Insert'
,'Item Maint - Rev Track'
,'Posting out of Current Period'
,'Purchase Requisitions Approval'
,'Project Entry'
,'Project Estimating'
,'Project Cost Rollup'
,'Project Labor Transaction'
,'Project Material Transaction'
,'Project Manager'
,'Project Adjustment Transaction'
,'Data Collection IDO'
,'Internal'
,'External Financial Interface'
,'Order Entry Invoicing Reprint'
,'Estimating Costs'
,'Inventory Costs'
,'Inventory Hide Prices'
,'Projects Costs'
,'Purchasing Costs'
,'Shop Floor Control Costs'
,'Mobile IT'
,'Customer Portal'
,'Mobile PS'
,'Vendor Portal'
,'Mobile Salesperson'
,'Mobile Executive'
,'Mobile Controller'
,'Item Stockroom - Upd Accts'
,'CN Loc'
,'Allow JE to Ctrl Acct'
,'Credit Card'
,'JP Loc'
,'Point Of Sale'
,'PP Ind Pack'
,'TH Loc'
,'Costing Analysis'
,'Service'
,'Service Outlook'
,'Service Sched Public Profiles'
,'Service Sched Public Filters'
,'MX Loc'
,'MultiLedgers'
,'Workbench Administration'
,'Workbench End User'
,'Molding Industry Pack'
,'Employee Self Service'
,'Employee Self Service Manager'
,'Employee Self Service Acct'
,'Automotive Industry Pack'
,'FMEA Maintenance'
,'QA Process'
,'Process Manager'
,'Process Manager - HR'
,'Order Entry Invoicing'
,'QC CAR/MRR Form/Reports'
,'QC CAR/MRR Maintenance'
,'QC CO Inspect'
,'QC CO Receipt'
,'QC COC Form/Reports'
,'QC Code Maintenance'
,'QC General/Reports'
,'QC IP Inspect'
,'QC IP Receipt'
,'QC Maintenance'
,'QC Parameter Maintenance'
,'QC Shipping'
,'QC Supplier Inspect'
,'QC Supplier Receipt'
,'QC Test Results'
,'QC VRMA Form/Reports'
,'QC VRMA Maintenance'
,'QC RMA Receipt'
,'QC Quick MRR'
,'QC Enterprise Management'
,'QC Enterprise Entry'
,'QC Enterprise Codes'
,'QC Enterprise Reports'
,'Infor-SystemAdministrator'
,'Request For Quote'
,'Finance'
,'Mobile Service'
,'DE Loc'
,'FactoryTrack'
)
)

INSERT INTO WBDataViewGroup(ViewName, GroupName)
SELECT @DataViewName, GroupName FROM GroupNamesTable
WHERE GroupName NOT IN
(SELECT GroupName FROM WBDataViewGroup WHERE ViewName = @DataViewName)

SELECT * FROM WBDataViewGroup WHERE ViewName = @DataViewName

IF @CommitOrNot = 0 ROLLBACK TRAN
ELSE COMMIT TRAN

GO
