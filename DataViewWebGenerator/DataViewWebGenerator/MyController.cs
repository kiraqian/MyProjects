using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Utility.SqlUtil;
using Utility.XmlUtil;
using Utility.FileUtil;
using System.Data;
using System.IO;

namespace DataViewWebGenerator
{
    public class MyController
    {
        public static string connectionString = "";

        public static void BuildConnectionString(string serverName, string dbName, string userName, string password, bool useWinAuth)
        {
            connectionString = SqlUtility.CreateConnectionString(serverName, dbName, userName, password, useWinAuth);
        }

        public static DataTable LoadDataView(string selectionCommand, out string errMsg)
        {
            return SqlUtility.QueryDBData(connectionString, selectionCommand, out errMsg);
        }

        public static void PreGenerateRun(string dataViewName)
        {
            string errMsg = "";
            List<NameValuePair> parmList = new List<NameValuePair>();
            parmList.Add(new NameValuePair("DataViewName", dataViewName));
            parmList.Add(new NameValuePair("CommitOrNot", 1));
            SqlUtility.ExecuteStoredProcedure(connectionString, "Tools_AddPermissionGroupForDataView", parmList, out errMsg);
        }

        public static string GenerateScript(string templateFolder, string dataViewName)
        {
            templateFolder = templateFolder.TrimEnd(new char[] { '\\' }) + "\\";
            string dataViewRowTemplate = File.ReadAllText(templateFolder + @"DataViewRowTemplate.sql");
            string dataViewIDORowTemplate = File.ReadAllText(templateFolder + @"DataViewIDORowTemplate.sql");
            string dataViewParameterRowTemplate = File.ReadAllText(templateFolder + @"DataViewParameterRowTemplate.sql");
            string dataViewColumnRowTemplate = File.ReadAllText(templateFolder + @"DataViewColumnRowTemplate.sql");
            string dataViewLayoutRowTemplate = File.ReadAllText(templateFolder + @"DataViewLayoutRowTemplate.sql");
            string dataViewGroupRowTemplate = File.ReadAllText(templateFolder + @"DataViewGroupRowTemplate.sql");

            string dataViewSelectionCommand = @"SELECT * FROM WBDataView WHERE ViewName = '" + dataViewName + "' AND IsSystemRecord = 1";
            string dataViewIDOSelectionCommand = @"SELECT * FROM WBDataViewIDO WHERE ViewName = '" + dataViewName + "' AND IsSystemRecord = 1";
            string dataViewParameterSelectionCommand = @"SELECT * FROM WBDataViewParameter WHERE ViewName = '" + dataViewName + "'";
            string dataViewColumnSelectionCommand = @"SELECT * FROM WBDataViewColumn WHERE ViewName = '" + dataViewName + "' AND IsSystemRecord = 1";
            string dataViewLayoutSelectionCommand = @"SELECT * FROM WBDataViewLayout WHERE SourceName = '" + dataViewName + "' AND ScopeType = 0";
            string dataViewGroupSelectionCommand = @"SELECT * FROM WBDataViewGroup WHERE ViewName = '" + dataViewName + "'";

            string fileHeader_Init = File.ReadAllText(templateFolder + "InitHeader.sql");
            string fileHeader_Upgrade = File.ReadAllText(templateFolder + "UpgradeHeader.sql");

            string fileFooter_Init = File.ReadAllText(templateFolder + "InitFooter.sql");
            string fileFooter_Upgrade = File.ReadAllText(templateFolder + "UpgradeFooter.sql");

            string errMsg = "";

            //FileUtility.CreateFolder(templateFolder + "\\Init");
            //FileUtility.CreateFolder(templateFolder + "\\DataPatch");

            string saveInitFileName = templateFolder + "\\Init\\Rpt_" + dataViewName.Replace(" ", "") + ".sql";
            string saveUpgradeFileName = templateFolder + "\\DataPatch\\Rpt_" + dataViewName.Replace(" ", "") + ".sql";

            string initFileHeader = fileHeader_Init;
            string upgradeFileHeader = fileHeader_Upgrade.Replace("[###DataViewName###]", dataViewName);
            string initFileFooter = fileFooter_Init;
            string upgradeFileFooter = fileFooter_Upgrade.Replace("[###DataViewName###]", dataViewName); ;

            string fileContent = "";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewSelectionCommand, dataViewRowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewIDOSelectionCommand, dataViewIDORowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewColumnSelectionCommand, dataViewColumnRowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewParameterSelectionCommand, dataViewParameterRowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewGroupSelectionCommand, dataViewGroupRowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";
            fileContent += SqlUtility.GenerateSQLScript(connectionString, dataViewLayoutSelectionCommand, dataViewLayoutRowTemplate, "[###", "###]", out errMsg);
            fileContent += "\r\n";

            string initFileContent = initFileHeader + fileContent + initFileFooter;
            //File.WriteAllText(saveInitFileName, initFileContent);

            string upgradeFileContent = upgradeFileHeader + fileContent + upgradeFileFooter;
            //File.WriteAllText(saveUpgradeFileName, upgradeFileContent);

            return upgradeFileContent;
        }

        public static DataTable GetDBList(string serverName, string userName, string password, bool useWinAuthentication)
        {
            return SqlUtility.GetDatabaseNameList(serverName, userName, password, useWinAuthentication);
        }

        public static void LoadSettings(string settingFileName, out string serverName, out string DBName,
                                        out string userName, out string password, out string folderPath)
        {
            serverName = string.Empty;
            DBName = string.Empty;
            userName = string.Empty;
            password = string.Empty;
            folderPath = string.Empty;

            serverName = XmlUtility.ReadNodeValue(settingFileName, @"/Config/DBServer");
            DBName = XmlUtility.ReadNodeValue(settingFileName, @"/Config/DBName");
            userName = XmlUtility.ReadNodeValue(settingFileName, @"/Config/UserName");
            password = XmlUtility.ReadNodeValue(settingFileName, @"/Config/Password");
            //folderPath = XmlUtility.ReadNodeValue(settingFileName, @"/Config/FolderPath");
        }

        public static void SaveSettings(string settingFileName, string serverName, string DBName,
                                        string userName, string password, string folderPath)
        {
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/DBServer", serverName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/DBName", DBName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/UserName", userName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/Password", password);
            //XmlUtility.WriteNodeValue(settingFileName, @"/Config/FolderPath", folderPath);
        }
    }
}