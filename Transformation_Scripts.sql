--/*
TRUNCATE TABLE [dbo].[AS_STG_FUNDAMENTALS];

TRUNCATE TABLE [dbo].[AS_STG_PRICES_2016];

TRUNCATE TABLE [dbo].[AS_STG_PRICES_ADJUSTED_2016];

TRUNCATE TABLE [dbo].[AS_STG_SECURITIES];* /

SELECT *
FROM [dbo].[AS_STG_FUNDAMENTALS];

SELECT *
FROM [dbo].[AS_STG_PRICES_2016]
ORDER BY DATE DESC;

SELECT *
FROM [dbo].[AS_STG_PRICES_ADJUSTED_2016]
ORDER BY DATE DESC;

SELECT *
FROM [dbo].[AS_STG_SECURITIES];

/* Testing number of rows*/
SELECT 'AS_STG_FUNDAMENTALS' AS TAB
	,COUNT(*)
FROM [dbo].[AS_STG_FUNDAMENTALS]

UNION ALL

SELECT 'AS_STG_PRICES_2016' AS TAB
	,COUNT(*)
FROM [dbo].[AS_STG_PRICES_2016]

UNION ALL

SELECT 'AS_STG_PRICES_ADJUSTED_2016' AS TAB
	,COUNT(*)
FROM [dbo].[AS_STG_PRICES_ADJUSTED_2016]

UNION ALL

SELECT 'AS_STG_SECURITIES' AS TAB
	,COUNT(*)
FROM [dbo].[AS_STG_SECURITIES]

/* Detecting Primary Keys*/
SELECT [Ticker Symbol]
	,[Period Ending]
FROM AS_STG_FUNDAMENTALS
GROUP BY [Ticker Symbol]
	,[Period Ending]
HAVING COUNT(*) > 1;

SELECT [Ticker symbol]
FROM [AS_STG_SECURITIES]
GROUP BY [Ticker symbol]
HAVING COUNT(*) > 1;

SELECT symbol
	,DATE
FROM [AS_STG_PRICES_2016]
GROUP BY symbol
	,DATE
HAVING COUNT(*) > 1;

SELECT symbol
	,DATE
FROM [AS_STG_PRICES_ADJUSTED_2016]
GROUP BY symbol
	,DATE
HAVING COUNT(*) > 1;

/*Creating Function to find strange characters*/
CREATE OR ALTER FUNCTION [dbo].[AssessmentStrangeChar] (@string VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @AssessmentStrangeChar VARCHAR(8000);

	SET @AssessmentStrangeChar = @string
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(32), '[?]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(13), '[CR]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(10), '[LF]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(9), '[TAB]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(1), '[SOH]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(2), '[STX]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(3), '[ETX]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(4), '[EOT]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(5), '[ENQ]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(6), '[ACK]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(7), '[BEL]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(8), '[BS]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(11), '[VT]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(12), '[FF]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(14), '[SO]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(15), '[SI]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(16), '[DLE]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(17), '[DC1]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(18), '[DC2]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(19), '[DC3]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(20), '[DC4]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(21), '[NAK]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(22), '[SYN]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(23), '[ETB]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(24), '[CAN]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(25), '[EM]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(26), '[SUB]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(27), '[ESC]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(28), '[FS]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(29), '[GS]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(30), '[RS]')
	SET @AssessmentStrangeChar = REPLACE(@AssessmentStrangeChar, CHAR(31), '[US]')

	RETURN (@AssessmentStrangeChar)
END

/* DDL TABLES*/

DROP TABLE [dbo].[AS_FUNDAMENTALS];
CREATE TABLE [dbo].[AS_FUNDAMENTALS] (
	[Ticker Symbol] [nvarchar](50) NOT NULL
	,[Period Ending] [date] NOT NULL
	,[Accounts Payable] [decimal](18, 2) NULL
	,[Accounts Receivable] [decimal](18, 2) NULL
	,[Add''l income expense items] [decimal](18, 2) NULL
	,[After Tax ROE] [decimal](18, 2) NULL
	,[Capital Expenditures] [decimal](18, 2) NULL
	,[Capital Surplus] [decimal](18, 2) NULL
	,[Cash Ratio] [decimal](18, 2) NULL
	,[Cash and Cash Equivalents] [decimal](18, 2) NULL
	,[Changes in Inventories] [decimal](18, 2) NULL
	,[Common Stocks] [decimal](18, 2) NULL
	,[Cost of Revenue] [decimal](18, 2) NULL
	,[Current Ratio] [decimal](18, 2) NULL
	,[Deferred Asset Charges] [decimal](18, 2) NULL
	,[Deferred Liability Charges] [decimal](18, 2) NULL
	,[Depreciation] [decimal](18, 2) NULL
	,[Earnings Before Interest and Tax] [decimal](18, 2) NULL
	,[Earnings Before Tax] [decimal](18, 2) NULL
	,[Effect of Exchange Rate] [decimal](18, 2) NULL
	,[Equity Earnings Loss Unconsolidated Subsidiary] [decimal](18, 2) NULL
	,[Fixed Assets] [decimal](18, 2) NULL
	,[Goodwill] [decimal](18, 2) NULL
	,[Gross Margin] [decimal](18, 2) NULL
	,[Gross Profit] [decimal](18, 2) NULL
	,[Income Tax] [decimal](18, 2) NULL
	,[Intangible Assets] [decimal](18, 2) NULL
	,[Interest Expense] [decimal](18, 2) NULL
	,[Inventory] [decimal](18, 2) NULL
	,[Investments] [decimal](18, 2) NULL
	,[Liabilities] [decimal](18, 2) NULL
	,[Long-Term Debt] [decimal](18, 2) NULL
	,[Long-Term Investments] [decimal](18, 2) NULL
	,[Minority Interest] [decimal](18, 2) NULL
	,[Misc  Stocks] [decimal](18, 2) NULL
	,[Net Borrowings] [decimal](18, 2) NULL
	,[Net Cash Flow] [decimal](18, 2) NULL
	,[Net Cash Flow-Operating] [decimal](18, 2) NULL
	,[Net Cash Flows-Financing] [decimal](18, 2) NULL
	,[Net Cash Flows-Investing] [decimal](18, 2) NULL
	,[Net Income] [decimal](18, 2) NULL
	,[Net Income Adjustments] [decimal](18, 2) NULL
	,[Net Income Applicable to Common Shareholders] [decimal](18, 2) NULL
	,[Net Income-Cont  Operations] [decimal](18, 2) NULL
	,[Net Receivables] [decimal](18, 2) NULL
	,[Non-Recurring Items] [decimal](18, 2) NULL
	,[Operating Income] [decimal](18, 2) NULL
	,[Operating Margin] [decimal](18, 2) NULL
	,[Other Assets] [decimal](18, 2) NULL
	,[Other Current Assets] [decimal](18, 2) NULL
	,[Other Current Liabilities] [decimal](18, 2) NULL
	,[Other Equity] [decimal](18, 2) NULL
	,[Other Financing Activities] [decimal](18, 2) NULL
	,[Other Investing Activities] [decimal](18, 2) NULL
	,[Other Liabilities] [decimal](18, 2) NULL
	,[Other Operating Activities] [decimal](18, 2) NULL
	,[Other Operating Items] [decimal](18, 2) NULL
	,[Pre-Tax Margin] [decimal](18, 2) NULL
	,[Pre-Tax ROE] [decimal](18, 2) NULL
	,[Profit Margin] [decimal](18, 2) NULL
	,[Quick Ratio] [decimal](18, 2) NULL
	,[Research and Development] [decimal](18, 2) NULL
	,[Retained Earnings] [decimal](18, 2) NULL
	,[Sale and Purchase of Stock] [decimal](18, 2) NULL
	,[Sales] [decimal](18, 2) NULL
	,[General Admin] [decimal](18, 2) NULL
	,[Short-Term Debt Current Portion of Long-Term Debt] [decimal](18, 2) NULL
	,[Short-Term Investments] [decimal](18, 2) NULL
	,[Total Assets] [decimal](18, 2) NULL
	,[Total Current Assets] [decimal](18, 2) NULL
	,[Total Current Liabilities] [decimal](18, 2) NULL
	,[Total Equity] [decimal](18, 2) NULL
	,[Total Liabilities] [decimal](18, 2) NULL
	,[Total Liabilities & Equity] [decimal](18, 2) NULL
	,[Total Revenue] [decimal](18, 2) NULL
	,[Treasury Stock] [decimal](18, 2) NULL
	,[For Year] [decimal](18, 2) NULL
	,[Earnings Per Share] [decimal](18, 2) NULL
	,[Estimated Shares Outstanding] [decimal](18, 2) NULL
	,CONSTRAINT [PK_AS_FUNDAMENTALS] PRIMARY KEY CLUSTERED (
		[Ticker Symbol] ASC
		,[Period Ending] ASC
		) WITH (
		PAD_INDEX = OFF
		,STATISTICS_NORECOMPUTE = OFF
		,IGNORE_DUP_KEY = OFF
		,ALLOW_ROW_LOCKS = ON
		,ALLOW_PAGE_LOCKS = ON
		) ON [PRIMARY]
	) ON [PRIMARY];

DROP TABLE [dbo].[AS_TOTAL_PRICES_2016];
CREATE TABLE [dbo].[AS_TOTAL_PRICES_2016] (
	[Ticker Symbol] [Nvarchar](50) NOT NULL
	,[Date] [date] NOT NULL
	,[Open] [decimal](18, 2) NULL
	,[Open Adjusted] [decimal](18, 2) NULL
	,[Delta % Open] [decimal](18, 2) NULL
	,[Close] [decimal](18, 2) NULL
	,[Close Adjusted] [decimal](18, 2) NULL
	,[Delta % Close] [decimal](18, 2) NULL
	,[Low] [decimal](18, 2) NULL
	,[Low Adjusted] [decimal](18, 2) NULL
	,[Delta % Low] [decimal](18, 2) NULL
	,[High] [decimal](18, 2) NULL
	,[High Adjusted] [decimal](18, 2) NULL
	,[Delta % High] [decimal](18, 2) NULL
	,CONSTRAINT [PK_AS_TOTAL_PRICES_2016] PRIMARY KEY CLUSTERED (
		[Ticker Symbol] ASC
		,[Date] ASC
		) WITH (
		PAD_INDEX = OFF
		,STATISTICS_NORECOMPUTE = OFF
		,IGNORE_DUP_KEY = OFF
		,ALLOW_ROW_LOCKS = ON
		,ALLOW_PAGE_LOCKS = ON
		) ON [PRIMARY]
	) ON [PRIMARY]

DROP TABLE [dbo].[AS_SECURITIES];
CREATE TABLE [dbo].[AS_SECURITIES] (
	[Ticker Symbol] [Nvarchar](50) NOT NULL
	,[Security] [Nvarchar](50) NULL
	,[SEC filings] [Nvarchar](50) NULL
	,[GICS Sector] [Nvarchar](50) NULL
	,[GICS Sub Industry] [Nvarchar](50) NULL
	,[Address of Headquarters] [Nvarchar](50) NULL
	,[Date first added] [date] NULL
	,[CIK] [Nvarchar](50) NULL
	,CONSTRAINT [PK_AS_SECURITIES] PRIMARY KEY CLUSTERED ([Ticker Symbol] ASC) WITH (
		PAD_INDEX = OFF
		,STATISTICS_NORECOMPUTE = OFF
		,IGNORE_DUP_KEY = OFF
		,ALLOW_ROW_LOCKS = ON
		,ALLOW_PAGE_LOCKS = ON
		) ON [PRIMARY]
	) ON [PRIMARY]

/* Data Cleansing and Transformation*/
TRUNCATE TABLE [dbo].[AS_FUNDAMENTALS];

TRUNCATE TABLE [dbo].[AS_TOTAL_PRICES_2016];

TRUNCATE TABLE [dbo].[AS_SECURITIES];

INSERT INTO AS_FUNDAMENTALS
SELECT [Ticker Symbol]
	,CAST([Period Ending] AS DATE) AS [Period Ending]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Accounts Payable]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Accounts Payable]), 0, CHARINDEX('e+', [Accounts Payable]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Accounts Payable]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Accounts Payable]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Accounts Receivable]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Accounts Receivable]), 0, CHARINDEX('e+', [Accounts Receivable]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Accounts Receivable]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Accounts Receivable]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Add''l income expense items]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Add''l income expense items]), 0, CHARINDEX('e+', [Add''l income expense items]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Add''l income expense items]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Add''l income expense items]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([After Tax ROE]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([After Tax ROE]), 0, CHARINDEX('e+', [After Tax ROE]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([After Tax ROE]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [After Tax ROE]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Capital Expenditures]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Capital Expenditures]), 0, CHARINDEX('e+', [Capital Expenditures]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Capital Expenditures]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Capital Expenditures]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Capital Surplus]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Capital Surplus]), 0, CHARINDEX('e+', [Capital Surplus]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Capital Surplus]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Capital Surplus]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Cash Ratio]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Cash Ratio]), 0, CHARINDEX('e+', [Cash Ratio]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Cash Ratio]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Cash Ratio]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Cash and Cash Equivalents]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Cash and Cash Equivalents]), 0, CHARINDEX('e+', [Cash and Cash Equivalents]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Cash and Cash Equivalents]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Cash and Cash Equivalents]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Changes in Inventories]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Changes in Inventories]), 0, CHARINDEX('e+', [Changes in Inventories]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Changes in Inventories]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Changes in Inventories]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Common Stocks]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Common Stocks]), 0, CHARINDEX('e+', [Common Stocks]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Common Stocks]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Common Stocks]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Cost of Revenue]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Cost of Revenue]), 0, CHARINDEX('e+', [Cost of Revenue]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Cost of Revenue]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Cost of Revenue]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Current Ratio]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Current Ratio]), 0, CHARINDEX('e+', [Current Ratio]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Current Ratio]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Current Ratio]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Deferred Asset Charges]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Deferred Asset Charges]), 0, CHARINDEX('e+', [Deferred Asset Charges]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Deferred Asset Charges]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Deferred Asset Charges]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Deferred Liability Charges]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Deferred Liability Charges]), 0, CHARINDEX('e+', [Deferred Liability Charges]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Deferred Liability Charges]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Deferred Liability Charges]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Depreciation]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Depreciation]), 0, CHARINDEX('e+', [Depreciation]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Depreciation]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Depreciation]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Before Interest and Tax]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Earnings Before Interest and Tax]), 0, CHARINDEX('e+', [Earnings Before Interest and Tax]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Before Interest and Tax]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Earnings Before Interest and Tax]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Before Tax]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Earnings Before Tax]), 0, CHARINDEX('e+', [Earnings Before Tax]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Before Tax]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Earnings Before Tax]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Effect of Exchange Rate]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Effect of Exchange Rate]), 0, CHARINDEX('e+', [Effect of Exchange Rate]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Effect of Exchange Rate]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Effect of Exchange Rate]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Equity Earnings Loss Unconsolidated Subsidiary]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Equity Earnings Loss Unconsolidated Subsidiary]), 0, CHARINDEX('e+', [Equity Earnings Loss Unconsolidated Subsidiary]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Equity Earnings Loss Unconsolidated Subsidiary]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Equity Earnings Loss Unconsolidated Subsidiary]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Fixed Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Fixed Assets]), 0, CHARINDEX('e+', [Fixed Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Fixed Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Fixed Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Goodwill]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Goodwill]), 0, CHARINDEX('e+', [Goodwill]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Goodwill]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Goodwill]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Gross Margin]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Gross Margin]), 0, CHARINDEX('e+', [Gross Margin]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Gross Margin]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Gross Margin]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Gross Profit]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Gross Profit]), 0, CHARINDEX('e+', [Gross Profit]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Gross Profit]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Gross Profit]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Income Tax]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Income Tax]), 0, CHARINDEX('e+', [Income Tax]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Income Tax]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Income Tax]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Intangible Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Intangible Assets]), 0, CHARINDEX('e+', [Intangible Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Intangible Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Intangible Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Interest Expense]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Interest Expense]), 0, CHARINDEX('e+', [Interest Expense]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Interest Expense]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Interest Expense]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Inventory]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Inventory]), 0, CHARINDEX('e+', [Inventory]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Inventory]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Inventory]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Investments]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Investments]), 0, CHARINDEX('e+', [Investments]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Investments]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Investments]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Liabilities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Liabilities]), 0, CHARINDEX('e+', [Liabilities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Liabilities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Liabilities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Long-Term Debt]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Long-Term Debt]), 0, CHARINDEX('e+', [Long-Term Debt]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Long-Term Debt]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Long-Term Debt]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Long-Term Investments]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Long-Term Investments]), 0, CHARINDEX('e+', [Long-Term Investments]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Long-Term Investments]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Long-Term Investments]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Minority Interest]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Minority Interest]), 0, CHARINDEX('e+', [Minority Interest]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Minority Interest]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Minority Interest]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Misc  Stocks]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Misc  Stocks]), 0, CHARINDEX('e+', [Misc  Stocks]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Misc  Stocks]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Misc  Stocks]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Borrowings]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Borrowings]), 0, CHARINDEX('e+', [Net Borrowings]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Borrowings]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Borrowings]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flow]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Cash Flow]), 0, CHARINDEX('e+', [Net Cash Flow]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flow]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Cash Flow]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flow-Operating]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Cash Flow-Operating]), 0, CHARINDEX('e+', [Net Cash Flow-Operating]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flow-Operating]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Cash Flow-Operating]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flows-Financing]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Cash Flows-Financing]), 0, CHARINDEX('e+', [Net Cash Flows-Financing]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flows-Financing]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Cash Flows-Financing]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flows-Investing]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Cash Flows-Investing]), 0, CHARINDEX('e+', [Net Cash Flows-Investing]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Cash Flows-Investing]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Cash Flows-Investing]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Income]), 0, CHARINDEX('e+', [Net Income]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Income]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income Adjustments]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Income Adjustments]), 0, CHARINDEX('e+', [Net Income Adjustments]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income Adjustments]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Income Adjustments]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income Applicable to Common Shareholders]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Income Applicable to Common Shareholders]), 0, CHARINDEX('e+', [Net Income Applicable to Common Shareholders]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income Applicable to Common Shareholders]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Income Applicable to Common Shareholders]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income-Cont  Operations]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Income-Cont  Operations]), 0, CHARINDEX('e+', [Net Income-Cont  Operations]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Income-Cont  Operations]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Income-Cont  Operations]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Receivables]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Net Receivables]), 0, CHARINDEX('e+', [Net Receivables]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Net Receivables]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Net Receivables]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Non-Recurring Items]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Non-Recurring Items]), 0, CHARINDEX('e+', [Non-Recurring Items]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Non-Recurring Items]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Non-Recurring Items]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Operating Income]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Operating Income]), 0, CHARINDEX('e+', [Operating Income]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Operating Income]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Operating Income]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Operating Margin]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Operating Margin]), 0, CHARINDEX('e+', [Operating Margin]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Operating Margin]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Operating Margin]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Assets]), 0, CHARINDEX('e+', [Other Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Current Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Current Assets]), 0, CHARINDEX('e+', [Other Current Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Current Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Current Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Current Liabilities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Current Liabilities]), 0, CHARINDEX('e+', [Other Current Liabilities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Current Liabilities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Current Liabilities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Equity]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Equity]), 0, CHARINDEX('e+', [Other Equity]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Equity]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Equity]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Financing Activities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Financing Activities]), 0, CHARINDEX('e+', [Other Financing Activities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Financing Activities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Financing Activities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Investing Activities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Investing Activities]), 0, CHARINDEX('e+', [Other Investing Activities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Investing Activities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Investing Activities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Liabilities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Liabilities]), 0, CHARINDEX('e+', [Other Liabilities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Liabilities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Liabilities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Operating Activities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Operating Activities]), 0, CHARINDEX('e+', [Other Operating Activities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Operating Activities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Operating Activities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Operating Items]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Other Operating Items]), 0, CHARINDEX('e+', [Other Operating Items]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Other Operating Items]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Other Operating Items]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Pre-Tax Margin]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Pre-Tax Margin]), 0, CHARINDEX('e+', [Pre-Tax Margin]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Pre-Tax Margin]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Pre-Tax Margin]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Pre-Tax ROE]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Pre-Tax ROE]), 0, CHARINDEX('e+', [Pre-Tax ROE]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Pre-Tax ROE]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Pre-Tax ROE]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Profit Margin]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Profit Margin]), 0, CHARINDEX('e+', [Profit Margin]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Profit Margin]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Profit Margin]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Quick Ratio]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Quick Ratio]), 0, CHARINDEX('e+', [Quick Ratio]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Quick Ratio]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Quick Ratio]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Research and Development]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Research and Development]), 0, CHARINDEX('e+', [Research and Development]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Research and Development]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Research and Development]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Retained Earnings]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Retained Earnings]), 0, CHARINDEX('e+', [Retained Earnings]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Retained Earnings]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Retained Earnings]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Sale and Purchase of Stock]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Sale and Purchase of Stock]), 0, CHARINDEX('e+', [Sale and Purchase of Stock]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Sale and Purchase of Stock]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Sale and Purchase of Stock]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Sales]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Sales]), 0, CHARINDEX('e+', [Sales]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Sales]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Sales]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([General Admin]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([General Admin]), 0, CHARINDEX('e+', [General Admin]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([General Admin]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [General Admin]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Short-Term Debt Current Portion of Long-Term Debt]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Short-Term Debt Current Portion of Long-Term Debt]), 0, CHARINDEX('e+', [Short-Term Debt Current Portion of Long-Term Debt]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Short-Term Debt Current Portion of Long-Term Debt]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Short-Term Debt Current Portion of Long-Term Debt]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Short-Term Investments]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Short-Term Investments]), 0, CHARINDEX('e+', [Short-Term Investments]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Short-Term Investments]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Short-Term Investments]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Assets]), 0, CHARINDEX('e+', [Total Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Current Assets]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Current Assets]), 0, CHARINDEX('e+', [Total Current Assets]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Current Assets]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Current Assets]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Current Liabilities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Current Liabilities]), 0, CHARINDEX('e+', [Total Current Liabilities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Current Liabilities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Current Liabilities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Equity]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Equity]), 0, CHARINDEX('e+', [Total Equity]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Equity]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Equity]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Liabilities]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Liabilities]), 0, CHARINDEX('e+', [Total Liabilities]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Liabilities]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Liabilities]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Liabilities & Equity]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Liabilities & Equity]), 0, CHARINDEX('e+', [Total Liabilities & Equity]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Liabilities & Equity]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Liabilities & Equity]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Revenue]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Total Revenue]), 0, CHARINDEX('e+', [Total Revenue]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Total Revenue]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Total Revenue]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Treasury Stock]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Treasury Stock]), 0, CHARINDEX('e+', [Treasury Stock]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Treasury Stock]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Treasury Stock]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([For Year]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([For Year]), 0, CHARINDEX('e+', [For Year]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([For Year]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [For Year]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Per Share]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Earnings Per Share]), 0, CHARINDEX('e+', [Earnings Per Share]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Earnings Per Share]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Earnings Per Share]
	,CAST(NULLIF(TRIM(CASE 
					WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([Estimated Shares Outstanding]), '[CR]', '')) LIKE '%.%+%'
						THEN SUBSTRING(TRIM([Estimated Shares Outstanding]), 0, CHARINDEX('e+', [Estimated Shares Outstanding]))
					ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([Estimated Shares Outstanding]), '[CR]', ''))
					END), '') AS DECIMAL(18, 2)) AS [Estimated Shares Outstanding]
FROM AS_STG_FUNDAMENTALS;

INSERT INTO AS_TOTAL_PRICES_2016
SELECT A.[Ticker Symbol]
	,A.[Date]
	,A.[Open]
	,P.[Open] AS [Open Adjusted]
	,CAST(((A.[Open] - P.[Open]) / A.[Open]) * 100.0 AS DECIMAL(18, 2)) AS [Delta % Open]
	,A.[Close]
	,P.[Close] AS [Close Adjusted]
	,CAST(((A.[Close] - P.[Close]) / A.[Close]) * 100.0 AS DECIMAL(18, 2)) AS [Delta % Close]
	,A.[Low]
	,P.[Low] AS [Low Adjusted]
	,CAST(((A.[Low] - P.[Low]) / A.[Low]) * 100.0 AS DECIMAL(18, 2)) AS [Delta % Low]
	,A.[High]
	,P.[High] AS [High Adjusted]
	,CAST(((A.[High] - P.[High]) / A.[High]) * 100.0 AS DECIMAL(18, 2)) AS [Delta % High]
FROM (
	SELECT CAST([date] AS DATE) AS [Date]
		,[symbol] AS [Ticker Symbol]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([open]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([open]), 0, CHARINDEX('e+', [open]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([open]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Open]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([close]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([close]), 0, CHARINDEX('e+', [close]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([close]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Close]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([low]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([low]), 0, CHARINDEX('e+', [low]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([low]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Low]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([high]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([high]), 0, CHARINDEX('e+', [high]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([high]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [High]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([volume]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([volume]), 0, CHARINDEX('e+', [volume]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([volume]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Volume]
	FROM [dbo].[AS_STG_PRICES_2016]
	) P
LEFT OUTER JOIN (
	SELECT CAST([date] AS DATE) AS [Date]
		,[symbol] AS [Ticker Symbol]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([open]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([open]), 0, CHARINDEX('e+', [open]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([open]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Open]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([close]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([close]), 0, CHARINDEX('e+', [close]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([close]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Close]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([low]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([low]), 0, CHARINDEX('e+', [low]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([low]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Low]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([high]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([high]), 0, CHARINDEX('e+', [high]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([high]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [High]
		,CAST(NULLIF(TRIM(CASE 
						WHEN TRIM(REPLACE(dbo.AssessmentStrangeChar([volume]), '[CR]', '')) LIKE '%.%+%'
							THEN SUBSTRING(TRIM([volume]), 0, CHARINDEX('e+', [volume]))
						ELSE TRIM(REPLACE(dbo.AssessmentStrangeChar([volume]), '[CR]', ''))
						END), '') AS DECIMAL(18, 2)) AS [Volume]
	FROM [dbo].[AS_STG_PRICES_ADJUSTED_2016]
	) A ON P.[Ticker Symbol] = A.[Ticker Symbol]
	AND A.[Date] = P.[Date]

INSERT INTO AS_SECURITIES
SELECT [Ticker symbol] AS [Ticker Symbol]
	,[Security]
	,[SEC filings]
	,[GICS Sector]
	,[GICS Sub Industry]
	,[Address of Headquarters]
	,CAST([Date first added] AS DATE) AS [Date first added]
	,[CIK]
FROM [dbo].[AS_STG_SECURITIES];


/*Volatily Year Month*/
SELECT Year(Date) AS Years
	,A.[Ticker Symbol]
	,Month(Date) AS Months
	,CAST(SUM(abs(A.High - B.High)) / C.CONT AS DECIMAL(18, 2)) AS DEV
FROM [AS_TOTAL_PRICES_2016] A
LEFT JOIN (
	SELECT [Ticker Symbol]
		,Year(Date) AS Years
		,Month(Date) AS Months
		,AVG(High) AS High
	FROM [AS_TOTAL_PRICES_2016]
	GROUP BY Year(Date)
		,Month(Date)
		,[Ticker Symbol]
	) B ON A.[Ticker Symbol] = B.[Ticker Symbol]
	AND Year(A.Date) = B.Years
	AND month(A.Date) = B.Months
LEFT JOIN (
	SELECT [Ticker Symbol]
		,Year(Date) AS Years
		,Month(Date) AS Months
		,COUNT(*) AS CONT
	FROM [AS_TOTAL_PRICES_2016]
	GROUP BY [Ticker Symbol]
		,Year(Date)
		,Month(Date)
	) C ON A.[Ticker Symbol] = C.[Ticker Symbol]
	AND Year(A.Date) = C.Years
	AND month(A.Date) = C.Months
GROUP BY A.[Ticker Symbol]
	,Month(Date)
	,C.CONT
	,Year(Date)
ORDER BY A.[Ticker Symbol]
	,Month(Date)