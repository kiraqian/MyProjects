using System.Collections.Generic;
using System.Data;
using System.Runtime.InteropServices;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace IDOTestClient
{
    public class JsonConvertion
    {
        public List<DataTable> JsonToDataTable(string sRet,int method=1,string sParmNames="")
        {
            JObject json = JObject.Parse(sRet);
            IEnumerable<JProperty> property = json.Properties();
            JArray ayItem = new JArray();
            JArray ayHead = new JArray();
            DataTable dtItems = new DataTable();
            DataTable dtHead = new DataTable();
            JObject jArrayHead = new JObject();
            foreach (JProperty item in property)
            {
                if (item.Name.Equals("Items"))
                {
                    //json
                    List<object> objs = JsonConvert.DeserializeObject<List<object>>(item.Value.ToString());
                    if(objs != null) {
                        foreach (JArray obj in objs)
                        {
                            JObject jArray = new JObject();

                            IEnumerable<JToken> child = obj.Children();
                            foreach (var jToken in child)
                            {
                                JProperty jProperty = null;
                                jProperty = new JProperty(((Newtonsoft.Json.Linq.JValue)jToken.First.First).Value.ToString(), ((Newtonsoft.Json.Linq.JValue)jToken.Last.Last).Value);
                                jArray.Add(jProperty);
                            }
                            ayItem.Add(jArray);
                        }
                    }
                }
                else if (item.Name.Equals("Parameters"))
                {
                    List<object> objs = JsonConvert.DeserializeObject<List<object>>(item.Value.ToString());
                    string[] split = sParmNames.Split(',');
                    JObject jArray = new JObject();
                    for (int i = 0; i < split.Length; i++)
                    {
                        JProperty jProperty=new JProperty(split[i], objs[i].ToString());
                        jArray.Add(jProperty);
                    }
                    ayItem.Add(jArray);
                }
                else
                {
                    JProperty jProperty = new JProperty(item.Name, item.Value);
                    jArrayHead.Add(jProperty);
                }
            }
            ayHead.Add(jArrayHead);
            dtHead = JsonConvert.DeserializeObject<DataTable>(ayHead.ToString());
            dtHead.TableName = "Head";
            DataTable dtJson = JsonConvert.DeserializeObject<DataTable>(ayItem.ToString());            
            dtItems = dtJson;
            dtItems.TableName = "Items";
            //string revert=JsonConvert.SerializeObject(dtItems);
            List<DataTable> retTables = new List<DataTable> { dtHead, dtItems };
            return retTables;
        }
    }
}
