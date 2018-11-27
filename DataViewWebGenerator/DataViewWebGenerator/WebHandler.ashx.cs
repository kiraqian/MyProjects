using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using Utility.XmlUtil;

namespace DataViewWebGenerator
{
    /// <summary>
    /// Summary description for WebHandler
    /// </summary>
    public class WebHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string fnName = context.Request.QueryString["fn"];
            string dbName = context.Request.QueryString["db"];
            string dataViewName = context.Request.QueryString["v"];
            string resultContent = "";
            string configFile = context.Request.MapPath("AppSettings.xml");
            string templatePath = context.Request.MapPath("Templates");

            if (fnName == "list")
            {
                resultContent = GetDataViewList(dbName, configFile);
                context.Response.Write(resultContent);
            }

            if (fnName == "gen")
            {
                resultContent = Generate(dataViewName, templatePath);
                string shortFileName = "Rpt_" + dataViewName.Replace(" ", "") + ".sql";
                string fileName = context.Request.MapPath("Generated") + "\\" + shortFileName;
                File.WriteAllText(fileName, resultContent);
                context.Response.AddHeader("Content-Disposition", "attachment; filename=" + shortFileName + ";");
                context.Response.TransmitFile(fileName);
                context.Response.Flush();                
                File.Delete(fileName);
                context.Response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string GetDataViewList(string dbName, string appSettingsPath)
        {
            string errMsg = "";
            string htmlContent = "";

            string server = XmlUtility.ReadNodeValue(appSettingsPath, "/Config/DBServer");
            string userId = XmlUtility.ReadNodeValue(appSettingsPath, "/Config/UserName");
            string password = XmlUtility.ReadNodeValue(appSettingsPath, "/Config/Password");

            string selectionCommand = @"SELECT DISTINCT ViewName AS DataViewName FROM WBDataView
WHERE ViewName IN (SELECT SourceName FROM WBDataViewLayout WHERE LayoutName = 'ReportOutput')
ORDER BY ViewName";
            MyController.BuildConnectionString(server, dbName, userId, password, false);
            DataTable dtDataView = MyController.LoadDataView(selectionCommand, out errMsg);
            string rowTemplate = "<div class=\"row\">";
            rowTemplate += "   <a href=\"WebHandler.ashx?fn=gen&v={1}\">{0}</a>";
            rowTemplate += "</div>";

            foreach (DataRow row in dtDataView.Rows)
            {
                string dvName = row[0].ToString();
                string encodedDvName = HttpUtility.UrlEncode(dvName);
                htmlContent += string.Format(rowTemplate, dvName, encodedDvName);
            }

            return htmlContent;
        }

        private string Generate(string dataViewName, string templatePath)
        {
            string fileContent = MyController.GenerateScript(templatePath, dataViewName);
            return fileContent;
        }
    }
}