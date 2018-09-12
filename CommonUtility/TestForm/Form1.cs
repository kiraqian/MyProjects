using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using Utility.FileUtil;
using Utility.SqlUtil;
using Utility.StringUtil;
using Utility.XmlUtil;

using Utility.SqlUtil;
using Utility.SourceControl;

namespace TestForm
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sourcePath = @"D:\Files\Code\Development\csi";
            string targetPath = @"D:\Temp\Output\Dep";
            string connString = @"Server=USCOVWCS10DB.infor.com;Database=RS8380_CSI10;Trusted_Connection=True;";
            string errMsg = "";
            List<string> spAndFun = SqlUtility.GetAllSPAndFunNameInDB(connString, out errMsg);
            List<string> views = SqlUtility.GetAllViewInDB(connString, out errMsg);
            List<string> objList = new List<string>();
            objList.AddRange(spAndFun);
            //objList.AddRange(views);

            SqlUtility.ProcessDBDependence(objList, @"D:\Temp\Output\RS8380_PermissionsPurchasing.sql", sourcePath, targetPath);
        }
    }
}
