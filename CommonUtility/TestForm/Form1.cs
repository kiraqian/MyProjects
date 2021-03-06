﻿using System;
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
        DataTable dt = new DataTable();
        public Form1()
        {
            InitializeComponent();
            txtSourcePath.Text = @"D:\Temp\SP";
            txtOutputPath.Text = @"D:\Temp\Output";
            txtExpPath.Text = "";
            txtConnString.Text = @"Server=USCOVWSL901DB\sl901_2016;Database=CSI_Demo_App;User Id=sa;Password=Sl901#";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sourcePath = @"D:\Files\Code\Development\csi";
            string targetPath = @"D:\Temp\Output\Dep";
            string connString = @"Server=USCOVWCS10DB.infor.com;Database=RS8380_CSI10;Trusted_Connection=True;";
            string errMsg = "";
            //List<string> spAndFun = SqlUtility.GetAllSPAndFunNameInDB(connString, out errMsg);
            //List<string> views = SqlUtility.GetAllViewInDB(connString, out errMsg);
            //List<string> objList = new List<string>();
            //objList.AddRange(spAndFun);
            //objList.AddRange(views);

            List<string> depObjList = new List<string>();
            //depObjList.Add("acctdsp");
            List<string> objToProcess = new List<string>();
            objToProcess.Add("AcctDSp");
            //SqlUtility.ProcessDBDependence(objList, @"D:\Temp\Output\AcctDSp.sp", sourcePath, targetPath, depObjList);
            //dt = SqlUtility.GetDBDependenceByObject(connString, "AcctDSp");
            //dataGridView1.DataSource = dt;
            //SqlUtility.ProcessDependence(connString, txtSQL.Text, sourcePath, targetPath);

            //SqlUtility.ProcessDependenceRecursive(connString, objToProcess, sourcePath, targetPath, depObjList);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string connString = txtConnString.Text;
            string sourcePath = txtSourcePath.Text;
            string targetPath = txtOutputPath.Text;
            Ctrl ctrlClass = new Ctrl(connString);
            ctrlClass.SetPath(sourcePath, targetPath);
            ctrlClass.ProcessAllSP();
        }
    }
}
