using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace Utility.SqlUtil
{
    public class SqlUtility
    {
        #region CreateConnectionString
        public static string CreateConnectionString(string serverName, string dbName, string userName, string password, bool useWinAuthentication = false)
        {
            string connStr = "";
            if(!useWinAuthentication)
            {
                connStr = @"Server={0};Database={1};User Id={2};Password={3}";
            }
            else
            {
                connStr = @"Server={0};Database={1};Trusted_Connection=True;";
            }
            
            return string.Format(connStr, serverName, dbName, userName, password);
        }
        #endregion

        #region GetDatabaseNameList
        public static DataTable GetDatabaseNameList(string serverName, string userName, string password, bool useWinAuthentication = false)
        {
            DataTable dt = null;
            string connStr = "";
            if(!useWinAuthentication)
            {
                connStr = @"Data Source={0};User Id={1};Password={2}";
            }
            else
            {
                connStr = @"Data Source={0};Trusted_Connection=True;";
            }
            
            connStr = string.Format(connStr, serverName, userName, password);
            SqlConnection sqlConn = new SqlConnection(connStr);
            try
            {
                sqlConn.Open();
                dt = sqlConn.GetSchema("Databases");
            }
            catch (Exception exp)
            {
                dt = null;
            }

            sqlConn.Close();

            return dt;
        }
        #endregion

        #region TestConnect
        public static bool TestConnect(string connString, out string errMsg)
        {
            bool success = false;
            errMsg = "";
            SqlConnection sqlConn = new SqlConnection(connString);
            try
            {
                sqlConn.Open();
                success = true;
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
                success = false;
            }

            sqlConn.Close();

            return success;
        }
        #endregion

        #region ExecuteSqlScript
        public static bool ExecuteSqlScript(string connString, string sqlScriptText, out string errMsg)
        {
            bool success = false;
            errMsg = "";

            SqlConnection sqlConn = new SqlConnection(connString);
            SqlCommand sqlComm = new SqlCommand(sqlScriptText, sqlConn);

            try
            {
                sqlConn.Open();
                sqlComm.ExecuteNonQuery();
                success = true;
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
                success = false;
            }

            sqlConn.Close();

            return success;
        }
        #endregion

        #region ExecuteSqlScript
        public static bool ExecuteSqlScript(string connString, List<string> sqlScriptTextList, out string errMsg)
        {
            bool success = false;
            errMsg = "";

            SqlConnection sqlConn = new SqlConnection(connString);
            SqlCommand sqlComm = new SqlCommand("", sqlConn);

            try
            {
                sqlConn.Open();

                foreach (string cmdText in sqlScriptTextList)
                {
                    if (cmdText.Trim() != string.Empty)
                    {
                        sqlComm.CommandText = cmdText.Trim();
                        sqlComm.ExecuteNonQuery();
                    }
                }

                success = true;
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
                success = false;
            }

            sqlConn.Close();

            return success;
        }
        #endregion

        #region ExecuteStoredProcedure
        public static bool ExecuteStoredProcedure(string connString, string spName, List<NameValuePair> nameValueList, out string errMsg)
        {
            bool success = false;
            errMsg = "";

            SqlConnection sqlConn = new SqlConnection(connString);
            SqlCommand sqlComm = new SqlCommand(spName, sqlConn);
            sqlComm.CommandType = CommandType.StoredProcedure;
            foreach (NameValuePair parmItem in nameValueList)
            {
                sqlComm.Parameters.Add(new SqlParameter(parmItem.Name, parmItem.Value));
            }

            try
            {
                sqlConn.Open();
                sqlComm.ExecuteNonQuery();
                success = true;
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
                success = false;
            }

            sqlConn.Close();

            return success;
        }
        #endregion

        #region QueryDBData
        public static DataTable QueryDBData(string connString, string selectionCommand, out string errMsg)
        {
            errMsg = "";

            SqlConnection sqlConn = new SqlConnection(connString);
            SqlDataAdapter sqlDa = new SqlDataAdapter(selectionCommand, sqlConn);
            DataTable dtTableData = new DataTable();

            try
            {
                sqlConn.Open();
                sqlDa.Fill(dtTableData);
                sqlConn.Close();
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
            }

            return dtTableData;
        }
        #endregion

        #region GetSPParameterList
        public static DataTable GetSPParameterList(string connString, string spName, out string errMsg)
        {
            errMsg = "";
            DataTable dtResult = new DataTable();
            string selectCmd = @"SELECT PARAMETER_NAME AS name, PARAMETER_MODE AS mode, ORDINAL_POSITION AS position ";
            selectCmd += @"FROM information_schema.parameters WHERE specific_name = '{0}' ORDER BY ORDINAL_POSITION";
            SqlConnection sqlConn = new SqlConnection(connString);
            SqlDataAdapter sqlDA = new SqlDataAdapter(string.Format(selectCmd, spName), sqlConn);
            try
            {
                sqlConn.Open();
                sqlDA.Fill(dtResult);
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
            }

            sqlConn.Close();

            return dtResult;
        }
        #endregion

        #region BreakSqlScriptIntoListString
        public static List<string> BreakSqlScriptIntoListString(string[] linesString)
        {
            List<string> listString = new List<string>();
            string textBlock = "";
            foreach (string s in linesString)
            {
                if (s.Trim().ToUpper() == "GO")
                {
                    listString.Add(textBlock);
                    textBlock = "";
                }
                else
                {
                    textBlock += s;
                    textBlock += "\r\n";
                }
            }

            if (textBlock.Trim() != string.Empty)
            {
                listString.Add(textBlock);
            }

            return listString;
        }
        #endregion

        #region GenerateSQLScript
        public static string GenerateSQLScript(string connString, string selectionCommand, string scriptTemplate,
                                               string replacePrefix, string replaceSuffix, out string errMsg)
        {
            errMsg = "";
            string retStr = "";
            string rowStr = scriptTemplate;

            DataTable dtTableData = QueryDBData(connString, selectionCommand, out errMsg);

            if (errMsg.Trim() != string.Empty)
            {
                return retStr;
            }

            try
            {
                for (int i = 0; i < dtTableData.Rows.Count; i++)
                {
                    for (int j = 0; j < dtTableData.Columns.Count; j++)
                    {
                        string columnName = dtTableData.Columns[j].ColumnName;
                        string cellVal = dtTableData.Rows[i][j].ToString();
                        if (Convert.IsDBNull(dtTableData.Rows[i][j]))
                        {
                            cellVal = "NULL";
                            rowStr = rowStr.Replace("N'" + replacePrefix + columnName + replaceSuffix + "'", cellVal);
                            rowStr = rowStr.Replace("'" + replacePrefix + columnName + replaceSuffix + "'", cellVal);
                            rowStr = rowStr.Replace(replacePrefix + columnName + replaceSuffix, cellVal);
                        }
                        else
                        {
                            cellVal = cellVal.Replace("'", "''");
                            rowStr = rowStr.Replace(replacePrefix + columnName + replaceSuffix, cellVal);
                        }
                    }

                    retStr += rowStr;
                    rowStr = scriptTemplate;
                }
            }
            catch (Exception exp)
            {
                errMsg = exp.Message;
            }

            return retStr;
        }
        #endregion

        #region GetPlainSQLText
        public static string GetPlainSQLText(string connString, string sqlObjectName, int deepth, out string errMsg)
        {
            string retText = "";
            List<string> spFunNameList = GetAllSPAndFunNameInDB(connString, out errMsg);
            List<string> visitedNodeList = new List<string>();
            List<string> sqlTextInLine = GetPlainSQLTextInLine(connString, sqlObjectName, spFunNameList, 
                                                               visitedNodeList, 1, deepth, out errMsg);
            foreach(string strLine in sqlTextInLine)
            {
                retText += strLine.TrimEnd().Replace(" ", "&ensp;").Replace("<p&ensp;id=", "<p id=");
                retText += "</br>";
            }

            return retText;
        }
        #endregion

        #region GetPlainSQLTextInLine
        private static List<string> GetPlainSQLTextInLine(string connString, string sqlObjectName, List<string> spFunNameList, 
                                                         List<string> visitedNodeList, int currLevel, int deepth, out string errMsg)
        {
            errMsg = "";
            if (currLevel > deepth)
            {
                List<string> retLine = new List<string>();                
                return retLine;
            }

            List<string> sqlTextInLine = GetSQLCodeByObjectName(connString, sqlObjectName, out errMsg);
            sqlTextInLine.Insert(0, "<details><summary>Start Of {" + sqlObjectName + "}</summary><p id=\"" + sqlObjectName + "\">");
            sqlTextInLine.Add("</p><summary>End Of {" + sqlObjectName + "}</summary></details>");
            for (int i = 0; i < sqlTextInLine.Count; i++)
            {
                string lineText = sqlTextInLine[i];
                string spOrFunName = GetSPFunNameInLineText(lineText, spFunNameList);
                if (spOrFunName != string.Empty &&
                    spOrFunName.ToLower() != sqlObjectName.ToLower() &&
                    !visitedNodeList.Contains(spOrFunName))
                {
                    //visitedNodeList.Add(spOrFunName);
                    List<string> subSQLCode = GetPlainSQLTextInLine(connString, spOrFunName, spFunNameList, visitedNodeList, currLevel + 1, deepth, out errMsg);                    
                    while(i < sqlTextInLine.Count && sqlTextInLine[i].Trim() != string.Empty)
                    {
                        // Move to the first blank line to insert sub code.
                        i++;
                    }
                    sqlTextInLine.InsertRange(i, subSQLCode);                    
                    i += subSQLCode.Count;
                }
            }

            return sqlTextInLine;
        }
        #endregion

        #region GetSQLCodeByObjectName
        private static List<string> GetSQLCodeByObjectName(string connString, string objName, out string errMsg)
        {
            List<string> codeLines = new List<string>();
            string commText = @"sp_helptext '" + objName + "'";
            DataTable dt = QueryDBData(connString, commText, out errMsg);
            foreach (DataRow dr in dt.Rows)
            {
                codeLines.Add(dr[0].ToString());
            }
            
            return GetSPBodyText(codeLines, objName);
        }
        #endregion

        #region GetSPFunNameInLineText
        private static string GetSPFunNameInLineText(string sqlText, List<string> spFunNameList)
        {
            string spOrFunName = FindListItemInText(sqlText, spFunNameList);
            return spOrFunName;
        }
        #endregion

        #region FindListItemInText
        private static string FindListItemInText(string lineText, List<string> itemList)
        {
            string itemFound = "";
            
            string[] textInBlock = lineText.Split(new char[] { ' ', '(', ')' , '.', '[', ']', '=' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (string item in textInBlock)
            {
                if (itemList.Contains(item.Trim().ToLower()))
                {
                    itemFound = item.Trim();
                    break;
                }
            }
            return itemFound;
        }
        #endregion

        #region GetAllSPAndFunNameInDB
        public static List<string> GetAllSPAndFunNameInDB(string connString, out string errMsg)
        {
            List<string> spFunList = new List<string>();            
            string commText = @"SELECT LOWER(name) AS name FROM dbo.sysobjects WHERE type IN ('P', 'FN')";
            DataTable dt = QueryDBData(connString, commText, out errMsg);
            foreach (DataRow dr in dt.Rows)
            {
                spFunList.Add(dr[0].ToString());
            }
            return spFunList;
        }
        #endregion

        #region GetAllViewInDB
        public static List<string> GetAllViewInDB(string connString, out string errMsg)
        {
            List<string> viewList = new List<string>();
            string commText = @"SELECT LOWER(name) AS name FROM dbo.sysobjects WHERE type IN ('V ')";
            DataTable dt = QueryDBData(connString, commText, out errMsg);
            foreach (DataRow dr in dt.Rows)
            {
                viewList.Add(dr[0].ToString());
            }
            return viewList;
        }
        #endregion

        #region GetSPBodyText
        private static List<string> GetSPBodyText(List<string> sqlText, string objName)
        {
            List<string> retList = new List<string>();
            int startIndex = 0;
            bool found = false;
            for (int i = 0; i < sqlText.Count && !found; i++)
            {
                string sqlLine = sqlText[i];
                string [] strBlock = sqlLine.Split(new char[]{' '}, StringSplitOptions.RemoveEmptyEntries);
                for(int j = 0; j < strBlock.Length; j++)
                {
                    if (strBlock[j].ToUpper() == "CREATE" &&
                        strBlock[j + 1].ToUpper() == "PROCEDURE" &&
                        strBlock[j + 2].ToLower().Contains(objName.ToLower()))
                    {
                        startIndex = i;
                        found = true;
                        break;
                    }
                }
            }

            for (int i = startIndex; i < sqlText.Count; i++)
            {
                retList.Add(sqlText[i]);
            }
            return retList;
        }
        #endregion

        #region ProcessDBDependence
        public static void ProcessDBDependence(List<string> dbObjectList, string fileNameToProcess, string sourcePath,
                                               string targetPath, List<string> dependObjectList = null)
        {
            if(dbObjectList.Count == 0)
            {
                return;
            }

            string[] fileTextInLine = File.ReadAllLines(fileNameToProcess);
            for(int i = 0; i < fileTextInLine.Length; i++)
            {
                string[] words = fileTextInLine[i].Split(new char[] { ' ', '.', ',', '(', ')', '[', ']'});
                for(int j = 0; j < words.Length; j++)
                {
                    if (dbObjectList.Contains(words[j].ToLower()))
                    {
                        string fileToProcess = FileUtil.FileUtility.CopyFileByName(sourcePath, targetPath, words[j]);
                        if(dependObjectList != null)
                        {
                            dependObjectList.Add(words[j]);
                        }
                        if (!string.IsNullOrEmpty(fileToProcess) && fileToProcess != fileNameToProcess)
                        {
                            ProcessDBDependence(dbObjectList, fileToProcess, sourcePath, targetPath, dependObjectList);
                        }
                    }
                }
            }
        }
        #endregion
    }

    public struct NameValuePair
    {
        public NameValuePair(string name, object value)
        {
            this.Name = name;
            this.Value = value;
        }

        public string Name;
        public object Value;
    }
}
