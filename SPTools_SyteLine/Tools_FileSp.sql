IF OBJECT_ID('dbo.Tools_File_WriteAllTextSp') IS NOT NULL
    DROP PROCEDURE [dbo].[Tools_File_WriteAllTextSp]
GO

CREATE PROCEDURE [dbo].[Tools_File_WriteAllTextSp]
(
   @FileFullName NVARCHAR(1000)
 , @FileContent  NVARCHAR(MAX)
) AS

DECLARE
   @Object INT
 , @rc INT
 , @FileID INT

EXEC @rc = sp_OACreate 'Scripting.FileSystemObject', @Object OUTPUT
EXEC @rc = sp_OAMethod @Object, 'OpenTextFile', @FileID OUTPUT, @FileFullName, 2, 1
SET @FileContent = REPLACE(REPLACE(REPLACE(@FileContent, '&', '&'), '<', '<'), '>', '>')
EXEC @rc = sp_OAMethod @FileID, 'WriteLine', NULL, @FileContent
EXEC @rc = dbo.sp_OADestroy @FileID

EXEC @rc = dbo.sp_OADestroy @Object, 'SaveFile', NULL, @FileContent, @FileFullName, 0

EXEC sp_OADestroy @FileID
EXEC sp_OADestroy @Object

GO



IF OBJECT_ID('dbo.Tools_File_ReadAllTextSp') IS NOT NULL
    DROP PROCEDURE [dbo].[Tools_File_ReadAllTextSp]
GO

CREATE PROCEDURE [dbo].[Tools_File_ReadAllTextSp]
(
   @FileFullName NVARCHAR(1000)
 , @FileContent  NVARCHAR(MAX) OUTPUT
) AS

DECLARE
   @Object INT
 , @rc INT
 , @FileID INT
 , @strLine NVARCHAR(4000) = ''
 , @blnEndOfFile INT = 0

SET @FileContent = ''

EXEC @rc = sp_OACreate 'Scripting.FileSystemObject', @Object OUTPUT
EXEC @rc = sp_OAMethod @Object, 'OpenTextFile', @FileID OUTPUT, @FileFullName, 1

EXEC sp_OAMethod @FileID, 'AtEndOfStream', @blnEndOfFile OUTPUT
WHILE @blnEndOfFile = 0
BEGIN
   EXEC sp_OAMethod @FileID, 'ReadLine', @strLine OUTPUT
   SET @FileContent = @FileContent + ISNULL(@strLine, '') + CHAR(13)
   EXEC sp_OAMethod @FileID, 'AtEndOfStream', @blnEndOfFile OUTPUT
END

EXEC sp_OADestroy @FileID
EXEC sp_OADestroy @Object

GO

-- Test Code Here
EXEC Tools_File_WriteAllTextSp
'\\USCOVWSL901TS2\Shared\Test.txt',
'File Content Text Here
First Line
Second Line
...

Last Line.'

DECLARE @Content nvarchar(1000)
EXEC Tools_File_ReadAllTextSp '\\USCOVWSL901TS2\Shared\abc.txt', @Content OUTPUT
SELECT @Content
