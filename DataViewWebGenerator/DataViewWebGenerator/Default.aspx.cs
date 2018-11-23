using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.XmlUtil;

namespace DataViewWebGenerator
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fnName = Request.QueryString["fn"];
            string dbName = Request.QueryString["db"];
            string dataViewName = Request.QueryString["v"];
            string resultContent = "";            
            if(fnName == "list")
            {
                resultContent = GetDataViewList(dbName);
                Response.Write(resultContent);
            }

            if(fnName == "gen")
            {
                resultContent = Generate(dataViewName);
                string shortFileName = "Rpt_" + dataViewName.Replace(" ", "") + ".sql";
                string fileName = MapPath("Generated") + "\\" + shortFileName;
                File.WriteAllText(fileName, resultContent);
                Response.AddHeader("Content-Disposition", "attachment; filename=" + shortFileName + ";");
                Response.TransmitFile(fileName);
                Response.Flush();
                Response.End();
                File.Delete(fileName);
            }
        }

        private string GetDataViewList(string dbName)
        {
            string errMsg = "";
            string htmlContent = "";

            string configFile = MapPath("AppSettings.xml");
            string server = XmlUtility.ReadNodeValue(configFile, "/Config/DBServer");
            string userId = XmlUtility.ReadNodeValue(configFile, "/Config/UserName");
            string password = XmlUtility.ReadNodeValue(configFile, "/Config/Password");

            string selectionCommand = @"SELECT DISTINCT ViewName AS DataViewName FROM WBDataView
WHERE ViewName IN (SELECT SourceName FROM WBDataViewLayout WHERE LayoutName = 'ReportOutput')
ORDER BY ViewName";
            MyController.BuildConnectionString(server, dbName, userId, password, false);
            DataTable dtDataView = MyController.LoadDataView(selectionCommand, out errMsg);
            string rowTemplate = "<a href=\"Default.aspx?fn=gen&v={1}\">{0}</a></br>";

            foreach(DataRow row in dtDataView.Rows)
            {
                string dvName = row[0].ToString();
                string encodedDvName = HttpUtility.UrlEncode(dvName);
                htmlContent += string.Format(rowTemplate, dvName, encodedDvName);
            }

            return htmlContent;
        }

        private string Generate(string dataViewName)
        {
            string templateFolder = MapPath("Templates");
            string fileContent = MyController.GenerateScript(templateFolder, dataViewName);
            return fileContent;
        }
    }
}