using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Net;
using System.Web;

namespace IDOTestClient
{
    public class IDOExecute
    {
        private JsonConvertion _jsonConvertion;
        public IDOExecute() {
            _jsonConvertion = new JsonConvertion();
        }

        public string GetToken(string machineName, string site,string userid,string password)
        {
            try
            {
                HttpWebRequest webRequest1 = WebRequest.CreateHttp("http://"+ machineName+"/IDORequestService/MGRestService.svc/json/token/" + site);
                webRequest1.Headers.Add("userid", userid);
                webRequest1.Headers.Add("password", password);
                webRequest1.PreAuthenticate = true;
                webRequest1.AllowAutoRedirect = false;
                webRequest1.Method = "GET";
                webRequest1.ContentType = "application/json; charset=utf-8";
                WebRequest.DefaultWebProxy = null;
                webRequest1.Proxy = null;
                WebResponse webResponse1 = webRequest1.GetResponse();
                var responseText1 = new StreamReader(webResponse1.GetResponseStream()).ReadToEnd();
                dynamic dynamicObject = Newtonsoft.Json.JsonConvert.DeserializeObject(responseText1);
                string token = ((Newtonsoft.Json.Linq.JValue)(((Newtonsoft.Json.Linq.JProperty)(((Newtonsoft.Json.Linq.JContainer)dynamicObject).Last)).Value)).Value.ToString();

                return token;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public List<DataTable> ExecuteCustomLoadMethod(string machineName, string idoName,string inputParms, string output, string method, string token)
        {
            string url = "/IDORequestService/MGRestService.svc/json/"+ idoName + "/" + output + "/adv/?customloadmethod=" + method + "&rowcap=0&customloadmethodparms=" + HttpUtility.UrlEncode(inputParms);

            HttpWebRequest webRequest = WebRequest.CreateHttp("http://"+ machineName + "/" + url);
            webRequest.Headers.Add("Authorization", token);
            webRequest.PreAuthenticate = true;
            webRequest.AllowAutoRedirect = false;
            webRequest.Method = "GET";
            webRequest.ContentType = "text/xml; charset=utf-8";
            webRequest.Timeout = 600000;
            WebRequest.DefaultWebProxy = null;
            webRequest.Proxy = null;
            WebResponse webResponse = webRequest.GetResponse();
            var responseText = new StreamReader(webResponse.GetResponseStream()).ReadToEnd();

            List<DataTable> lDataTables = _jsonConvertion.JsonToDataTable(responseText);

            return lDataTables;
        }

        public List<DataTable> ExecuteStandardMethod(string machineName, string idoName, string inputParms, string parmNames, string method, string token)
        {
            //json/method/Opportunities/GetDayofWeekAndMonth/?parms=9/4/2014,0,0,msg
            string url = "/IDORequestService/MGRestService.svc/json/method/" + idoName + "/" + method + "/?parms=" + inputParms;

            HttpWebRequest webRequest = WebRequest.CreateHttp("http://" + machineName + "/" + url);
            webRequest.Headers.Add("Authorization", token);
            webRequest.PreAuthenticate = true;
            webRequest.AllowAutoRedirect = false;
            webRequest.Method = "GET";
            webRequest.ContentType = "text/xml; charset=utf-8";
            webRequest.Timeout = 600000;
            WebRequest.DefaultWebProxy = null;
            webRequest.Proxy = null;
            WebResponse webResponse = webRequest.GetResponse();
            var responseText = new StreamReader(webResponse.GetResponseStream()).ReadToEnd();

            List<DataTable> lDataTables = _jsonConvertion.JsonToDataTable(responseText,2, parmNames);

            return lDataTables;
        }
    }
}
