SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*$Header: /Development Tools/DataViewSQLScriptGenerator/DataViewSQLScriptGenerator/SQLScriptGenerator/UpgradeHeader.sql 2     2/23/17 12:19a Lqian2 $*/
/*
***************************************************************
*                                                             *
*                           NOTICE                            *
*                                                             *
*   THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS             *
*   CONFIDENTIAL INFORMATION OF INFOR AND/OR ITS AFFILIATES   *
*   OR SUBSIDIARIES AND SHALL NOT BE DISCLOSED WITHOUT PRIOR  *
*   WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND       *
*   ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH  *
*   THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.            *
*   ALL OTHER RIGHTS RESERVED.                                *
*                                                             *
*   (c) COPYRIGHT 2018 INFOR.  ALL RIGHTS RESERVED.           *
*   THE WORD AND DESIGN MARKS SET FORTH HEREIN ARE            *
*   TRADEMARKS AND/OR REGISTERED TRADEMARKS OF INFOR          *
*   AND/OR ITS AFFILIATES AND SUBSIDIARIES. ALL RIGHTS        *
*   RESERVED.  ALL OTHER TRADEMARKS LISTED HEREIN ARE         *
*   THE PROPERTY OF THEIR RESPECTIVE OWNERS.                  *
*                                                             *
***************************************************************
*/

/* $Archive: /Development Tools/DataViewSQLScriptGenerator/DataViewSQLScriptGenerator/SQLScriptGenerator/UpgradeHeader.sql $ */
IF OBJECT_ID('tempdb..#TMP_WBDataViewGroup') IS NOT NULL
DROP TABLE #TMP_WBDataViewGroup

IF OBJECT_ID('tempdb..#TMP_WBDataViewIDO') IS NOT NULL
DROP TABLE #TMP_WBDataViewIDO

IF OBJECT_ID('tempdb..#TMP_WBDataViewColumn') IS NOT NULL
DROP TABLE #TMP_WBDataViewColumn

IF OBJECT_ID('tempdb..#TMP_WBDataViewLayout') IS NOT NULL
DROP TABLE #TMP_WBDataViewLayout

SELECT * INTO #TMP_WBDataViewGroup FROM WBDataViewGroup WHERE ViewName = N'Amortization Outstanding Report'

SELECT
   ViewName,
   IDOName,
   ParentIDO,
   Filter,
   ParentLinks,
   OrderBy,
   IDOAlias,
   LinkType,
   RecordCap,
   SourceType,
   SourceName,
   IsSystemRecord,
   ShowInternalNotes,
   ShowExternalNotes
INTO #TMP_WBDataViewIDO FROM WBDataViewIDO WHERE 1 = 2

SELECT
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
INTO #TMP_WBDataViewColumn FROM WBDataViewColumn WHERE 1 = 2

SELECT
   LayoutName,
   SourceType,
   SourceName,
   ScopeName,
   ScopeType,
   ComponentName,
   Layout,
   ReportOrientation,
   DefaultView
INTO #TMP_WBDataViewLayout FROM WBDataViewLayout WHERE 1 = 2

ALTER TABLE WBDataView DISABLE TRIGGER ALL
ALTER TABLE WBDataViewIDO DISABLE TRIGGER ALL
ALTER TABLE WBDataViewLayout DISABLE TRIGGER ALL
ALTER TABLE WBDataViewColumn DISABLE TRIGGER ALL
ALTER TABLE WBDataViewGroup DISABLE TRIGGER ALL
ALTER TABLE WBDataViewUser DISABLE TRIGGER ALL
ALTER TABLE WBDataViewParameter DISABLE TRIGGER ALL

DELETE FROM dbo.WBDataViewGroup WHERE ViewName = N'Amortization Outstanding Report'
DELETE FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report'

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataView WHERE ViewName = N'Amortization Outstanding Report')
INSERT INTO dbo.WBDataView (
   ViewName,
   ReportOrientation,
   IsSystemRecord,
   DisplayReportHeader,
   DisplayPageHeaderFooter,
   RepeatHeadersNewPage,
   RepeatHeadersCollectionChange,
   InsertPageBreakGroup,
   ResetPageNumGroup,
   CanGrow,
   CriteriaForm
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'L',--ReportOrientation
   1,--IsSystemRecord
   1,--DisplayReportHeader
   1,--DisplayPageHeaderFooter
   1,--RepeatHeadersNewPage
   1,--RepeatHeadersCollectionChange
   0,--InsertPageBreakGroup
   0,--ResetPageNumGroup
   1,--CanGrow
   N'AmortizationOutstandingReport' --CriteriaForm
)
ELSE
UPDATE dbo.WBDataView
SET CriteriaForm = N'AmortizationOutstandingReport'
WHERE ViewName = N'Amortization Outstanding Report'
AND IsSystemRecord = 1


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewIDO WHERE ViewName = N'Amortization Outstanding Report' AND IDOName = N'SLAmortizationOutstandingReport' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewIDO (
   ViewName,
   IDOName,
   ParentIDO,
   Filter,
   ParentLinks,
   OrderBy,
   IDOAlias,
   LinkType,
   RecordCap,
   SourceType,
   SourceName,
   IsSystemRecord,
   ShowInternalNotes,
   ShowExternalNotes
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'SLAmortizationOutstandingReport',--IDOName
   N'',--ParentIDO
   N'',--Filter
   N'',--ParentLinks
   N'',--OrderBy
   N'SLAmortizationOutstandingReport',--IDOAlias
   N'M',--LinkType
   0,--RecordCap
   N'M',--SourceType
   N'SSSFSRpt_AcmOutstandingSp',--SourceName
   1,--IsSystemRecord
   0,--ShowInternalNotes
   0 --ShowExternalNotes
)


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'AcctDescription' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'AcctDescription',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'AcmNum' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'AcmNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'AmortAcct' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'AmortAcct',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'CustName' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'CustName',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   N'sCustomerName',--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'CustNum' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'CustNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'InvNum' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'InvNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'OutstandingAmount' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'OutstandingAmount',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'PostedAmount' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'PostedAmount',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'RefLine' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'RefLine',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'RefNum' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'RefNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report' AND PropertyName = N'TotalAmount' AND IDOAlias = N'SLAmortizationOutstandingReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'TotalAmount',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),--Seq
   N'SLAmortizationOutstandingReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)


IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 1)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   1,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingCustomer',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 2)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   2,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingCustomer',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 3)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   3,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingRefNum',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 4)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   4,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingRefNum',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 5)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   5,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingInvoice',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 6)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   6,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingInvoice',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 7)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   7,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingAccount',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 8)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   8,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingAccount',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 9)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   9,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStatus',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 10)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   10,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sMessage',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 11)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   11,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSite',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Amortization Outstanding Report' AND Seq = 12)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   12,--Seq
   NULL,--PropertyName
   N'LA',--Operator
   N'sLayout',--Description
   0 --EndOfDay
)

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Amortization Outstanding Report' AND GroupName = N'Infor-SystemAdministrator')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'Infor-SystemAdministrator'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Amortization Outstanding Report' AND GroupName = N'Service')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Amortization Outstanding Report',--ViewName
   N'Service'--GroupName
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'GroupByAcct' AND SourceType = N'V' AND SourceName = N'Amortization Outstanding Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
INSERT INTO #TMP_WBDataViewLayout (
   LayoutName,
   SourceType,
   SourceName,
   ScopeName,
   ScopeType,
   ComponentName,
   Layout,
   ReportOrientation,
   DefaultView
) VALUES (
   N'GroupByAcct',--LayoutName
   N'V',--SourceType
   N'Amortization Outstanding Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>GroupByAcct</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>true</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[e28b58d7-2af3-4621-8861-dde85369ff9d] dvl.DT=[2018-07-04 01:47:56.610]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAmortizationOutstandingReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>501</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AcctDescription</_ref><Key>AcctDescription</Key><ID>AcctDescription</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>250</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AcctDescription</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AcmNum</_ref><Key>AcmNum</Key><ID>AcmNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Amortization</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>147</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AcmNum</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AmortAcct</_ref><Key>AmortAcct</Key><ID>AmortAcct</ID><IsBound>true</IsBound><ColumnChooserCaption>Account</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AmortAcct</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer Name</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>183</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_CustName</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_InvNum</_ref><Key>InvNum</Key><ID>InvNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Invoice</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>162</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_InvNum</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_OutstandingAmount</_ref><Key>OutstandingAmount</Key><ID>OutstandingAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Amortization Outstanding</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>244</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_OutstandingAmount</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_PostedAmount</_ref><Key>PostedAmount</Key><ID>PostedAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Posted</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>165</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_PostedAmount</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RefLine</_ref><Key>RefLine</Key><ID>RefLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Ref Line</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>82</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RefLine</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RefNum</_ref><Key>RefNum</Key><ID>RefNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Ref Num</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>111</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RefNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_TotalAmount</_ref><Key>TotalAmount</Key><ID>TotalAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Total Amount</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>213</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_TotalAmount</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAmortizationOutstandingReport_AmortAcct</Ref><Key>AmortAcct</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings><item><key><int>0</int></key><value><SummarySettingInfo><DisplayFormat>Sum = {0:N}</DisplayFormat><SummaryType>1</SummaryType><Formula /><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAmortizationOutstandingReport_TotalAmount</_ref><Key>TotalAmount</Key><ID>TotalAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Total Amount</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>213</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_TotalAmount</Ref></Col><Ref>SLAmortizationOutstandingReport_TotalAmount</Ref><Key>TotalAmount</Key></SourceCol><Ref>0</Ref><Key>0</Key></SummarySettingInfo></value></item><item><key><int>1</int></key><value><SummarySettingInfo><DisplayFormat>Sum = {0:N}</DisplayFormat><SummaryType>1</SummaryType><Formula /><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAmortizationOutstandingReport_PostedAmount</_ref><Key>PostedAmount</Key><ID>PostedAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Posted</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>165</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_PostedAmount</Ref></Col><Ref>SLAmortizationOutstandingReport_PostedAmount</Ref><Key>PostedAmount</Key></SourceCol><Ref>1</Ref><Key>1</Key></SummarySettingInfo></value></item><item><key><int>2</int></key><value><SummarySettingInfo><DisplayFormat>Sum = {0:N}</DisplayFormat><SummaryType>1</SummaryType><Formula /><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAmortizationOutstandingReport_OutstandingAmount</_ref><Key>OutstandingAmount</Key><ID>OutstandingAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Amortization Outstanding</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>244</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_OutstandingAmount</Ref></Col><Ref>SLAmortizationOutstandingReport_OutstandingAmount</Ref><Key>OutstandingAmount</Key></SourceCol><Ref>2</Ref><Key>2</Key></SummarySettingInfo></value></item></SummarySettings><ColumnFilters /><Ref>SLAmortizationOutstandingReport</Ref><KeyID>SLAmortizationOutstandingReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   N'L',--ReportOrientation
   1 --DefaultView
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'ReportOutput' AND SourceType = N'V' AND SourceName = N'Amortization Outstanding Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
INSERT INTO #TMP_WBDataViewLayout (
   LayoutName,
   SourceType,
   SourceName,
   ScopeName,
   ScopeType,
   ComponentName,
   Layout,
   ReportOrientation,
   DefaultView
) VALUES (
   N'ReportOutput',--LayoutName
   N'V',--SourceType
   N'Amortization Outstanding Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>ReportOutput</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>true</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[c217d3a8-7950-448e-8fc0-f522c4ecdd6f] dvl.DT=[2017-09-14 02:24:20.567]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAmortizationOutstandingReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>501</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AcctDescription</_ref><Key>AcctDescription</Key><ID>AcctDescription</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>250</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AcctDescription</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AcmNum</_ref><Key>AcmNum</Key><ID>AcmNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Amortization</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>147</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AcmNum</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_AmortAcct</_ref><Key>AmortAcct</Key><ID>AmortAcct</ID><IsBound>true</IsBound><ColumnChooserCaption>Account</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_AmortAcct</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer Name</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>183</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_CustName</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>132</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_InvNum</_ref><Key>InvNum</Key><ID>InvNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Invoice</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>162</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_InvNum</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_OutstandingAmount</_ref><Key>OutstandingAmount</Key><ID>OutstandingAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Amortization Outstanding</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>244</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_OutstandingAmount</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_PostedAmount</_ref><Key>PostedAmount</Key><ID>PostedAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Posted</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>145</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_PostedAmount</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RefLine</_ref><Key>RefLine</Key><ID>RefLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Ref Line</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>151</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RefLine</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_RefNum</_ref><Key>RefNum</Key><ID>RefNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Ref Num</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>151</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_RefNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAmortizationOutstandingReport_TotalAmount</_ref><Key>TotalAmount</Key><ID>TotalAmount</ID><IsBound>true</IsBound><ColumnChooserCaption>Total Amount</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>178</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAmortizationOutstandingReport_TotalAmount</Ref></ColumnInfo></value></item></Columns><SortedColumns /><SummarySettings /><ColumnFilters /><Ref>SLAmortizationOutstandingReport</Ref><KeyID>SLAmortizationOutstandingReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   N'L',--ReportOrientation
   1 --DefaultView
)


INSERT INTO WBDataViewGroup SELECT * FROM #TMP_WBDataViewGroup
WHERE GroupName NOT IN (SELECT GroupName FROM WBDataViewGroup WHERE ViewName = N'Amortization Outstanding Report')

-- Insert/update/delete WBDataViewIDO data
DELETE WBDataViewIDO
FROM WBDataViewIDO wido
LEFT JOIN #TMP_WBDataViewIDO tido ON tido.ViewName = wido.ViewName
AND tido.IDOName = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName = N'Amortization Outstanding Report'
AND wido.IsSystemRecord = 1
AND tido.ViewName IS NULL

UPDATE WBDataViewIDO
SET
   ParentIDO = tido.ParentIDO,
   Filter = tido.Filter,
   ParentLinks = tido.ParentLinks,
   OrderBy = tido.OrderBy,
   LinkType = tido.LinkType,
   RecordCap = tido.RecordCap,
   SourceType = tido.SourceType,
   SourceName = tido.SourceName,
   IsSystemRecord = tido.IsSystemRecord,
   ShowInternalNotes = tido.ShowInternalNotes,
   ShowExternalNotes = tido.ShowExternalNotes
FROM WBDataViewIDO wido
INNER JOIN  #TMP_WBDataViewIDO tido
ON  tido.ViewName = wido.ViewName
AND tido.IDOName  = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName = N'Amortization Outstanding Report'
AND wido.IsSystemRecord = 1

INSERT INTO WBDataViewIDO(
   ViewName,
   IDOName,
   ParentIDO,
   Filter,
   ParentLinks,
   OrderBy,
   IDOAlias,
   LinkType,
   RecordCap,
   SourceType,
   SourceName,
   IsSystemRecord,
   ShowInternalNotes,
   ShowExternalNotes
)
SELECT tido.* FROM #TMP_WBDataViewIDO tido
LEFT JOIN WBDataViewIDO wido ON tido.ViewName = wido.ViewName
AND tido.IDOName = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName IS NULL

-- Insert/delete WBDataViewColumn data
DELETE WBDataViewColumn
FROM WBDataViewColumn wcol
LEFT JOIN #TMP_WBDataViewColumn tcol ON tcol.ViewName = wcol.ViewName
AND tcol.PropertyName = wcol.PropertyName
AND tcol.IDOAlias = wcol.IDOAlias
WHERE wcol.ViewName = N'Amortization Outstanding Report'
AND wcol.IsSystemRecord = 1
AND tcol.ViewName IS NULL

INSERT INTO WBDataViewColumn(
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
)
SELECT
   tcol.ViewName,
   tcol.PropertyName,
   ROW_NUMBER() OVER(ORDER BY tcol.Seq) + (SELECT ISNULL(MAX(Seq), 0) FROM WBDataViewColumn WHERE ViewName = N'Amortization Outstanding Report'),
   tcol.IDOAlias,
   tcol.ColumnHeaderOverride,
   tcol.IsSystemRecord
FROM #TMP_WBDataViewColumn tcol
LEFT JOIN WBDataViewColumn wcol ON tcol.ViewName = wcol.ViewName
AND tcol.PropertyName = wcol.PropertyName
AND tcol.IDOAlias = wcol.IDOAlias
WHERE wcol.ViewName IS NULL

-- Insert/update/delete WBDataViewLayout data
DELETE WBDataViewLayout
FROM WBDataViewLayout wlayout
LEFT JOIN #TMP_WBDataViewLayout tlayout ON tlayout.LayoutName = wlayout.LayoutName
AND tlayout.SourceName = wlayout.SourceName AND wlayout.SourceType = N'V'
WHERE wlayout.SourceName = N'Amortization Outstanding Report'
AND wlayout.ScopeType = 0
AND tlayout.SourceName IS NULL

UPDATE WBDataViewLayout
SET
   SourceType = tlayout.SourceType,
   ScopeName = tlayout.ScopeName,
   ComponentName = tlayout.ComponentName,
   Layout = tlayout.Layout,
   ReportOrientation = tlayout.ReportOrientation,
   DefaultView = tlayout.DefaultView
FROM WBDataViewLayout wlayout
INNER JOIN #TMP_WBDataViewLayout tlayout ON tlayout.LayoutName = wlayout.LayoutName
AND tlayout.SourceName = wlayout.SourceName AND wlayout.SourceType = N'V'
WHERE wlayout.SourceName = N'Amortization Outstanding Report'
AND wlayout.ScopeType = 0

INSERT INTO WBDataViewLayout(
   LayoutName,
   SourceType,
   SourceName,
   ScopeName,
   ScopeType,
   ComponentName,
   Layout,
   ReportOrientation,
   DefaultView
)
SELECT tlayout.* FROM #TMP_WBDataViewLayout tlayout
LEFT JOIN WBDataViewLayout wlayout ON tlayout.LayoutName = wlayout.LayoutName
AND tlayout.SourceName = wlayout.SourceName AND wlayout.SourceType = N'V'
WHERE wlayout.SourceName IS NULL

DROP TABLE #TMP_WBDataViewGroup
DROP TABLE #TMP_WBDataViewIDO
DROP TABLE #TMP_WBDataViewColumn
DROP TABLE #TMP_WBDataViewLayout

ALTER TABLE WBDataView ENABLE TRIGGER ALL
ALTER TABLE WBDataViewIDO ENABLE TRIGGER ALL
ALTER TABLE WBDataViewLayout ENABLE TRIGGER ALL
ALTER TABLE WBDataViewColumn ENABLE TRIGGER ALL
ALTER TABLE WBDataViewGroup ENABLE TRIGGER ALL
ALTER TABLE WBDataViewUser ENABLE TRIGGER ALL
ALTER TABLE WBDataViewParameter ENABLE TRIGGER ALL

GO
