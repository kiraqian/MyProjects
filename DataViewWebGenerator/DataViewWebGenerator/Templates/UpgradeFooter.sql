INSERT INTO WBDataViewGroup SELECT * FROM #TMP_WBDataViewGroup
WHERE GroupName NOT IN (SELECT GroupName FROM WBDataViewGroup WHERE ViewName = N'[###DataViewName###]')

-- Insert/update/delete WBDataViewIDO data
DELETE WBDataViewIDO
FROM WBDataViewIDO wido
LEFT JOIN #TMP_WBDataViewIDO tido ON tido.ViewName = wido.ViewName
AND tido.IDOName = wido.IDOName
AND tido.IDOAlias = wido.IDOAlias
WHERE wido.ViewName = N'[###DataViewName###]'
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
WHERE wido.ViewName = N'[###DataViewName###]'
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
WHERE wcol.ViewName = N'[###DataViewName###]'
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
   ROW_NUMBER() OVER(ORDER BY tcol.Seq) + (SELECT ISNULL(MAX(Seq), 0) FROM WBDataViewColumn WHERE ViewName = N'[###DataViewName###]'),
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
WHERE wlayout.SourceName = N'[###DataViewName###]'
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
WHERE wlayout.SourceName = N'[###DataViewName###]'
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
