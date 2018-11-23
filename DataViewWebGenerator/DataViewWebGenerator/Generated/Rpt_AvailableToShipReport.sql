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

SELECT * INTO #TMP_WBDataViewGroup FROM WBDataViewGroup WHERE ViewName = N'Available To Ship Report'

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

DELETE FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report'
DELETE FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report'

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataView WHERE ViewName = N'Available To Ship Report')
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
   N'Available To Ship Report',--ViewName
   N'L',--ReportOrientation
   1,--IsSystemRecord
   1,--DisplayReportHeader
   1,--DisplayPageHeaderFooter
   1,--RepeatHeadersNewPage
   1,--RepeatHeadersCollectionChange
   0,--InsertPageBreakGroup
   0,--ResetPageNumGroup
   1,--CanGrow
   N'AvailableToShipReport' --CriteriaForm
)
ELSE
UPDATE dbo.WBDataView
SET CriteriaForm = N'AvailableToShipReport'
WHERE ViewName = N'Available To Ship Report'
AND IsSystemRecord = 1


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewIDO WHERE ViewName = N'Available To Ship Report' AND IDOName = N'SLAvailableToShipReport' AND IDOAlias = N'SLAvailableToShipReport')
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
   N'Available To Ship Report',--ViewName
   N'SLAvailableToShipReport',--IDOName
   N'',--ParentIDO
   N'',--Filter
   N'',--ParentLinks
   N'',--OrderBy
   N'SLAvailableToShipReport',--IDOAlias
   N'M',--LinkType
   0,--RecordCap
   N'M',--SourceType
   N'Rpt_AvailableToShipSp',--SourceName
   1,--IsSystemRecord
   0,--ShowInternalNotes
   0 --ShowExternalNotes
)


IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'AmtNetPrice' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'AmtNetPrice',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'BatchErr' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'BatchErr',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   N'sBatchErrorMessage',--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CoitemDisc' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CoitemDisc',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CoLine' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CoLine',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CoNum' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CoNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CoRelease' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CoRelease',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CurrCode' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CurrCode',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CurrDesc' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CurrDesc',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CustName' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CustName',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'CustNum' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'CustNum',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'Disc' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Disc',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'DueDate' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'DueDate',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'ErrMsg' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'ErrMsg',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'Item' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Item',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'ItemDesc' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'ItemDesc',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'ItemStat' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'ItemStat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'ItemUM' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'ItemUM',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'Level' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Level',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'NetQtyAvl' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'NetQtyAvl',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'OrderDate' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'OrderDate',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'PriceConv' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'PriceConv',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'QtyInvoiced' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'QtyInvoiced',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'QtyOrderedConv' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'QtyOrderedConv',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'QtyReady' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'QtyReady',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'QtyRemaining' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'QtyRemaining',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'QtyShipped' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'QtyShipped',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'RptSeq' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'RptSeq',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'Seq' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Seq',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'UnitQtyFormat' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'UnitQtyFormat',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'UnitQtyPlaces' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'UnitQtyPlaces',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report' AND PropertyName = N'Whse' AND IDOAlias = N'SLAvailableToShipReport')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Whse',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),--Seq
   N'SLAvailableToShipReport',--IDOAlias
   NULL,--ColumnHeaderOverride
   1 --IsSystemRecord
)


IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 1)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   1,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sCoType',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 2)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   2,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sCoStat',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 3)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   3,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sBatchID',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 4)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   4,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sOverwriteBatch',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 5)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   5,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sCoitemStat',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 6)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   6,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSortBy',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 7)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   7,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingCoNum',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 8)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   8,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingCoNum',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 9)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   9,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingCustomer',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 10)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   10,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingCustomer',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 11)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   11,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingItem',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 12)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   12,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingItem',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 13)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   13,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sStartingWarehouse',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 14)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   14,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sEndingWarehouse',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 15)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   15,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sPrintPrice',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 16)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   16,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sDisplayHeader',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 17)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   17,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sBGSessionID',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 18)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   18,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sTaskID',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 19)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   19,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sIncludeShipEarly',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 20)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   20,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sCutoffDate',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 21)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   21,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sSite',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 22)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   22,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sUser',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 23)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   23,--Seq
   NULL,--PropertyName
   N'LA',--Operator
   N'sLayout',--Description
   0 --EndOfDay
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'Available To Ship Report' AND Seq = 24)
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'Available To Ship Report',--ViewName
   24,--Seq
   NULL,--PropertyName
   N'MP',--Operator
   N'sIncludeShipHold',--Description
   0 --EndOfDay
)

IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report' AND GroupName = N'Infor-SystemAdministrator')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Infor-SystemAdministrator'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report' AND GroupName = N'Inventory Hide Costs')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Inventory Hide Costs'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report' AND GroupName = N'Order Entry')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Order Entry'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report' AND GroupName = N'Order Entry Hide Costs')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Order Entry Hide Costs'--GroupName
)
IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'Available To Ship Report' AND GroupName = N'Order Entry Hide Prices')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'Available To Ship Report',--ViewName
   N'Order Entry Hide Prices'--GroupName
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'SortByOrder' AND SourceType = N'V' AND SourceName = N'Available To Ship Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'SortByOrder',--LayoutName
   N'V',--SourceType
   N'Available To Ship Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>SortByOrder</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>false</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[8c078336-761a-4843-a93c-45cdf1ac3bd2] dvl.DT=[2018-06-07 06:15:37.170]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAvailableToShipReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>601</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_BatchErr</_ref><Key>BatchErr</Key><ID>BatchErr</ID><IsBound>true</IsBound><ColumnChooserCaption>Batch Error Message</ColumnChooserCaption><VisiblePosition>600</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_BatchErr</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoitemDisc</_ref><Key>CoitemDisc</Key><ID>CoitemDisc</ID><IsBound>true</IsBound><ColumnChooserCaption>Discount</ColumnChooserCaption><VisiblePosition>602</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>23</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoitemDisc</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoLine</_ref><Key>CoLine</Key><ID>CoLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Line</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoLine</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoNum</_ref><Key>CoNum</Key><ID>CoNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Order</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>100</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoRelease</_ref><Key>CoRelease</Key><ID>CoRelease</ID><IsBound>true</IsBound><ColumnChooserCaption>Release</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>105</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoRelease</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrCode</_ref><Key>CurrCode</Key><ID>CurrCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Currency</ColumnChooserCaption><VisiblePosition>603</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>28</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrCode</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrDesc</_ref><Key>CurrDesc</Key><ID>CurrDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>604</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>29</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrDesc</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>262</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustName</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>605</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Disc</_ref><Key>Disc</Key><ID>Disc</ID><IsBound>true</IsBound><ColumnChooserCaption>Order Disc</ColumnChooserCaption><VisiblePosition>606</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>19</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Disc</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_DueDate</_ref><Key>DueDate</Key><ID>DueDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Due Date</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_DueDate</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ErrMsg</_ref><Key>ErrMsg</Key><ID>ErrMsg</ID><IsBound>true</IsBound><ColumnChooserCaption>Error Message</ColumnChooserCaption><VisiblePosition>550</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ErrMsg</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Item</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemDesc</_ref><Key>ItemDesc</Key><ID>ItemDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Item Description</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>207</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemDesc</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemStat</_ref><Key>ItemStat</Key><ID>ItemStat</ID><IsBound>true</IsBound><ColumnChooserCaption>Material Status</ColumnChooserCaption><VisiblePosition>607</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>24</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemStat</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemUM</_ref><Key>ItemUM</Key><ID>ItemUM</ID><IsBound>true</IsBound><ColumnChooserCaption>U/M</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemUM</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Level</_ref><Key>Level</Key><ID>Level</ID><IsBound>true</IsBound><ColumnChooserCaption>With Errors</ColumnChooserCaption><VisiblePosition>608</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Boolean</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Level</Ref></ColumnInfo></value></item><item><key><int>19</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_NetQtyAvl</_ref><Key>NetQtyAvl</Key><ID>NetQtyAvl</ID><IsBound>true</IsBound><ColumnChooserCaption>Qty To Ship</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>140</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_NetQtyAvl</Ref></ColumnInfo></value></item><item><key><int>20</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_OrderDate</_ref><Key>OrderDate</Key><ID>OrderDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Date</ColumnChooserCaption><VisiblePosition>609</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_OrderDate</Ref></ColumnInfo></value></item><item><key><int>21</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_PriceConv</_ref><Key>PriceConv</Key><ID>PriceConv</ID><IsBound>true</IsBound><ColumnChooserCaption>PriceConv</ColumnChooserCaption><VisiblePosition>610</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>22</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_PriceConv</Ref></ColumnInfo></value></item><item><key><int>22</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyInvoiced</_ref><Key>QtyInvoiced</Key><ID>QtyInvoiced</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyInvoiced</ColumnChooserCaption><VisiblePosition>611</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>21</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyInvoiced</Ref></ColumnInfo></value></item><item><key><int>23</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyOrderedConv</_ref><Key>QtyOrderedConv</Key><ID>QtyOrderedConv</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyOrderedConv</ColumnChooserCaption><VisiblePosition>612</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>20</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyOrderedConv</Ref></ColumnInfo></value></item><item><key><int>24</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyReady</_ref><Key>QtyReady</Key><ID>QtyReady</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyReady</ColumnChooserCaption><VisiblePosition>613</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>27</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyReady</Ref></ColumnInfo></value></item><item><key><int>25</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyRemaining</_ref><Key>QtyRemaining</Key><ID>QtyRemaining</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyRemaining</ColumnChooserCaption><VisiblePosition>614</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>26</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyRemaining</Ref></ColumnInfo></value></item><item><key><int>26</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyShipped</_ref><Key>QtyShipped</Key><ID>QtyShipped</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyShipped</ColumnChooserCaption><VisiblePosition>615</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>25</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyShipped</Ref></ColumnInfo></value></item><item><key><int>27</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RptSeq</_ref><Key>RptSeq</Key><ID>RptSeq</ID><IsBound>true</IsBound><ColumnChooserCaption>RptSeq</ColumnChooserCaption><VisiblePosition>616</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RptSeq</Ref></ColumnInfo></value></item><item><key><int>28</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Seq</_ref><Key>Seq</Key><ID>Seq</ID><IsBound>true</IsBound><ColumnChooserCaption>Seq</ColumnChooserCaption><VisiblePosition>617</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Seq</Ref></ColumnInfo></value></item><item><key><int>29</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyFormat</_ref><Key>UnitQtyFormat</Key><ID>UnitQtyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>618</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>31</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyFormat</Ref></ColumnInfo></value></item><item><key><int>30</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyPlaces</_ref><Key>UnitQtyPlaces</Key><ID>UnitQtyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>619</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>30</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyPlaces</Ref></ColumnInfo></value></item><item><key><int>31</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Whse</_ref><Key>Whse</Key><ID>Whse</ID><IsBound>true</IsBound><ColumnChooserCaption>Warehouse</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Whse</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Whse</Ref><Key>Whse</Key></SortedColumnInfo></value></item><item><key><int>1</int></key><value><SortedColumnInfo><RelativeIndex>1</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Level</Ref><Key>Level</Key></SortedColumnInfo></value></item><item><key><int>2</int></key><value><SortedColumnInfo><RelativeIndex>2</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_CoNum</Ref><Key>CoNum</Key></SortedColumnInfo></value></item><item><key><int>3</int></key><value><SortedColumnInfo><RelativeIndex>3</RelativeIndex><Bound>false</Bound><SortIndicator>1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings><item><key><int>0</int></key><value><SummarySettingInfo><DisplayFormat>TotalNetPrice = {0:N}</DisplayFormat><SummaryType>5</SummaryType><Formula>SUM( IF( [ErrMsg(0)]="", [AmtNetPrice(0)] ,0) ) </Formula><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></Col><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SourceCol><Ref>0</Ref><Key>SLAvailableToShipReport:TotalNetPrice</Key></SummarySettingInfo></value></item></SummarySettings><ColumnFilters /><Ref>SLAvailableToShipReport</Ref><KeyID>SLAvailableToShipReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   NULL,--ReportOrientation
   1 --DefaultView
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'SortByAmount' AND SourceType = N'V' AND SourceName = N'Available To Ship Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'SortByAmount',--LayoutName
   N'V',--SourceType
   N'Available To Ship Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>SortByAmount</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>false</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[0a02f852-c44c-4f4e-ac0f-2f0cde49cfa8] dvl.DT=[2018-06-07 04:03:09.780]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAvailableToShipReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>601</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_BatchErr</_ref><Key>BatchErr</Key><ID>BatchErr</ID><IsBound>true</IsBound><ColumnChooserCaption>Batch Error Message</ColumnChooserCaption><VisiblePosition>600</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_BatchErr</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoitemDisc</_ref><Key>CoitemDisc</Key><ID>CoitemDisc</ID><IsBound>true</IsBound><ColumnChooserCaption>Discount</ColumnChooserCaption><VisiblePosition>602</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>23</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoitemDisc</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoLine</_ref><Key>CoLine</Key><ID>CoLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Line</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoLine</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoNum</_ref><Key>CoNum</Key><ID>CoNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Order</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>100</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoRelease</_ref><Key>CoRelease</Key><ID>CoRelease</ID><IsBound>true</IsBound><ColumnChooserCaption>Release</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>105</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoRelease</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrCode</_ref><Key>CurrCode</Key><ID>CurrCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Currency</ColumnChooserCaption><VisiblePosition>603</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>28</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrCode</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrDesc</_ref><Key>CurrDesc</Key><ID>CurrDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>604</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>29</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrDesc</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>262</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustName</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>605</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Disc</_ref><Key>Disc</Key><ID>Disc</ID><IsBound>true</IsBound><ColumnChooserCaption>Order Disc</ColumnChooserCaption><VisiblePosition>606</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>19</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Disc</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_DueDate</_ref><Key>DueDate</Key><ID>DueDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Due Date</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_DueDate</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ErrMsg</_ref><Key>ErrMsg</Key><ID>ErrMsg</ID><IsBound>true</IsBound><ColumnChooserCaption>Error Message</ColumnChooserCaption><VisiblePosition>550</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ErrMsg</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Item</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemDesc</_ref><Key>ItemDesc</Key><ID>ItemDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Item Description</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>207</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemDesc</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemStat</_ref><Key>ItemStat</Key><ID>ItemStat</ID><IsBound>true</IsBound><ColumnChooserCaption>Material Status</ColumnChooserCaption><VisiblePosition>607</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>24</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemStat</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemUM</_ref><Key>ItemUM</Key><ID>ItemUM</ID><IsBound>true</IsBound><ColumnChooserCaption>U/M</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemUM</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Level</_ref><Key>Level</Key><ID>Level</ID><IsBound>true</IsBound><ColumnChooserCaption>With Errors</ColumnChooserCaption><VisiblePosition>608</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Boolean</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Level</Ref></ColumnInfo></value></item><item><key><int>19</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_NetQtyAvl</_ref><Key>NetQtyAvl</Key><ID>NetQtyAvl</ID><IsBound>true</IsBound><ColumnChooserCaption>Qty To Ship</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>140</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_NetQtyAvl</Ref></ColumnInfo></value></item><item><key><int>20</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_OrderDate</_ref><Key>OrderDate</Key><ID>OrderDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Date</ColumnChooserCaption><VisiblePosition>609</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_OrderDate</Ref></ColumnInfo></value></item><item><key><int>21</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_PriceConv</_ref><Key>PriceConv</Key><ID>PriceConv</ID><IsBound>true</IsBound><ColumnChooserCaption>PriceConv</ColumnChooserCaption><VisiblePosition>610</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>22</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_PriceConv</Ref></ColumnInfo></value></item><item><key><int>22</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyInvoiced</_ref><Key>QtyInvoiced</Key><ID>QtyInvoiced</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyInvoiced</ColumnChooserCaption><VisiblePosition>611</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>21</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyInvoiced</Ref></ColumnInfo></value></item><item><key><int>23</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyOrderedConv</_ref><Key>QtyOrderedConv</Key><ID>QtyOrderedConv</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyOrderedConv</ColumnChooserCaption><VisiblePosition>612</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>20</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyOrderedConv</Ref></ColumnInfo></value></item><item><key><int>24</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyReady</_ref><Key>QtyReady</Key><ID>QtyReady</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyReady</ColumnChooserCaption><VisiblePosition>613</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>27</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyReady</Ref></ColumnInfo></value></item><item><key><int>25</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyRemaining</_ref><Key>QtyRemaining</Key><ID>QtyRemaining</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyRemaining</ColumnChooserCaption><VisiblePosition>614</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>26</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyRemaining</Ref></ColumnInfo></value></item><item><key><int>26</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyShipped</_ref><Key>QtyShipped</Key><ID>QtyShipped</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyShipped</ColumnChooserCaption><VisiblePosition>615</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>25</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyShipped</Ref></ColumnInfo></value></item><item><key><int>27</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RptSeq</_ref><Key>RptSeq</Key><ID>RptSeq</ID><IsBound>true</IsBound><ColumnChooserCaption>RptSeq</ColumnChooserCaption><VisiblePosition>616</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RptSeq</Ref></ColumnInfo></value></item><item><key><int>28</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Seq</_ref><Key>Seq</Key><ID>Seq</ID><IsBound>true</IsBound><ColumnChooserCaption>Seq</ColumnChooserCaption><VisiblePosition>617</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Seq</Ref></ColumnInfo></value></item><item><key><int>29</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyFormat</_ref><Key>UnitQtyFormat</Key><ID>UnitQtyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>618</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>31</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyFormat</Ref></ColumnInfo></value></item><item><key><int>30</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyPlaces</_ref><Key>UnitQtyPlaces</Key><ID>UnitQtyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>619</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>30</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyPlaces</Ref></ColumnInfo></value></item><item><key><int>31</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Whse</_ref><Key>Whse</Key><ID>Whse</ID><IsBound>true</IsBound><ColumnChooserCaption>Warehouse</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Whse</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Whse</Ref><Key>Whse</Key></SortedColumnInfo></value></item><item><key><int>1</int></key><value><SortedColumnInfo><RelativeIndex>1</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Level</Ref><Key>Level</Key></SortedColumnInfo></value></item><item><key><int>2</int></key><value><SortedColumnInfo><RelativeIndex>2</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings><item><key><int>0</int></key><value><SummarySettingInfo><DisplayFormat>TotalNetPrice = {0:N}</DisplayFormat><SummaryType>5</SummaryType><Formula>SUM( IF( [ErrMsg(0)]="", [AmtNetPrice(0)] ,0) ) </Formula><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></Col><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SourceCol><Ref>0</Ref><Key>SLAvailableToShipReport:TotalNetPrice</Key></SummarySettingInfo></value></item></SummarySettings><ColumnFilters /><Ref>SLAvailableToShipReport</Ref><KeyID>SLAvailableToShipReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   NULL,--ReportOrientation
   1 --DefaultView
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'SortByDueDate' AND SourceType = N'V' AND SourceName = N'Available To Ship Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'SortByDueDate',--LayoutName
   N'V',--SourceType
   N'Available To Ship Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>SortByDueDate</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>true</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[3ad1afb6-46d2-42a7-8df3-5a9dedb35f74] dvl.DT=[2018-06-07 06:13:30.597]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAvailableToShipReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>601</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_BatchErr</_ref><Key>BatchErr</Key><ID>BatchErr</ID><IsBound>true</IsBound><ColumnChooserCaption>Batch Error Message</ColumnChooserCaption><VisiblePosition>600</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_BatchErr</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoitemDisc</_ref><Key>CoitemDisc</Key><ID>CoitemDisc</ID><IsBound>true</IsBound><ColumnChooserCaption>Discount</ColumnChooserCaption><VisiblePosition>602</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>23</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoitemDisc</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoLine</_ref><Key>CoLine</Key><ID>CoLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Line</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoLine</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoNum</_ref><Key>CoNum</Key><ID>CoNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Order</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>100</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoRelease</_ref><Key>CoRelease</Key><ID>CoRelease</ID><IsBound>true</IsBound><ColumnChooserCaption>Release</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>105</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoRelease</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrCode</_ref><Key>CurrCode</Key><ID>CurrCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Currency</ColumnChooserCaption><VisiblePosition>603</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>28</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrCode</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrDesc</_ref><Key>CurrDesc</Key><ID>CurrDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>604</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>29</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrDesc</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>262</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustName</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>605</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Disc</_ref><Key>Disc</Key><ID>Disc</ID><IsBound>true</IsBound><ColumnChooserCaption>Order Disc</ColumnChooserCaption><VisiblePosition>606</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>19</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Disc</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_DueDate</_ref><Key>DueDate</Key><ID>DueDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Due Date</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_DueDate</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ErrMsg</_ref><Key>ErrMsg</Key><ID>ErrMsg</ID><IsBound>true</IsBound><ColumnChooserCaption>Error Message</ColumnChooserCaption><VisiblePosition>550</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ErrMsg</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Item</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemDesc</_ref><Key>ItemDesc</Key><ID>ItemDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Item Description</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>207</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemDesc</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemStat</_ref><Key>ItemStat</Key><ID>ItemStat</ID><IsBound>true</IsBound><ColumnChooserCaption>Material Status</ColumnChooserCaption><VisiblePosition>607</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>24</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemStat</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemUM</_ref><Key>ItemUM</Key><ID>ItemUM</ID><IsBound>true</IsBound><ColumnChooserCaption>U/M</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemUM</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Level</_ref><Key>Level</Key><ID>Level</ID><IsBound>true</IsBound><ColumnChooserCaption>With Errors</ColumnChooserCaption><VisiblePosition>608</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Boolean</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Level</Ref></ColumnInfo></value></item><item><key><int>19</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_NetQtyAvl</_ref><Key>NetQtyAvl</Key><ID>NetQtyAvl</ID><IsBound>true</IsBound><ColumnChooserCaption>Qty To Ship</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>140</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_NetQtyAvl</Ref></ColumnInfo></value></item><item><key><int>20</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_OrderDate</_ref><Key>OrderDate</Key><ID>OrderDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Date</ColumnChooserCaption><VisiblePosition>609</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_OrderDate</Ref></ColumnInfo></value></item><item><key><int>21</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_PriceConv</_ref><Key>PriceConv</Key><ID>PriceConv</ID><IsBound>true</IsBound><ColumnChooserCaption>PriceConv</ColumnChooserCaption><VisiblePosition>610</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>22</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_PriceConv</Ref></ColumnInfo></value></item><item><key><int>22</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyInvoiced</_ref><Key>QtyInvoiced</Key><ID>QtyInvoiced</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyInvoiced</ColumnChooserCaption><VisiblePosition>611</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>21</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyInvoiced</Ref></ColumnInfo></value></item><item><key><int>23</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyOrderedConv</_ref><Key>QtyOrderedConv</Key><ID>QtyOrderedConv</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyOrderedConv</ColumnChooserCaption><VisiblePosition>612</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>20</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyOrderedConv</Ref></ColumnInfo></value></item><item><key><int>24</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyReady</_ref><Key>QtyReady</Key><ID>QtyReady</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyReady</ColumnChooserCaption><VisiblePosition>613</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>27</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyReady</Ref></ColumnInfo></value></item><item><key><int>25</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyRemaining</_ref><Key>QtyRemaining</Key><ID>QtyRemaining</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyRemaining</ColumnChooserCaption><VisiblePosition>614</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>26</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyRemaining</Ref></ColumnInfo></value></item><item><key><int>26</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyShipped</_ref><Key>QtyShipped</Key><ID>QtyShipped</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyShipped</ColumnChooserCaption><VisiblePosition>615</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>25</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyShipped</Ref></ColumnInfo></value></item><item><key><int>27</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RptSeq</_ref><Key>RptSeq</Key><ID>RptSeq</ID><IsBound>true</IsBound><ColumnChooserCaption>RptSeq</ColumnChooserCaption><VisiblePosition>616</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RptSeq</Ref></ColumnInfo></value></item><item><key><int>28</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Seq</_ref><Key>Seq</Key><ID>Seq</ID><IsBound>true</IsBound><ColumnChooserCaption>Seq</ColumnChooserCaption><VisiblePosition>617</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Seq</Ref></ColumnInfo></value></item><item><key><int>29</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyFormat</_ref><Key>UnitQtyFormat</Key><ID>UnitQtyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>618</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>31</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyFormat</Ref></ColumnInfo></value></item><item><key><int>30</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyPlaces</_ref><Key>UnitQtyPlaces</Key><ID>UnitQtyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>619</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>30</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyPlaces</Ref></ColumnInfo></value></item><item><key><int>31</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Whse</_ref><Key>Whse</Key><ID>Whse</ID><IsBound>true</IsBound><ColumnChooserCaption>Warehouse</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Whse</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Whse</Ref><Key>Whse</Key></SortedColumnInfo></value></item><item><key><int>1</int></key><value><SortedColumnInfo><RelativeIndex>1</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Level</Ref><Key>Level</Key></SortedColumnInfo></value></item><item><key><int>2</int></key><value><SortedColumnInfo><RelativeIndex>2</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_DueDate</Ref><Key>DueDate</Key></SortedColumnInfo></value></item><item><key><int>3</int></key><value><SortedColumnInfo><RelativeIndex>3</RelativeIndex><Bound>false</Bound><SortIndicator>1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings><item><key><int>0</int></key><value><SummarySettingInfo><SummaryType>1</SummaryType><Formula /><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></Col><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SourceCol><Ref>0</Ref><Key>0</Key></SummarySettingInfo></value></item></SummarySettings><ColumnFilters /><Ref>SLAvailableToShipReport</Ref><KeyID>SLAvailableToShipReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   NULL,--ReportOrientation
   1 --DefaultView
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'SortByItem' AND SourceType = N'V' AND SourceName = N'Available To Ship Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'SortByItem',--LayoutName
   N'V',--SourceType
   N'Available To Ship Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>SortByItem</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>false</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[993f0d52-cd82-4d2b-bc79-edc1b2f377d8] dvl.DT=[2018-06-07 04:03:09.770]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAvailableToShipReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>601</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_BatchErr</_ref><Key>BatchErr</Key><ID>BatchErr</ID><IsBound>true</IsBound><ColumnChooserCaption>Batch Error Message</ColumnChooserCaption><VisiblePosition>600</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_BatchErr</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoitemDisc</_ref><Key>CoitemDisc</Key><ID>CoitemDisc</ID><IsBound>true</IsBound><ColumnChooserCaption>Discount</ColumnChooserCaption><VisiblePosition>602</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>23</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoitemDisc</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoLine</_ref><Key>CoLine</Key><ID>CoLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Line</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoLine</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoNum</_ref><Key>CoNum</Key><ID>CoNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Order</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>100</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoRelease</_ref><Key>CoRelease</Key><ID>CoRelease</ID><IsBound>true</IsBound><ColumnChooserCaption>Release</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>105</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoRelease</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrCode</_ref><Key>CurrCode</Key><ID>CurrCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Currency</ColumnChooserCaption><VisiblePosition>603</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>28</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrCode</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrDesc</_ref><Key>CurrDesc</Key><ID>CurrDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>604</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>29</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrDesc</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>262</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustName</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>605</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Disc</_ref><Key>Disc</Key><ID>Disc</ID><IsBound>true</IsBound><ColumnChooserCaption>Order Disc</ColumnChooserCaption><VisiblePosition>606</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>19</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Disc</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_DueDate</_ref><Key>DueDate</Key><ID>DueDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Due Date</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_DueDate</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ErrMsg</_ref><Key>ErrMsg</Key><ID>ErrMsg</ID><IsBound>true</IsBound><ColumnChooserCaption>Error Message</ColumnChooserCaption><VisiblePosition>550</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ErrMsg</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Item</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemDesc</_ref><Key>ItemDesc</Key><ID>ItemDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Item Description</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>207</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemDesc</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemStat</_ref><Key>ItemStat</Key><ID>ItemStat</ID><IsBound>true</IsBound><ColumnChooserCaption>Material Status</ColumnChooserCaption><VisiblePosition>607</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>24</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemStat</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemUM</_ref><Key>ItemUM</Key><ID>ItemUM</ID><IsBound>true</IsBound><ColumnChooserCaption>U/M</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemUM</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Level</_ref><Key>Level</Key><ID>Level</ID><IsBound>true</IsBound><ColumnChooserCaption>With Errors</ColumnChooserCaption><VisiblePosition>608</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Boolean</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Level</Ref></ColumnInfo></value></item><item><key><int>19</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_NetQtyAvl</_ref><Key>NetQtyAvl</Key><ID>NetQtyAvl</ID><IsBound>true</IsBound><ColumnChooserCaption>Qty To Ship</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>140</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_NetQtyAvl</Ref></ColumnInfo></value></item><item><key><int>20</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_OrderDate</_ref><Key>OrderDate</Key><ID>OrderDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Date</ColumnChooserCaption><VisiblePosition>609</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_OrderDate</Ref></ColumnInfo></value></item><item><key><int>21</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_PriceConv</_ref><Key>PriceConv</Key><ID>PriceConv</ID><IsBound>true</IsBound><ColumnChooserCaption>PriceConv</ColumnChooserCaption><VisiblePosition>610</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>22</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_PriceConv</Ref></ColumnInfo></value></item><item><key><int>22</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyInvoiced</_ref><Key>QtyInvoiced</Key><ID>QtyInvoiced</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyInvoiced</ColumnChooserCaption><VisiblePosition>611</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>21</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyInvoiced</Ref></ColumnInfo></value></item><item><key><int>23</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyOrderedConv</_ref><Key>QtyOrderedConv</Key><ID>QtyOrderedConv</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyOrderedConv</ColumnChooserCaption><VisiblePosition>612</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>20</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyOrderedConv</Ref></ColumnInfo></value></item><item><key><int>24</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyReady</_ref><Key>QtyReady</Key><ID>QtyReady</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyReady</ColumnChooserCaption><VisiblePosition>613</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>27</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyReady</Ref></ColumnInfo></value></item><item><key><int>25</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyRemaining</_ref><Key>QtyRemaining</Key><ID>QtyRemaining</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyRemaining</ColumnChooserCaption><VisiblePosition>614</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>26</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyRemaining</Ref></ColumnInfo></value></item><item><key><int>26</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyShipped</_ref><Key>QtyShipped</Key><ID>QtyShipped</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyShipped</ColumnChooserCaption><VisiblePosition>615</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>25</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyShipped</Ref></ColumnInfo></value></item><item><key><int>27</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RptSeq</_ref><Key>RptSeq</Key><ID>RptSeq</ID><IsBound>true</IsBound><ColumnChooserCaption>RptSeq</ColumnChooserCaption><VisiblePosition>616</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RptSeq</Ref></ColumnInfo></value></item><item><key><int>28</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Seq</_ref><Key>Seq</Key><ID>Seq</ID><IsBound>true</IsBound><ColumnChooserCaption>Seq</ColumnChooserCaption><VisiblePosition>617</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Seq</Ref></ColumnInfo></value></item><item><key><int>29</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyFormat</_ref><Key>UnitQtyFormat</Key><ID>UnitQtyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>618</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>31</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyFormat</Ref></ColumnInfo></value></item><item><key><int>30</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyPlaces</_ref><Key>UnitQtyPlaces</Key><ID>UnitQtyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>619</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>30</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyPlaces</Ref></ColumnInfo></value></item><item><key><int>31</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Whse</_ref><Key>Whse</Key><ID>Whse</ID><IsBound>true</IsBound><ColumnChooserCaption>Warehouse</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Whse</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Whse</Ref><Key>Whse</Key></SortedColumnInfo></value></item><item><key><int>1</int></key><value><SortedColumnInfo><RelativeIndex>1</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Level</Ref><Key>Level</Key></SortedColumnInfo></value></item><item><key><int>2</int></key><value><SortedColumnInfo><RelativeIndex>2</RelativeIndex><Bound>false</Bound><SortIndicator>0</SortIndicator><IsGroupByColumn>true</IsGroupByColumn><Ref>SLAvailableToShipReport_Item</Ref><Key>Item</Key></SortedColumnInfo></value></item><item><key><int>3</int></key><value><SortedColumnInfo><RelativeIndex>3</RelativeIndex><Bound>false</Bound><SortIndicator>1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings><item><key><int>0</int></key><value><SummarySettingInfo><DisplayFormat>TotalNetPrice = {0:N}</DisplayFormat><SummaryType>5</SummaryType><Formula>SUM( IF( [ErrMsg(0)]="", [AmtNetPrice(0)] ,0) ) </Formula><SourceCol><RelativeIndex>-1</RelativeIndex><Bound>false</Bound><SortIndicator>-1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Col><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></Col><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SourceCol><Ref>0</Ref><Key>SLAvailableToShipReport:TotalNetPrice</Key></SummarySettingInfo></value></item></SummarySettings><ColumnFilters /><Ref>SLAvailableToShipReport</Ref><KeyID>SLAvailableToShipReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   NULL,--ReportOrientation
   1 --DefaultView
)

IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'ReportOutput' AND SourceType = N'V' AND SourceName = N'Available To Ship Report' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'Available To Ship Report',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'<DataViewLayout xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><LayoutName>ReportOutput</LayoutName><ScopeType>0</ScopeType><ScopeName>[NULL]</ScopeName><DefaultView>false</DefaultView><_ItemId>PBT=[WBDataViewLayout] dvl.ID=[cb0cecf2-95d3-48b3-a8f9-c455cd09204a] dvl.DT=[2018-06-04 03:14:09.537]</_ItemId><BandCount>1</BandCount><Bands><item><key><int>0</int></key><value><BandInfo><Key>SLAvailableToShipReport</Key><Index>0</Index><ParentIndex>-1</ParentIndex><Caption /><Columns><item><key><int>0</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RowPointer</_ref><Key>RowPointer</Key><ID>RowPointer</ID><IsBound>true</IsBound><ColumnChooserCaption>Row Pointer</ColumnChooserCaption><VisiblePosition>601</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Guid</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RowPointer</Ref></ColumnInfo></value></item><item><key><int>1</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_AmtNetPrice</_ref><Key>AmtNetPrice</Key><ID>AmtNetPrice</ID><IsBound>true</IsBound><ColumnChooserCaption>Net Amount</ColumnChooserCaption><VisiblePosition>500</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>143</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>10</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_AmtNetPrice</Ref></ColumnInfo></value></item><item><key><int>2</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_BatchErr</_ref><Key>BatchErr</Key><ID>BatchErr</ID><IsBound>true</IsBound><ColumnChooserCaption>Batch Error Message</ColumnChooserCaption><VisiblePosition>600</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>12</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_BatchErr</Ref></ColumnInfo></value></item><item><key><int>3</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoitemDisc</_ref><Key>CoitemDisc</Key><ID>CoitemDisc</ID><IsBound>true</IsBound><ColumnChooserCaption>Discount</ColumnChooserCaption><VisiblePosition>602</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>23</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoitemDisc</Ref></ColumnInfo></value></item><item><key><int>4</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoLine</_ref><Key>CoLine</Key><ID>CoLine</ID><IsBound>true</IsBound><ColumnChooserCaption>Line</ColumnChooserCaption><VisiblePosition>150</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>77</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>3</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoLine</Ref></ColumnInfo></value></item><item><key><int>5</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoNum</_ref><Key>CoNum</Key><ID>CoNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Order</ColumnChooserCaption><VisiblePosition>100</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>100</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>2</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoNum</Ref></ColumnInfo></value></item><item><key><int>6</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CoRelease</_ref><Key>CoRelease</Key><ID>CoRelease</ID><IsBound>true</IsBound><ColumnChooserCaption>Release</ColumnChooserCaption><VisiblePosition>200</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>105</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>4</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CoRelease</Ref></ColumnInfo></value></item><item><key><int>7</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrCode</_ref><Key>CurrCode</Key><ID>CurrCode</ID><IsBound>true</IsBound><ColumnChooserCaption>Currency</ColumnChooserCaption><VisiblePosition>603</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>28</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrCode</Ref></ColumnInfo></value></item><item><key><int>8</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CurrDesc</_ref><Key>CurrDesc</Key><ID>CurrDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Description</ColumnChooserCaption><VisiblePosition>604</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>29</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CurrDesc</Ref></ColumnInfo></value></item><item><key><int>9</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustName</_ref><Key>CustName</Key><ID>CustName</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>350</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>262</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>7</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustName</Ref></ColumnInfo></value></item><item><key><int>10</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_CustNum</_ref><Key>CustNum</Key><ID>CustNum</ID><IsBound>true</IsBound><ColumnChooserCaption>Customer</ColumnChooserCaption><VisiblePosition>605</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>18</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_CustNum</Ref></ColumnInfo></value></item><item><key><int>11</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Disc</_ref><Key>Disc</Key><ID>Disc</ID><IsBound>true</IsBound><ColumnChooserCaption>Order Disc</ColumnChooserCaption><VisiblePosition>606</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>19</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Disc</Ref></ColumnInfo></value></item><item><key><int>12</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_DueDate</_ref><Key>DueDate</Key><ID>DueDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Due Date</ColumnChooserCaption><VisiblePosition>50</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>1</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_DueDate</Ref></ColumnInfo></value></item><item><key><int>13</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ErrMsg</_ref><Key>ErrMsg</Key><ID>ErrMsg</ID><IsBound>true</IsBound><ColumnChooserCaption>Error Message</ColumnChooserCaption><VisiblePosition>550</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>120</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>11</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ErrMsg</Ref></ColumnInfo></value></item><item><key><int>14</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Item</_ref><Key>Item</Key><ID>Item</ID><IsBound>true</IsBound><ColumnChooserCaption>Item</ColumnChooserCaption><VisiblePosition>250</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>94</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>5</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Item</Ref></ColumnInfo></value></item><item><key><int>15</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemDesc</_ref><Key>ItemDesc</Key><ID>ItemDesc</ID><IsBound>true</IsBound><ColumnChooserCaption>Item Description</ColumnChooserCaption><VisiblePosition>300</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>207</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>6</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemDesc</Ref></ColumnInfo></value></item><item><key><int>16</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemStat</_ref><Key>ItemStat</Key><ID>ItemStat</ID><IsBound>true</IsBound><ColumnChooserCaption>Material Status</ColumnChooserCaption><VisiblePosition>607</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>24</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemStat</Ref></ColumnInfo></value></item><item><key><int>17</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_ItemUM</_ref><Key>ItemUM</Key><ID>ItemUM</ID><IsBound>true</IsBound><ColumnChooserCaption>U/M</ColumnChooserCaption><VisiblePosition>450</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>84</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>9</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_ItemUM</Ref></ColumnInfo></value></item><item><key><int>18</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Level</_ref><Key>Level</Key><ID>Level</ID><IsBound>true</IsBound><ColumnChooserCaption>Level</ColumnChooserCaption><VisiblePosition>608</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>15</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Level</Ref></ColumnInfo></value></item><item><key><int>19</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_NetQtyAvl</_ref><Key>NetQtyAvl</Key><ID>NetQtyAvl</ID><IsBound>true</IsBound><ColumnChooserCaption>Qty To Ship</ColumnChooserCaption><VisiblePosition>400</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>140</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>8</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_NetQtyAvl</Ref></ColumnInfo></value></item><item><key><int>20</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_OrderDate</_ref><Key>OrderDate</Key><ID>OrderDate</ID><IsBound>true</IsBound><ColumnChooserCaption>Date</ColumnChooserCaption><VisiblePosition>609</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.DateTime</DataType><FormulaHeader /><OriginX>17</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_OrderDate</Ref></ColumnInfo></value></item><item><key><int>21</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_PriceConv</_ref><Key>PriceConv</Key><ID>PriceConv</ID><IsBound>true</IsBound><ColumnChooserCaption>PriceConv</ColumnChooserCaption><VisiblePosition>610</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>22</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_PriceConv</Ref></ColumnInfo></value></item><item><key><int>22</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyInvoiced</_ref><Key>QtyInvoiced</Key><ID>QtyInvoiced</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyInvoiced</ColumnChooserCaption><VisiblePosition>611</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>21</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyInvoiced</Ref></ColumnInfo></value></item><item><key><int>23</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyOrderedConv</_ref><Key>QtyOrderedConv</Key><ID>QtyOrderedConv</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyOrderedConv</ColumnChooserCaption><VisiblePosition>612</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>20</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyOrderedConv</Ref></ColumnInfo></value></item><item><key><int>24</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyReady</_ref><Key>QtyReady</Key><ID>QtyReady</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyReady</ColumnChooserCaption><VisiblePosition>613</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>27</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyReady</Ref></ColumnInfo></value></item><item><key><int>25</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyRemaining</_ref><Key>QtyRemaining</Key><ID>QtyRemaining</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyRemaining</ColumnChooserCaption><VisiblePosition>614</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>26</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyRemaining</Ref></ColumnInfo></value></item><item><key><int>26</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_QtyShipped</_ref><Key>QtyShipped</Key><ID>QtyShipped</ID><IsBound>true</IsBound><ColumnChooserCaption>QtyShipped</ColumnChooserCaption><VisiblePosition>615</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Decimal</DataType><FormulaHeader /><OriginX>25</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_QtyShipped</Ref></ColumnInfo></value></item><item><key><int>27</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_RptSeq</_ref><Key>RptSeq</Key><ID>RptSeq</ID><IsBound>true</IsBound><ColumnChooserCaption>RptSeq</ColumnChooserCaption><VisiblePosition>616</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>16</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_RptSeq</Ref></ColumnInfo></value></item><item><key><int>28</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Seq</_ref><Key>Seq</Key><ID>Seq</ID><IsBound>true</IsBound><ColumnChooserCaption>Seq</ColumnChooserCaption><VisiblePosition>617</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>14</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Seq</Ref></ColumnInfo></value></item><item><key><int>29</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyFormat</_ref><Key>UnitQtyFormat</Key><ID>UnitQtyFormat</ID><IsBound>true</IsBound><ColumnChooserCaption>Amount Format</ColumnChooserCaption><VisiblePosition>618</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>31</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyFormat</Ref></ColumnInfo></value></item><item><key><int>30</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_UnitQtyPlaces</_ref><Key>UnitQtyPlaces</Key><ID>UnitQtyPlaces</ID><IsBound>true</IsBound><ColumnChooserCaption>Monetary Decimal Places</ColumnChooserCaption><VisiblePosition>619</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>0</Width><Hidden>true</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.Int64</DataType><FormulaHeader /><OriginX>30</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_UnitQtyPlaces</Ref></ColumnInfo></value></item><item><key><int>31</int></key><value><ColumnInfo><_ref>SLAvailableToShipReport_Whse</_ref><Key>Whse</Key><ID>Whse</ID><IsBound>true</IsBound><ColumnChooserCaption>Warehouse</ColumnChooserCaption><VisiblePosition>0</VisiblePosition><Fixed>false</Fixed><FixOnRight>-1</FixOnRight><Width>124</Width><Hidden>false</Hidden><Style>-1</Style><Format /><Formula /><DataType>System.String</DataType><FormulaHeader /><OriginX>0</OriginX><OriginY>0</OriginY><SpanX>1</SpanX><SpanY>1</SpanY><Ref>SLAvailableToShipReport_Whse</Ref></ColumnInfo></value></item></Columns><SortedColumns><item><key><int>0</int></key><value><SortedColumnInfo><RelativeIndex>0</RelativeIndex><Bound>false</Bound><SortIndicator>1</SortIndicator><IsGroupByColumn>false</IsGroupByColumn><Ref>SLAvailableToShipReport_AmtNetPrice</Ref><Key>AmtNetPrice</Key></SortedColumnInfo></value></item></SortedColumns><SummarySettings /><ColumnFilters /><Ref>SLAvailableToShipReport</Ref><KeyID>SLAvailableToShipReport</KeyID><ColumnsRef /><HeaderRef /><SortedColsRef /><SummarySettingsRef /><ColumnFiltersRef /></BandInfo></value></item></Bands><ColumnTypes /></DataViewLayout>',--Layout
   NULL,--ReportOrientation
   1 --DefaultView
)


INSERT INTO WBDataViewGroup SELECT * FROM #TMP_WBDataViewGroup
WHERE GroupName NOT IN (SELECT GroupName FROM WBDataViewGroup WHERE ViewName = N'Available To Ship Report')

-- Insert/update/delete WBDataViewIDO data
DELETE WBDataViewIDO
FROM WBDataViewIDO wido
LEFT JOIN #TMP_WBDataViewIDO tido ON tido.ViewName = wido.ViewName
AND tido.IDOName = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName = N'Available To Ship Report'
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
WHERE wido.ViewName = N'Available To Ship Report'
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
WHERE wcol.ViewName = N'Available To Ship Report'
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
   ROW_NUMBER() OVER(ORDER BY tcol.Seq) + (SELECT ISNULL(MAX(Seq), 0) FROM WBDataViewColumn WHERE ViewName = N'Available To Ship Report'),
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
WHERE wlayout.SourceName = N'Available To Ship Report'
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
WHERE wlayout.SourceName = N'Available To Ship Report'
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
