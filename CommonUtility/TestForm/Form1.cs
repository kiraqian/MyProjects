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
            DataTable dt = SqlUtility.GetDatabaseNameList("USCOVWCS10DB.infor.com", "sa", "SL", true);
        }
    }
}
