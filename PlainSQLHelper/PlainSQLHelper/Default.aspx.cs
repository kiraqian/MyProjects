using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.SqlUtil;
using Utility.XmlUtil;

namespace PlainSQLHelper
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string objName = Request.QueryString["objname"];
            int lvNum;
            if(!int.TryParse(Request.QueryString["lv"], out lvNum) || lvNum <= 0)
            {
                lvNum = 3;
            }
            string filePath = MapPath("Settings.xml");
            string server = XmlUtility.ReadNodeValue(filePath, "/Settings/Server");
            string userId = XmlUtility.ReadNodeValue(filePath, "/Settings/UserID");
            string password = XmlUtility.ReadNodeValue(filePath, "/Settings/Password");
            string database = XmlUtility.ReadNodeValue(filePath, "/Settings/DB");
            string connString = SqlUtility.CreateConnectionString(server, database, userId, password);
            string errMsg = "";
            string xmlContent = SqlUtility.GetPlainSQLText(connString, objName, lvNum, out errMsg);
            Response.Write(xmlContent);
        }
    }
}