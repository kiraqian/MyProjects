using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Xml;

namespace DataBuilder
{
    public class Functions
    {
        public DataTable QueryTableData(string connString, string queryCmd, out string errMsg)
        {
            DataTable tableData = new DataTable();
            errMsg = string.Empty;
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(connString))
                {
                    sqlConn.Open();
                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(queryCmd, sqlConn);
                    tableData.Rows.Clear();
                    tableData.Columns.Clear();
                    sqlDataAdapter.Fill(tableData);
                    sqlConn.Close();
                }
            }
            catch (Exception ex)
            {
                errMsg = ex.Message;
            }
            return tableData;
        }

        public bool IsSystemColumns(string columnName)
        {
            string[] systemColumnList = new string[] { "NoteExistsFlag", "InWorkflow", "RowPointer", "RecordDate", "CreateDate", "CreatedBy", "UpdatedBy" };
            return systemColumnList.Contains(columnName);
        }

        public string GetTableFromQuery(string queryCmd)
        {
            string[] itemList = queryCmd.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < itemList.Length; i++)
            {
                if (itemList[i].Trim().ToUpper() == "FROM")
                {
                    return itemList[i + 1];
                }
            }
            return "";
        }

        public string GetValueByDataType(Type dataType, object value)
        {
            string valueStr;
            if (Convert.IsDBNull(value))
            {
                valueStr = "NULL";
                return valueStr;
            }

            if (dataType == typeof(string) || dataType == typeof(DateTime) || dataType == typeof(Guid))
            {
                valueStr = Convert.ToString(value).Replace("'", "''");
                valueStr = $"'{valueStr}'";
            }
            else if (dataType == typeof(byte[]))
            {
                valueStr = $"'{Convert.ToBase64String((byte[])value)}'";
            }
            else
            {
                valueStr = $"{value}";
            }

            return valueStr;
        }

        public string GetConnectionString(string server, string dbName, string userId, string password, bool trustedConnection = false)
        {
            string connString;
            if (trustedConnection)
            {
                connString = $"Server = {server}; Database = {dbName}; Trusted_Connection = True;";
            }
            else
            {
                connString = $"Server = {server};Database = {dbName}; User Id = {userId}; Password = {password};";
            }

            return connString;
        }

        public void GetConfig(string configFile, out string server, out string dbName, out string userId, out string password, out bool trustedConnection)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(configFile);
            server = xmlDoc.SelectSingleNode("/Config/Server").InnerText;
            dbName = xmlDoc.SelectSingleNode("/Config/DBName").InnerText;
            userId = xmlDoc.SelectSingleNode("/Config/UserId").InnerText;
            password = xmlDoc.SelectSingleNode("/Config/Password").InnerText;
            trustedConnection = Convert.ToBoolean(xmlDoc.SelectSingleNode("/Config/TrustedConnection").InnerText);
        }
    }
}
