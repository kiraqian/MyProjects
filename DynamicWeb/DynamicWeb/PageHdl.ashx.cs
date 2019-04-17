using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace DynamicWeb
{
    /// <summary>
    /// Summary description for PageHdl
    /// </summary>
    public class PageHdl : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string path = context.Server.MapPath("Connection.txt");
            string connString = File.ReadAllText(path);
            string pKey = context.Request.QueryString["pk"];

            DbAccess dbAccess = new DbAccess(connString);
            string content = dbAccess.GetContentByKey("html", pKey);

            context.Response.ContentType = "text/html";
            context.Response.Write(content);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}