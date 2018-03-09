IF OBJECT_ID('[dbo].[Tools_Msg_GenColumnCaptionMsgSp]') IS NOT NULL
   DROP PROCEDURE Tools_Msg_GenColumnCaptionMsgSp
GO

CREATE PROCEDURE Tools_Msg_GenColumnCaptionMsgSp
(
   @TableOrViewName   NVARCHAR(100)
 , @DoCommit          INT = 0
) AS
BEGIN TRANSACTION

DECLARE @MsgObjTable TABLE
(
   MsgObj    NVARCHAR(1000)
)

DECLARE
   @ColumnName     NVARCHAR(1000)
 , @TableCaption   NVARCHAR(1000)
 , @ColumnCaption  NVARCHAR(1000)
 , @MsgObjName     NVARCHAR(1000)
 , @MsgNum         NVARCHAR(1000)

-- Add message for table/view
SET @MsgObjName = '@' + @TableOrViewName
INSERT INTO @MsgObjTable VALUES(@MsgObjName)
SET @TableCaption = REPLACE(@TableOrViewName,'_',' ')
SET @MsgNum = NULL

IF NOT EXISTS(SELECT 1 FROM ObjectMainMessages WHERE ObjectName = @MsgObjName)
BEGIN
   SELECT TOP 1 @MsgNum = MessageNo FROM
   (SELECT MessageNo, MessageText, 0 AS Priority FROM ApplicationMessages
   WHERE MessageText = @TableCaption AND MessageNo LIKE 'SL_%'
   UNION
   SELECT MessageNo, MessageText, 1 AS Priority FROM ApplicationMessages
   WHERE MessageText = @TableCaption AND MessageNo LIKE 'MG_%'
   UNION
   SELECT MessageNo, MessageText, 2 AS Priority FROM ApplicationMessages
   WHERE MessageText = @TableCaption
   UNION
   SELECT MessageNo, MessageText, 3 AS Priority FROM ApplicationMessages
   WHERE REPLACE(MessageText, ' ', '') = @TableCaption
   ) V
   ORDER BY Priority

   IF ISNULL(@MsgNum, '') <> ''
   BEGIN
      EXEC AddObjectMainMessage2Sp @MsgObjName, 5, @MsgNum, 16, N'Table label', 2, N'BaseSyteLine', 0
   END
   ELSE
   BEGIN
      SET @MsgNum = 'MG_1' -- Use "Reserved Message Placeholder" for message not found
      EXEC AddObjectMainMessage2Sp @MsgObjName, 5, @MsgNum, 16, N'Table label', 2, N'BaseSyteLine', 0
   END
END

-- Add message for columns
DECLARE ColCursor CURSOR LOCAL STATIC FOR
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableOrViewName

OPEN ColCursor

WHILE 1 = 1
BEGIN
   FETCH ColCursor INTO
         @ColumnName

   IF @@FETCH_STATUS <> 0
      BREAK

   IF ISNULL(@ColumnName, '') <> ''
   BEGIN
      SET @MsgObjName = '@' + @TableOrViewName + '.' + @ColumnName
      INSERT INTO @MsgObjTable VALUES(@MsgObjName)

      SET @ColumnCaption = REPLACE(@ColumnName,'_',' ')
      SET @MsgNum = NULL

      IF NOT EXISTS(SELECT 1 FROM ObjectMainMessages WHERE ObjectName = @MsgObjName)
      BEGIN
         SELECT TOP 1 @MsgNum = MessageNo FROM
         (SELECT MessageNo, MessageText, 0 AS Priority FROM ApplicationMessages
         WHERE MessageText = @ColumnCaption AND MessageNo LIKE 'SL_%'
         UNION
         SELECT MessageNo, MessageText, 1 AS Priority FROM ApplicationMessages
         WHERE MessageText = @ColumnCaption AND MessageNo LIKE 'MG_%'
         UNION
         SELECT MessageNo, MessageText, 2 AS Priority FROM ApplicationMessages
         WHERE MessageText = @ColumnCaption
         UNION
         SELECT MessageNo, MessageText, 3 AS Priority FROM ApplicationMessages
         WHERE REPLACE(MessageText, ' ', '') = @ColumnCaption
         ) V
         ORDER BY Priority

         IF ISNULL(@MsgNum, '') <> ''
         BEGIN
            EXEC AddObjectMainMessage2Sp @MsgObjName, 5, @MsgNum, 16, N'Column label', 2, N'BaseSyteLine', 0
         END
         ELSE
         BEGIN
            SET @MsgNum = 'MG_1' -- Use "Reserved Message Placeholder" for message not found
            EXEC AddObjectMainMessage2Sp @MsgObjName, 5, @MsgNum, 16, N'Column label', 2, N'BaseSyteLine', 0
         END
      END
   END
END
CLOSE ColCursor
DEALLOCATE ColCursor

SELECT omm.ObjectName, am.MessageNo, am.MessageText FROM ObjectMainMessages omm
LEFT JOIN ApplicationMessages am ON omm.MessageNo = am.MessageNo
WHERE omm.ObjectName IN (SELECT MsgObj FROM @MsgObjTable)

IF @DoCommit = 0
BEGIN
   ROLLBACK TRANSACTION
END
ELSE
BEGIN
   COMMIT TRANSACTION
END

GO
