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

SELECT * INTO #TMP_WBDataViewGroup FROM WBDataViewGroup WHERE ViewName = N'[###DataViewName###]'

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

DELETE FROM dbo.WBDataViewGroup WHERE ViewName = N'[###DataViewName###]'
DELETE FROM dbo.WBDataViewParameter WHERE ViewName = N'[###DataViewName###]'

