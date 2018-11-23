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

SELECT * INTO #TMP_WBDataViewGroup FROM WBDataViewGroup WHERE ViewName = N'ABC Analysis Report'

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

DELETE FROM dbo.WBDataViewGroup WHERE ViewName = N'ABC Analysis Report'
DELETE FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report'

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataView WHERE ViewName = N'ABC Analysis Report')
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
   N'ABC Analysis Report',--ViewName
   N'L',--ReportOrientation
   1,--IsSystemRecord
   1,--DisplayReportHeader
   1,--DisplayPageHeaderFooter
   1,--RepeatHeadersNewPage
   1,--RepeatHeadersCollectionChange
   0,--InsertPageBreakGroup
   0,--ResetPageNumGroup
   1,--CanGrow
   N'ABCAnalysis' --CriteriaForm
)
ELSE
UPDATE dbo.WBDataView
SET CriteriaForm = N'ABCAnalysis'
WHERE ViewName = N'ABC Analysis Report'
AND IsSystemRecord = 1


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewIDO WHERE ViewName = N'ABC Analysis Report' AND IDOName = N'SLABCAnalysisReport' AND IDOAlias = N'SLABCAnalysisReport')
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
   N'ABC Analysis Report',--ViewName
   N'SLABCAnalysisReport',--IDOName
   NULL,--ParentIDO
   NULL,--Filter
   NULL,--ParentLinks
   NULL,--OrderBy
   N'SLABCAnalysisReport',--IDOAlias
   N'M',--LinkType
   0,--RecordCap
   N'M',--SourceType
   N'ItemABCAnalysisSp',--SourceName
   1,--IsSystemRecord
   0,--ShowInternalNotes
   0 --ShowExternalNotes
)


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'AccumValue' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'AccumValue',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'CumPer' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'CumPer',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'DomCurrencyFormat' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'DomCurrencyFormat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'DomCurrencyPlaces' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'DomCurrencyPlaces',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'DomPriceFormat' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'DomPriceFormat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'DomPricePlaces' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'DomPricePlaces',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'Item' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'Item',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'ItemPer' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'ItemPer',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'NewAbcCode' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'NewAbcCode',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'OldAbcCode' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'OldAbcCode',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'PMTCode' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'PMTCode',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'QtyCumuFormat' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'QtyCumuFormat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'QtyCumuPlaces' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'QtyCumuPlaces',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'QtyTotalFormat' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'QtyTotalFormat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'QtyTotalPlaces' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'QtyTotalPlaces',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'SortQty' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'SortQty',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'TotalCost' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'TotalCost',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report' AND PropertyName = N'UnitCost' AND IDOAlias = N'SLABCAnalysisReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'UnitCost',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),--Seq
   N'SLABCAnalysisReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)


IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 1)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   1,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sProcess',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 2)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   2,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sBackground',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 3)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   3,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sTaskID',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 4)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   4,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sAnalysisMethod',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 5)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   5,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSortBy',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 6)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   6,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSource',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 7)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   7,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sA',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 8)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   8,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sB',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 9)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   9,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sC',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 10)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   10,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sMessage',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'ABC Analysis Report' AND Seq = 11)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'ABC Analysis Report',--ViewName
   11,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSite',--Description
   0 --EndOfDay
)

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'ABC Analysis Report' AND GroupName = N'Human Resources Hide Costs')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'Human Resources Hide Costs'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'ABC Analysis Report' AND GroupName = N'Infor-SystemAdministrator')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'Infor-SystemAdministrator'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'ABC Analysis Report' AND GroupName = N'Inventory')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'ABC Analysis Report',--ViewName
   N'Inventory'--GroupName
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'ReportOutput' AND SourceType = N'V' AND SourceName = N'ABC Analysis Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'ABC Analysis Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>ReportOutput</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>true</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[b26e0492-00bd-4eae-aad5-4b5b09a94de9] dvl.DT=[2017-01-03 01:43:59.377]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLABCAnalysisReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>451</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_DomCurrencyPlaces</_ref><Key>DomCurrencyPlaces</Key><ID>DomCurrencyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>452</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_DomCurrencyPlaces</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_DomPricePlaces</_ref><Key>DomPricePlaces</Key><ID>DomPricePlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>453</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>13</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_DomPricePlaces</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_QtyCumuPlaces</_ref><Key>QtyCumuPlaces</Key><ID>QtyCumuPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>454</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_QtyCumuPlaces</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_QtyTotalPlaces</_ref><Key>QtyTotalPlaces</Key><ID>QtyTotalPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>455</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_QtyTotalPlaces</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_AccumValue</_ref><Key>AccumValue</Key><ID>AccumValue</ID><IsBound>true</IsBound><ColumnChooserCaption>Accum Value</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>112</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_AccumValue</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_CumPer</_ref><Key>CumPer</Key><ID>CumPer</ID><IsBound>true</IsBound><ColumnChooserCaption>Cum %</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>82</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Double</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_CumPer</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_ItemPer</_ref><Key>ItemPer</Key><ID>ItemPer</ID><IsBound>true</IsBound><ColumnChooserCaption>Item %</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Double</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_ItemPer</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_SortQty</_ref><Key>SortQty</Key><ID>SortQty</ID><IsBound>true</IsBound><ColumnChooserCaption>Quantity</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>86</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_SortQty</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_TotalCost</_ref><Key>TotalCost</Key><ID>TotalCost</ID><IsBound>true</IsBound><ColumnChooserCaption>Ext Value</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_TotalCost</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_UnitCost</_ref><Key>UnitCost</Key><ID>UnitCost</ID><IsBound>true</IsBound><ColumnChooserCaption>Unit Cost</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>86</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_UnitCost</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_DomCurrencyFormat</_ref><Key>DomCurrencyFormat</Key><ID>DomCurrencyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>456</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_DomCurrencyFormat</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_DomPriceFormat</_ref><Key>DomPriceFormat</Key><ID>DomPriceFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>457</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_DomPriceFormat</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>122</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_Item</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_NewAbcCode</_ref><Key>NewAbcCode</Key><ID>NewAbcCode</ID><IsBound>true</IsBound><ColumnChooserCaption>New ABC Code</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>97</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_NewAbcCode</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_OldAbcCode</_ref><Key>OldAbcCode</Key><ID>OldAbcCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Old ABC Code</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>92</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_OldAbcCode</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_PMTCode</_ref><Key>PMTCode</Key><ID>PMTCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Source</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>95</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_PMTCode</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_QtyCumuFormat</_ref><Key>QtyCumuFormat</Key><ID>QtyCumuFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>458</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_QtyCumuFormat</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLABCAnalysisReport_QtyTotalFormat</_ref><Key>QtyTotalFormat</Key><ID>QtyTotalFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>459</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLABCAnalysisReport_QtyTotalFormat</Ref></ColumnInfo></value></item></Columns><SortedColumns /><SummarySettings /><ColumnFilters /><Ref>SLABCAnalysisReport</Ref><KeyID>SLABCAnalysisReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   N'L',--ReportOrientation
   1 --DefaultView
)


INSERT INTO WBDataViewGroup SELECT * FROM #TMP_WBDataViewGroup
WHERE GroupName NOT IN (SELECT GroupName FROM WBDataViewGroup WHERE ViewName = N'ABC Analysis Report')

-- Insert/update/delete WBDataViewIDO data
DELETE WBDataViewIDO
FROM WBDataViewIDO wido
LEFT JOIN #TMP_WBDataViewIDO tido ON tido.ViewName = wido.ViewName
AND tido.IDOName = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName = N'ABC Analysis Report'
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
WHERE wido.ViewName = N'ABC Analysis Report'
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
WHERE wcol.ViewName = N'ABC Analysis Report'
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
   ROW_NUMBER() OVER(ORDER BY tcol.Seq) + (SELECT ISNULL(MAX(Seq), 0) FROM WBDataViewColumn WHERE ViewName = N'ABC Analysis Report'),
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
WHERE wlayout.SourceName = N'ABC Analysis Report'
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
WHERE wlayout.SourceName = N'ABC Analysis Report'
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
