using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace DynamicWeb
{
    /// <summary>
    /// Summary description for SvrMtd
    /// </summary>
    public class SvrMtd : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string path = context.Server.MapPath("Connection.txt");
            string connString = File.ReadAllText(path);
            string pKey = context.Request.QueryString["pk"];
            string className = context.Request.QueryString["c"];
            string methodName = context.Request.QueryString["m"];
            string parameters = context.Request.QueryString["p"];
            string[] ps = parameters.Split(new char[] { ',' });
            object[] parms = new object[ps.Length];
            for(int i = 0; i < ps.Length; i++)
            {
                parms[i] = ps[i];
            }

            DbAccess dbAccess = new DbAccess(connString);
            string csCode = dbAccess.GetContentByKey("csharp", pKey);
            string ret = CodeHelper.InvokeServerMethod(csCode, className, methodName, parms);

            context.Response.ContentType = "text/plain";
            context.Response.Write(ret);
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