IF NOT EXISTS (SELECT 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'[###ViewName###]' AND PropertyName = N'[###PropertyName###]' AND IDOAlias = N'[###IDOAlias###]')
INSERT INTO #TMP_WBDataViewColumn (
   ViewName,
   PropertyName,
   Seq,
   IDOAlias,
   ColumnHeaderOverride,
   IsSystemRecord
) VALUES (
   N'[###ViewName###]',--ViewName
   N'[###PropertyName###]',--PropertyName
   (SELECT ISNULL(MAX(Seq), 0) + 1 FROM #TMP_WBDataViewColumn WHERE ViewName = N'[###ViewName###]'),--Seq
   N'[###IDOAlias###]',--IDOAlias
   N'[###ColumnHeaderOverride###]',--ColumnHeaderOverride
   1 --IsSystemRecord
)

