IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE [type] = 'U' AND [name] = 'log_msg')
BEGIN
   CREATE TABLE log_msg
   (
      Key1       SYSNAME
    , Value1     NVARCHAR(4000)
    , Key2       SYSNAME
    , Value2     NVARCHAR(4000)
    , LogMsg     NVARCHAR(4000)
    , Spid       INT
    , UserName   NameType
   )
END

IF OBJECT_ID('dbo.Tools_LogSp') IS NOT NULL
    DROP PROCEDURE [dbo].[Tools_LogSp]
GO
CREATE PROCEDURE Tools_LogSp
(
   @Key1         SYSNAME = NULL
 , @Value1       NVARCHAR(4000) = NULL
 , @Key2         SYSNAME = NULL
 , @Value2       NVARCHAR(4000) = NULL
 , @LogMessage   NVARCHAR(4000) = NULL
) AS

DECLARE @UserName NameType
SET @UserName = dbo.UserNameSp()

INSERT INTO log_msg(Key1, Value1, Key2, Value2, LogMsg, Spid, UserName)
VALUES(@Key1, @Value1, @Key2, @Value2, @LogMessage, @@SPID, @UserName)

GO
