IF NOT EXISTS (SELECT 1 FROM dbo.WBDataView WHERE ViewName = N'[###ViewName###]')
INSERT INTO dbo.WBDataView (
   ViewName,
   ReportOrientation,
   IsSystemRecord,
   DisplayReportHeader,
   DisplayPageHeaderFooter,
   RepeatHeadersNewPage,
   RepeatHeadersCollectionChange,
   InsertPageBreakGroup,
   ResetPageNumGroup,
   CanGrow,
   CriteriaForm
) VALUES (
   N'[###ViewName###]',--ViewName
   N'[###ReportOrientation###]',--ReportOrientation
   1,--IsSystemRecord
   [###DisplayReportHeader###],--DisplayReportHeader
   [###DisplayPageHeaderFooter###],--DisplayPageHeaderFooter
   [###RepeatHeadersNewPage###],--RepeatHeadersNewPage
   [###RepeatHeadersCollectionChange###],--RepeatHeadersCollectionChange
   [###InsertPageBreakGroup###],--InsertPageBreakGroup
   [###ResetPageNumGroup###],--ResetPageNumGroup
   [###CanGrow###],--CanGrow
   N'[###CriteriaForm###]' --CriteriaForm
)
ELSE
UPDATE dbo.WBDataView
SET CriteriaForm = N'[###CriteriaForm###]'
WHERE ViewName = N'[###ViewName###]'
AND IsSystemRecord = 1

