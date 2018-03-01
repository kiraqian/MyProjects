using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using Utility.FileUtil;
using Utility.StringUtil;

namespace StringReplace
{
    public partial class StringReplace : Form
    {
        private DataTable dtReplaceList;
        private DataTable dtResults;

        public StringReplace()
        {
            InitializeComponent();
            Init();
        }

        private void Init()
        {
            dtReplaceList = new DataTable();
            dtReplaceList.Columns.Add("OriginalString");
            dtReplaceList.Columns.Add("NewString");
            dgvRepList.DataSource = dtReplaceList;
            dgvRepList.Columns[0].DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            dgvRepList.Columns[1].DefaultCellStyle.WrapMode = DataGridViewTriState.True;

            dtResults = new DataTable();
            dtResults.Columns.Add("FileName");
            dtResults.Columns.Add("Status");
            dgvResults.DataSource = dtResults;
            dgvResults.AllowUserToAddRows = false;
        }

        private void btnLoadFiles_Click(object sender, EventArgs e)
        {
            dtResults.Rows.Clear();
            string[] fileList = FileUtility.GetFileList(txtInputFolder.Text, "*.*", true);
            foreach (string file in fileList)
            {
                dtResults.Rows.Add(file, "");
            }
        }

        private void btnReplace_Click(object sender, EventArgs e)
        {
            int i = 0;
            progressBar.Maximum = dtResults.Rows.Count;
            foreach (DataRow dr in dtResults.Rows)
            {
                try
                {
                    string fileName = dr["FileName"].ToString();
                    string content = File.ReadAllText(fileName);
                    string outputContent = content;
                    int modified = 0;
                    foreach (DataRow drRep in dtReplaceList.Rows)
                    {
                        string originalString = drRep["OriginalString"].ToString();
                        string newString = drRep["NewString"].ToString();
                        
                        modified += Tool.StringReplace(outputContent, originalString, newString, out outputContent, 
                                                       ckCaseSensitive.Checked, ckMatchWholeWord.Checked);
                    }

                    if (modified > 0)
                    {
                        Tool.SaveFile(fileName.Replace(txtInputFolder.Text, txtOutputFolder.Text), outputContent);
                        dr["Status"] = "Modified";
                    }
                    else
                    {
                        if (!ckOutputOnlyModified.Checked)
                        {
                            Tool.SaveFile(fileName.Replace(txtInputFolder.Text, txtOutputFolder.Text), content);
                        }
                        dr["Status"] = "Unchanged";
                    }
                }
                catch(Exception exp)
                {
                    dr["Status"] = exp.Message;
                }

                i++;
                progressBar.Value = i;
                dgvResults.Refresh();
                progressBar.Refresh();
                Application.DoEvents();                
            }

            MessageBox.Show("Done!");
        }

        private void btnPasteData_Click(object sender, EventArgs e)
        {
            List<string> lstColumnName = new List<string>();
            lstColumnName.Add("OriginalString");
            lstColumnName.Add("NewString");
            dtReplaceList = Tool.PasteExcelDataToDataTable(lstColumnName);
            dgvRepList.DataSource = dtReplaceList;
        }

        private void btnUnitTest_Click(object sender, EventArgs e)
        {
            string originalString = @"Basically I want to replace whole words, but not partial matches.
NOTE: I am going to have to use VB for this (SSRS 2008 code), but C# is my normal language, so responses in either are fine.";
            string replacedString;
            int ret = Tool.StringReplace(originalString, "Basically", "Modify", out replacedString, ckCaseSensitive.Checked, ckMatchWholeWord.Checked);
            MessageBox.Show(replacedString);
        }
    }
}
