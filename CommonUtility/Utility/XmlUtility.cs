using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Xml;
using System.IO;

namespace Utility.XmlUtil
{
    public class XmlUtility
    {
        #region ReadNodeValue
        public static string ReadNodeValue(string xmlFileName, string xPath)
        {
            string nodeValue = "";

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(xmlFileName);

            XmlNode xmlNode = xmlDoc.SelectSingleNode(xPath);
            if (xmlNode != null)
            {
                nodeValue = xmlNode.InnerText;
            }

            return nodeValue;
        }
        #endregion

        #region WriteNodeValue
        public static bool WriteNodeValue(string xmlFileName, string xPath, string value)
        {
            bool success = false;

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(xmlFileName);

            XmlNode xmlNode = xmlDoc.SelectSingleNode(xPath);
            if (xmlNode != null)
            {
                xmlNode.InnerText = value;
                xmlDoc.Save(xmlFileName);
                success = true;
            }

            return success;
        }
        #endregion
    }
}
