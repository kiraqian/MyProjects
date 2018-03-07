using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;

using SQLRunner.Ctrl;
using System.IO;

namespace SQLRunner
{
    public partial class SQLRunner : Form
    {
        private DataTable dtResults;

        #region Methods
        public SQLRunner()
        {
            InitializeComponent();
            Init();
        }

        private void Init()
        {
            StartPosition = FormStartPosition.CenterScreen;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;

            dtResults = new DataTable();
            dtResults.Columns.Add("FileName");
            dtResults.Columns.Add("Status");
            dtResults.Columns.Add("ErrorMessage");
            dgvResults.DataSource = dtResults;
            dgvResults.AllowUserToAddRows = false;

            cmbDatabase.AutoCompleteSource = AutoCompleteSource.ListItems;
            cmbDatabase.AutoCompleteMode = AutoCompleteMode.Append;

            string serverName = "";
            string DBName = "";
            string userName = "";
            string password = "";
            string folderPath = "";

            try
            {
                Controller.LoadSettings(Application.StartupPath + "\\" + "AppSettings.xml", out serverName,
                    out DBName, out userName, out password, out folderPath);
            }
            catch (Exception exp)
            {
                MessageBox.Show(exp.Message);
            }

            txtServer.Text = serverName;
            cmbDatabase.Text = DBName;
            txtUserName.Text = userName;
            txtPassword.Text = password;
            txtFolderPath.Text = folderPath;
        }

        private string GetPreOrAfterRunScriptContent(string preOrAfterScriptFileName)
        {
            string content = string.Empty;
            try
            {
                content = File.ReadAllText(preOrAfterScriptFileName);
            }
            catch (Exception exp)
            {

            }
            return content;
        }

        private void UpdateDBList()
        {
            List<string> dbNameList = Controller.GetDBNameList(txtServer.Text, txtUserName.Text, txtPassword.Text);
            cmbDatabase.DataSource = dbNameList;
        }
        #endregion

        #region Event Handle
        private void btnTestConnection_Click(object sender, EventArgs e)
        {
            string errMsg;
            
            if (Controller.TestConnection(txtServer.Text, cmbDatabase.Text, txtUserName.Text, txtPassword.Text, out errMsg))
            {
                MessageBox.Show("Test success");
            }
            else
            {
                MessageBox.Show(errMsg);
            }
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            if (txtFolderPath.Text.Trim() == string.Empty)
            {
                return;
            }
            dtResults.Rows.Clear();
            try
            {
                Controller.LoadFiles(txtFolderPath.Text, dtResults);
            }
            catch (Exception exp)
            {
                MessageBox.Show(exp.Message);
            }
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            Controller.BuildDBConnectionString(txtServer.Text, cmbDatabase.Text, txtUserName.Text, txtPassword.Text, ckWinAuth.Checked);
            if (dtResults == null || dtResults.Rows.Count == 0)
            {
                return;
            }

            int totalCount = dtResults.Rows.Count;
            int errCount = 0;
            progressBar.Maximum = totalCount - 1;
            DateTime startTime = System.DateTime.Now;

            string preRunScriptContent = "";
            string afterRunScriptContent = "";

            if(ckPreRun.Checked == true)
            {
                preRunScriptContent = GetPreOrAfterRunScriptContent(Application.StartupPath + "\\" + "PreRunSQL.sql");
            }

            if (ckAfterRun.Checked == true)
            {
                afterRunScriptContent = GetPreOrAfterRunScriptContent(Application.StartupPath + "\\" + "AfterRunSQL.sql");
            }

            for (int i = 0; i < dtResults.Rows.Count; i++)
            {
                string errMsg = "";
                try
                {
                    errMsg = "";
                    string fileName = dtResults.Rows[i]["FileName"].ToString();
                    string fileContent = File.ReadAllText(fileName);
                    fileContent = preRunScriptContent + fileContent + afterRunScriptContent;
                    bool success = Controller.RunScript(fileName, fileContent, out errMsg);
                    if (success)
                    {
                        dtResults.Rows[i]["Status"] = "Success";
                    }
                    else
                    {
                        dtResults.Rows[i]["Status"] = "Failed";
                        dtResults.Rows[i]["ErrorMessage"] = errMsg;
                        errCount += 1;
                    }
                }
                catch (Exception exp)
                {
                    errMsg += exp.Message;
                    dtResults.Rows[i]["Status"] = "Failed";
                    dtResults.Rows[i]["ErrorMessage"] = errMsg;
                    errCount += 1;
                }

                progressBar.Value = i;
                Application.DoEvents();
            }

            MessageBox.Show("Execute Completed!");
        }        

        private void cmbDatabase_DropDown(object sender, EventArgs e)
        {
            string selectedText = cmbDatabase.Text;
            UpdateDBList();
            cmbDatabase.Text = selectedText;
        }

        private void btnSelectDir_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog folderDlg = new FolderBrowserDialog();
            if (folderDlg.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtFolderPath.Text = folderDlg.SelectedPath;
            }
        }

        private void SQLRunner_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                Controller.SaveSettings(Application.StartupPath + "\\" + "AppSettings.xml", txtServer.Text,
                    cmbDatabase.Text, txtUserName.Text, txtPassword.Text, txtFolderPath.Text);
            }
            catch (Exception exp)
            {
                MessageBox.Show(exp.Message);
            }
        }
        #endregion
    }
}
