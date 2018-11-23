IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewGroup WHERE ViewName = N'[###ViewName###]' AND GroupName = N'[###GroupName###]')
INSERT INTO dbo.WBDataViewGroup (
   ViewName,
   GroupName
) VALUES (
   N'[###ViewName###]',--ViewName
   N'[###GroupName###]'--GroupName
)
