using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MultiSiteInOneDBTools
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            txtSourcePath.Text = @"D:\Temp\SP";
            txtOutputPath.Text = @"D:\Temp\Output";
            txtExpPath.Text = @"D:\Temp\Exception";
        }

        private void btnProcessReport_Click(object sender, EventArgs e)
        {
            UtilCls utilCls = new UtilCls(txtSourcePath.Text, txtOutputPath.Text, txtExpPath.Text);
            utilCls.ProcessSSRSFiles();
        }

        private void btnProcessSp_Click(object sender, EventArgs e)
        {
            string connStr = @"Server=CNSHDLQIAN02;Database=ISM530_App;User Id=sa;Password=Myproduct.com;";
            //string connStr = @"Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;";
            UtilCls utilCls = new UtilCls(txtSourcePath.Text, txtOutputPath.Text, txtExpPath.Text, connStr);
            utilCls.ProcessStoredProcedures();
        }

        private void btnProcessTrigger_Click(object sender, EventArgs e)
        {
            string connStr = @"Server=USCOVWCS10DB.infor.com;Database=RS8380_CSI10;Trusted_Connection=True;";
            //string connStr = @"Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;";
            UtilCls utilCls = new UtilCls(txtSourcePath.Text, txtOutputPath.Text, txtExpPath.Text, connStr);
            utilCls.ProcessTriggers();
        }
    }
}
