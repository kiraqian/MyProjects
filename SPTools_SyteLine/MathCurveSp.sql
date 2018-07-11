IF OBJECT_ID('dbo.MathCurveSp') IS NOT NULL
   DROP PROCEDURE dbo.MathCurveSp
GO

CREATE PROCEDURE dbo.MathCurveSp
(
   @DefFrom         DECIMAL(30, 10)
 , @DefTo           DECIMAL(30, 10)
 , @FunExpression   NVARCHAR(4000)
 , @StepLength      DECIMAL(10, 5) = 0.1
) AS

DECLARE
   @SQLExecText     NVARCHAR(4000)
 , @Y               DECIMAL(30, 10)
 , @CurrentVal      DECIMAL(30, 10)

DECLARE @Results AS TABLE
(
   X   DECIMAL(30, 10)
 , Y   DECIMAL(30, 10)
)

SET @FunExpression = REPLACE(@FunExpression, '%', '*')

SET @CurrentVal = @DefFrom
WHILE @CurrentVal < @DefTo
BEGIN
   SET @SQLExecText = 'SET @YVal = ' + REPLACE(@FunExpression, 'X', @CurrentVal)
   EXEC sp_executesql @SQLExecText
                    , N'@YVal DECIMAL(30, 10) OUTPUT'
                    , @YVal = @Y OUTPUT

   INSERT INTO @Results(X, Y) VALUES(@CurrentVal, @Y)
   SET @CurrentVal = @CurrentVal + @StepLength
END

SELECT * FROM @Results

GO
