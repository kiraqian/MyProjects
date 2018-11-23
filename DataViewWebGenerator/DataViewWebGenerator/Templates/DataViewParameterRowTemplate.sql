IF NOT EXISTS (SELECT 1 FROM dbo.WBDataViewParameter WHERE ViewName = N'[###ViewName###]' AND Seq = [###Seq###])
INSERT INTO dbo.WBDataViewParameter (
   ViewName,   
   Seq,
   PropertyName,
   Operator,
   Description,
   EndOfDay
) VALUES (
   N'[###ViewName###]',--ViewName
   [###Seq###],--Seq
   N'[###PropertyName###]',--PropertyName
   N'[###Operator###]',--Operator
   N'[###Description###]',--Description
   [###EndOfDay###] --EndOfDay
)
