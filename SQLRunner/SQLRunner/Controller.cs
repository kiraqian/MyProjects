using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Utility.SqlUtil;
using Utility.StringUtil;
using Utility.FileUtil;
using Utility.XmlUtil;

namespace SQLRunner.Ctrl
{
    public class Controller
    {
        public static string DBConnectionString;

        public static void BuildDBConnectionString(string serverName, string dbName, string userName, string password)
        {
            DBConnectionString = SqlUtility.CreateConnectionString(serverName, dbName, userName, password);
        }

        public static bool TestConnection(string server, string dbName, string userName, string password, out string errMsg)
        {
            errMsg = "";
            return SqlUtility.TestConnect(SqlUtility.CreateConnectionString(server, dbName, userName, password), out errMsg);
        }

        public static void LoadFiles(string pach, DataTable dtFiles)
        {
            string[] fileNames = FileUtility.GetFileList(pach, "*.*", true);
            foreach (string file in fileNames)
            {
                dtFiles.Rows.Add(file);
            }
        }

        public static bool RunScript(string fileName, string fileContent, out string errMsg)
        {
            errMsg = "";
            List<string> sqlScriptList = SqlUtility.BreakSqlScriptIntoListString(StringUtility.TextToLinesString(fileContent));

            return SqlUtility.ExecuteSqlScript(DBConnectionString, sqlScriptList, out errMsg);
        }

        public static List<string> GetDBNameList(string server, string userName, string password)
        {
            List<string> nameList = new List<string>();
            DataTable dt = SqlUtility.GetDatabaseNameList(server, userName, password);
            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    nameList.Add(dr["database_name"].ToString());
                }
            }

            return nameList;
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
            folderPath = XmlUtility.ReadNodeValue(settingFileName, @"/Config/FolderPath");
        }

        public static void SaveSettings(string settingFileName, string serverName, string DBName,
                                        string userName, string password, string folderPath)
        {
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/DBServer", serverName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/DBName", DBName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/UserName", userName);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/Password", password);
            XmlUtility.WriteNodeValue(settingFileName, @"/Config/FolderPath", folderPath);
        }
    }
}
