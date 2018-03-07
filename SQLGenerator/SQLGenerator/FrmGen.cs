using System;
using System.Data;
using System.Windows.Forms;
using System.IO;
using Utility.SqlUtil;
using Utility.XmlUtil;

namespace SQLGenerator
{
    public partial class FrmGen : Form
    {
        #region Members
        private DataTable dtCfg;
        private string sqlConnString;
        #endregion

        #region Methods
        public FrmGen()
        {
            InitializeComponent();
            dtCfg = new DataTable("ConfigTable");
            dtCfg.Columns.Add("Selection");
            dtCfg.Columns.Add("TemplateFile");
            dtCfg.Columns.Add("OutputFile");
            dgvConfig.DataSource = dtCfg;
            dgvConfig.DataBindingComplete += DgvConfig_DataBindingComplete;

            try
            {
                dtCfg.ReadXml(Application.StartupPath + "\\CfgTable.xml");
                txtConnString.Text = XmlUtility.ReadNodeValue(Application.StartupPath + "\\Settings.xml", "./Settings/ConnectionString");
            }
            catch
            {

            }
        }

        private void GenSQLByRow(DataTable configTable, string connString)
        {
            string selectionCmd;
            string templateFile;
            string outputFile;
            string generatedSQLText = "";

            DataTable dtTableData;

            foreach (DataRow dr in configTable.Rows)
            {
                selectionCmd = dr["Selection"].ToString();
                templateFile = dr["TemplateFile"].ToString();
                outputFile = dr["OutputFile"].ToString();

                dtTableData = GetTableDataBySelection(connString, selectionCmd);
                generatedSQLText = GetGeneratedSQLText(dtTableData, templateFile);
                File.WriteAllText(outputFile, generatedSQLText);
            }
        }

        private string GetGeneratedSQLText(DataTable dtTableData, string templateFile)
        {
            string columnName;
            string cellData;
            string templateFileContent = File.ReadAllText(templateFile);
            string rowString = templateFileContent;
            string resultString = "";

            string replacePrefix = "[###";
            string replaceSuffix = "###]";

            foreach (DataRow dr in dtTableData.Rows)
            {
                foreach (DataColumn dc in dtTableData.Columns)
                {
                    columnName = dc.ColumnName;
                    if (Convert.IsDBNull(dr[columnName]))
                    {
                        cellData = "NULL";
                        rowString = rowString.Replace("N'" + replacePrefix + columnName + replaceSuffix + "'", cellData);
                        rowString = rowString.Replace("'" + replacePrefix + columnName + replaceSuffix + "'", cellData);
                    }
                    else
                    {
                        cellData = dr[columnName].ToString().Replace("'", "''");
                        rowString = rowString.Replace(replacePrefix + columnName + replaceSuffix, cellData);
                    }
                }

                resultString += rowString;
                rowString = templateFileContent;
            }
            return resultString;
        }

        private DataTable GetTableDataBySelection(string connString, string selectionCmd)
        {
            string errMsg;
            DataTable dtData = SqlUtility.QueryDBData(connString, selectionCmd, out errMsg);
            return dtData;
        }
        #endregion

        #region Event Handle
        private void DgvConfig_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            foreach(DataGridViewColumn column in dgvConfig.Columns)
            {
                DataGridViewTextBoxColumn txtColumn = (DataGridViewTextBoxColumn)column;
                txtColumn.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            }
        }

        private void FrmGen_Load(object sender, EventArgs e)
        {
            dgvConfig.AutoResizeColumns(DataGridViewAutoSizeColumnsMode.DisplayedCells);
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                sqlConnString = txtConnString.Text;
                GenSQLByRow(dtCfg, sqlConnString);
                MessageBox.Show("All Completed!");
            }
            catch(Exception exp)
            {
                MessageBox.Show(exp.Message);
            }
        }

        

        private void FrmGen_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                dtCfg.WriteXml(Application.StartupPath + "\\CfgTable.xml");
                XmlUtility.WriteNodeValue(Application.StartupPath + "\\Settings.xml", "./Settings/ConnectionString", txtConnString.Text);
            }
            catch
            {

            }
        }
        #endregion
    }
}
