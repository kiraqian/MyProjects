DROP TABLE htmlpage
DROP TABLE jscode
DROP TABLE cscode

CREATE TABLE htmlpage
(
   pkey     NVARCHAR(100) PRIMARY KEY,
   content  NVARCHAR(MAX)
)

CREATE TABLE jscode
(
   pkey    NVARCHAR(100) PRIMARY KEY,
   content NVARCHAR(MAX)
)

CREATE TABLE cscode
(
   pkey    NVARCHAR(100) PRIMARY KEY,
   content NVARCHAR(MAX)
)