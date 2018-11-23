IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewLayout WHERE LayoutName = N'[###LayoutName###]' AND SourceType = N'V' AND SourceName = N'[###SourceName###]' AND ScopeName = N'[NULL]' AND ScopeType = 0)
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
   N'[###LayoutName###]',--LayoutName
   N'V',--SourceType
   N'[###SourceName###]',--SourceName
   N'[NULL]',--ScopeName
   0,--ScopeType
   N'WBDataViewResults',--ComponentName
   N'[###Layout###]',--Layout
   N'[###ReportOrientation###]',--ReportOrientation
   1 --DefaultView
)

