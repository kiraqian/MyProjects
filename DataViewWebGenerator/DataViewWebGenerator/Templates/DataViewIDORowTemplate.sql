IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewIDO WHERE ViewName = N'[###ViewName###]' AND IDOName = N'[###IDOName###]' AND IDOAlias = N'[###IDOAlias###]')
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
   N'[###ViewName###]',--ViewName
   N'[###IDOName###]',--IDOName
   N'[###ParentIDO###]',--ParentIDO
   N'[###Filter###]',--Filter
   N'[###ParentLinks###]',--ParentLinks
   N'[###OrderBy###]',--OrderBy
   N'[###IDOAlias###]',--IDOAlias
   N'[###LinkType###]',--LinkType
   [###RecordCap###],--RecordCap
   N'[###SourceType###]',--SourceType
   N'[###SourceName###]',--SourceName
   1,--IsSystemRecord
   [###ShowInternalNotes###],--ShowInternalNotes
   [###ShowExternalNotes###] --ShowExternalNotes
)

