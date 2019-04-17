using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DynamicWeb
{
    public class DbAccess
    {
        private string _connString = "";

        public DbAccess(string connectionString)
        {
            _connString = connectionString;
        }

        public string GetContentByKey(string type, string key)
        {
            string contentString = "";
            using (SqlConnection sqlConn = new SqlConnection(_connString))
            {
                try
                {
                    sqlConn.Open();
                    string cmdText = "SELECT content FROM {0} WHERE pkey = '{1}'";
                    SqlDataAdapter sqlDa = new SqlDataAdapter("", sqlConn);
                    DataTable dt = new DataTable();

                    if (type == "html")
                    {
                        cmdText = string.Format(cmdText, "htmlpage", key);                        
                    }

                    if (type == "javascript")
                    {
                        cmdText = string.Format(cmdText, "jscode", key);                        
                    }

                    if(type == "csharp")
                    {
                        cmdText = string.Format(cmdText, "cscode", key);                        
                    }

                    sqlDa.SelectCommand.CommandText = cmdText;
                    sqlDa.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        contentString = dt.Rows[0][0].ToString();
                    }
                }
                catch(Exception exp)
                {
                    contentString = exp.Message;
                }
            }

            return contentString;
        }
    }
}