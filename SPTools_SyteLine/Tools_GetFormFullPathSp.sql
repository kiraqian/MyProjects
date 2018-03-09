IF OBJECT_ID('dbo.Tools_GetFormFullPathSp') IS NOT NULL
    DROP PROCEDURE [dbo].[Tools_GetFormFullPathSp]
GO

CREATE PROCEDURE [dbo].[Tools_GetFormFullPathSp]
(
   @FormName   SYSNAME
) AS

DECLARE @ResultTable TABLE
(
   ObjectID     INT
 , ObjectName   SYSNAME
 , FullPath     NVARCHAR(1000)
)

DECLARE
   @ObjID      INT
 , @ObjName    SYSNAME
 , @FullPath   NVARCHAR(1000)

INSERT INTO @ResultTable(ObjectID, ObjectName, FullPath)
SELECT ObjectId, ObjectTextData, '' FROM ExplorerObjects
WHERE ObjectTextData = @FormName

DECLARE ret_cursor CURSOR FOR
SELECT ObjectID, ObjectName, FullPath
FROM @ResultTable

OPEN ret_cursor
WHILE 1 = 1
BEGIN
   FETCH ret_cursor INTO
         @ObjID
       , @ObjName
       , @FullPath

   IF @@FETCH_STATUS = -1
       BREAK

   EXEC dbo.Tools_GetNodeFullPathSp
        @NodeID       = @ObjID
      , @NodeFullPath = @FullPath OUTPUT

   UPDATE @ResultTable SET FullPath = @FullPath
   WHERE ObjectId = @ObjID
END
CLOSE ret_cursor
DEALLOCATE ret_cursor

SELECT * FROM @ResultTable

GO



IF OBJECT_ID('dbo.Tools_GetNodeFullPathSp') IS NOT NULL
    DROP PROCEDURE [dbo].[Tools_GetNodeFullPathSp]
GO

CREATE PROCEDURE [dbo].[Tools_GetNodeFullPathSp]
(
   @NodeID         INT
 , @NodeFullPath   NVARCHAR(1000)   OUTPUT
) AS

DECLARE
   @ParentNodeID      INT
 , @CurrentNodeText   NVARCHAR(1000)

SELECT
   @ParentNodeID    = ParentFolderId
 , @CurrentNodeText = ISNULL(ObjectTextData, ObjectName)
FROM ExplorerObjects
WHERE ObjectId = @NodeID

IF ISNULL(@CurrentNodeText, '') <> ''
BEGIN
   IF ISNULL(@NodeFullPath, '') <> ''
   BEGIN
      SET @NodeFullPath = ISNULL(@CurrentNodeText, '') + ' -> ' + ISNULL(@NodeFullPath, '')
   END
   ELSE
   BEGIN
      SET @NodeFullPath = ISNULL(@CurrentNodeText, '')
   END
END

IF @NodeID = -1
BEGIN
   RETURN 0
END
ELSE
BEGIN
   EXEC [dbo].[Tools_GetNodeFullPathSp]
        @NodeID   = @ParentNodeID
      , @NodeFullPath = @NodeFullPath OUTPUT
END

GO
